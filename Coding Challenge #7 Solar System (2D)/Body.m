classdef Body < handle
    properties
        x
        y
        r
        parent
        children = [];
    end
    
    properties(Access = private)
        p
        rotMat
    end
    
    methods
        function obj = Body(x, y, r, parent)
            obj.x = x;
            obj.y = y;
            obj.r = r;
            obj.parent = parent;
            
            % alpha is rotation speed (rad/simulation step), make it based on size
            if isempty(parent)
                dist = sqrt(x * x + y * y);
            else
                dist = sqrt((x - parent.x) * (x - parent.x) + (y - parent.y) * (y - parent.y));
            end
            alpha = 200/(r * dist);
            
            
            obj.rotMat = [cos(alpha), -sin(alpha); sin(alpha), cos(alpha)];
            
            numPoints = 50;
            xArr = zeros(numPoints, 1);
            yArr = xArr;
            for i = 1:numPoints
                xArr(i) = x + r * cos((i / numPoints) * 2 * pi);
                yArr(i) = y + r * sin((i / numPoints) * 2 * pi);
            end
            
            obj.p = patch(xArr, yArr, [1, 1, 1]);
            
        end
        
        function out = getCenter(obj)
            out = [obj.x, obj.y];
        end
        
        function addChild(obj)
            newR = randi(round([obj.r / 4, obj.r / 2]));
            angle = 2 * pi * rand();
            offset = randi([2 * (obj.r + newR), 5 * (obj.r + newR)]);
            newX = obj.x + offset * cos(angle);
            newY = obj.y + offset * sin(angle);
            
            newBody = Body(newX, newY, newR, obj);
            
            obj.children = [obj.children; newBody];
            
        end
        
        function rotateAboutPoint(obj, x, y, rotMat)
            
            xArr = [obj.p.Vertices(:, 1); obj.x];
            yArr = [obj.p.Vertices(:, 2); obj.y];
            
            xArr = xArr - (x);
            yArr = yArr - (y);
            
            rotArr = rotMat * [xArr'; yArr'];
            xArr = rotArr(1, :)';
            yArr = rotArr(2, :)';
            
            %move back
            xArr = xArr + (x);
            yArr = yArr + (y);
            
            % put arrays back
            obj.p.Vertices(:, 1) = xArr(1:(end - 1));
            obj.p.Vertices(:, 2) = yArr(1:(end - 1));
            
            % put x and y back
            obj.x = xArr(end);
            obj.y = yArr(end);
            
            for i = 1:length(obj.children)
                obj.children(i).rotateAboutPoint(x, y, rotMat);
            end
            
        end
        
        function rotate(obj)
            
            obj.rotateAboutPoint(obj.parent.x, obj.parent.y, obj.rotMat)
            
            for i = 1:length(obj.children)
                obj.children(i).rotate
            end
            
        end
        
    end
end





