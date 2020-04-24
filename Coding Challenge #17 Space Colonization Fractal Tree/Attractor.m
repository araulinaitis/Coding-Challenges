classdef Attractor < handle
    properties
        x
        y
        roi
        killDist
    end
    
    properties(Access = private)
        p
    end
    
    methods
        function obj = Attractor(x, y)
            obj.x = x;
            obj.y = y;
            obj.roi = 100;
            obj.killDist = 2;
            
            % make patch
            numPoints = 20;
            xArr = 1:numPoints;
            yArr = 1:numPoints;
            xArr = x + 0.5 * cos(xArr * 2 * pi / numPoints);
            yArr = y + 0.5 * sin(yArr * 2 * pi / numPoints);
            obj.p = patch(xArr, yArr, 'r');
            
        end
        
        function found = findClosestNode(obj, nodeArr)
            
            found = 0;
            minDist = Inf;
            
            for i = 1:length(nodeArr)
                thisDist = obj.findDist(nodeArr(i));
                if thisDist < minDist
                    minDist = thisDist;
                    minIdx = i;
                end
            end
            
            % Add this attractor to the node's list
            
            if minDist < obj.roi
                nodeArr(minIdx).addClosestAttractor(obj);
                found = 1;
            end
            
        end
        
        function dist = findDist(obj, node)
            dist = sqrt((obj.x - node.x) * (obj.x - node.x) + (obj.y - node.y) * (obj.y - node.y));
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
            delete(obj.p);
        end
        
    end
end















