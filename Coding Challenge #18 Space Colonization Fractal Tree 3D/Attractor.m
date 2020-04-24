classdef Attractor < handle
    properties
        x
        y
        z
        roi
        killDist
    end
    
    properties(Access = private)
        s
    end
    
    methods
        function obj = Attractor(x, y, z)
            obj.x = x;
            obj.y = y;
            obj.z = z;
            obj.roi = 50;
            obj.killDist = 5;
            r = 0.5;
            
            % make patch
            numPoints = 20;
            [xArr, yArr, zArr] = sphere(numPoints);
            
            xArr = r * xArr + x;
            yArr = r * yArr + y;
            zArr = r * zArr + z;
            
            obj.s = surf(xArr, yArr, zArr, 'FaceColor', '[1, 0, 0]', 'FaceLighting', 'gouraud', 'EdgeColor', 'none');
            
        end
        
        function found = findClosestNode(obj, nodeArr)
            
            found = 0;
            minDist = Inf;
            
            pointArr = zeros(length(nodeArr), 3);
            %             pointArr = [];
            % make array of all xyz points from node array
            for i = 1:length(nodeArr)
                thisNode = nodeArr(i);
                pointArr(i, :) = [thisNode.x, thisNode.y, thisNode.z];
                
            end
            
            thisArr = repmat([obj.x, obj.y, obj.z], size(pointArr, 1), 1);
            
            distArr = sqrt(sum((thisArr - pointArr(:, 1:3)) .* (thisArr - pointArr(:, 1:3)), 2));
            
            [minDist, minIdx] = min(distArr);
            
            %             for i = 1:length(nodeArr)
            %                 thisDist = obj.findDist(nodeArr(i));
            %                 if thisDist < minDist
            %                     minDist = thisDist;
            %                     minIdx = i;
            %                 end
            %             end
            
            % Add this attractor to the node's list
            
            if minDist < obj.roi
                nodeArr(minIdx).addClosestAttractor(obj);
                found = 1;
            end
            
        end
        
        function dist = findDist(obj, node)
            dist = sqrt((obj.x - node.x) * (obj.x - node.x) + (obj.y - node.y) * (obj.y - node.y) + (obj.z - node.z) * (obj.z - node.z));
        end
        
        function out = checkKillZone(obj, nodeArr)
            out = 0;
            for i = 1:length(nodeArr)
                thisDist = obj.findDist(nodeArr(i));
                if thisDist < obj.killDist
                    out = 1;
                    return
                end
            end
        end
        
        function kill(obj)
            delete(obj.s);
        end
        
    end
end















