classdef TreeNode < handle
    properties
        x
        y
        z
        r
        parent
        child
        attractors
        nextChildVec
        dead
    end
    
    properties(Access = private)
       s
    end
    
    methods
        function obj = TreeNode(x, y, z, r)
            obj.x = x;
            obj.y = y;
            obj.z = z;
            obj.r = r;
            obj.dead = 0;
            
            % make patch
            numPoints = 20;
            [xArr, yArr, zArr] = sphere(numPoints);
            
            xArr = r * xArr + x;
            yArr = r * yArr + y;
            zArr = r * zArr + z;
            
            obj.s = surf(xArr, yArr, zArr, 'FaceColor', '[.5882, .2941, 0]', 'FaceLighting', 'gouraud', 'EdgeColor', 'none');
            
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
                
                if length(obj.attractors) == 2
                    vec1 = [obj.attractors(1).x - obj.x, obj.attractors(1).y - obj.y, obj.attractors(1).z - obj.z];
                    vec2 = [obj.attractors(2).x - obj.x, obj.attractors(2).y - obj.y, obj.attractors(2).z - obj.z];
                    
                    vec1 = vec1 / sqrt(sum(vec1 .* vec1));
                    vec2 = vec2 / sqrt(sum(vec2 .* vec2));
                    
                    if abs(dot(vec1, vec2) - (-1)) < 0.1
                        obj.attractors = [];
                        obj.dead = 1;
                        obj.nextChildVec = [];
                        return
                    end
                end
                for i = 1:length(obj.attractors)
                    
                    thisVec = [obj.attractors(i).x - obj.x, obj.attractors(i).y - obj.y, obj.attractors(i).z - obj.z];
                    thisVec = thisVec / sqrt(sum(thisVec .* thisVec));
                    
                    vecList = [vecList; thisVec];
                end
                
                % find average of vectors
                
                avgVec = mean(vecList, 1);
                avgVec = avgVec / sqrt(sum(avgVec .* avgVec));
                
                obj.nextChildVec = avgVec;
                
            else
                obj.dead = 1;
                obj.nextChildVec = [];
            end
        end
        
        function newNode = makeChild(obj)
            if ~isempty(obj.nextChildVec)
                newNode = TreeNode(obj.x + 2 * obj.r * obj.nextChildVec(1), obj.y + 2 * obj.r * obj.nextChildVec(2), obj.z + 2 * obj.r * obj.nextChildVec(3), obj.r);
                obj.s.FaceColor = [.4882, .2941, 0];
            else
                newNode = [];
            end
        end
        
    end
end



























