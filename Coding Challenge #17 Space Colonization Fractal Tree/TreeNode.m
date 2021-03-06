classdef TreeNode < handle
    properties
        x
        y
        r
        parent
        child
        attractors
        nextChildVec
    end
    
    properties(Access = private)
       p 
    end
    
    methods
        function obj = TreeNode(x, y, r)
            obj.x = x;
            obj.y = y;
            obj.r = r;
            
            % make patch
            numPoints = 20;
            xArr = 1:numPoints;
            yArr = 1:numPoints;
            xArr = x + r * cos(xArr * 2 * pi / numPoints);
            yArr = y + r * sin(yArr * 2 * pi / numPoints);
            obj. p = patch(xArr, yArr, 'g');
            
        end
        
        function addClosestAttractor(obj, attractor)
            obj.attractors = [obj.attractors, attractor];
        end
        
        function clearAttractors(obj)
            obj.attractors = [];
        end
        
        function findAverageVector(obj)
            if ~isempty(obj.attractors)
                % first find each vector
                vecList = [];
                for i = 1:length(obj.attractors)
                    
                    thisVec = [obj.attractors(i).x - obj.x, obj.attractors(i).y - obj.y];
                    thisVec = thisVec / sqrt(sum(thisVec .* thisVec));
                    
                    vecList = [vecList; thisVec];
                end
                
                % find average of vectors
                
                avgVec = mean(vecList, 1);
                avgVec = avgVec / sqrt(sum(avgVec .* avgVec));
                
                obj.nextChildVec = avgVec;
                
            else
                obj.nextChildVec = [];
            end
        end
        
        function newNode = makeChild(obj)
            if ~isempty(obj.nextChildVec)
                newNode = TreeNode(obj.x + 2 * obj.r * obj.nextChildVec(1), obj.y + 2 * obj.r * obj.nextChildVec(2), obj.r);
                obj.p.FaceColor = [.4882, .2941, 0];
            else
                newNode = [];
            end
        end
        
    end
end



























