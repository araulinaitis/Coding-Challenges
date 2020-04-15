classdef Cell < handle
    properties
        x
        y
        r
        children = [];
    end
    
    properties(Access = private)
        p
        color = [0.5, 0.75, 0.5];
    end
    
    methods
        function obj = Cell(x, y, r)
            obj.x = x;
            obj.y = y;
            obj.r = r;
            
            %            obj.imgX = x - r;
            %            obj.imgY = y - r;
            
            % make image points
            numPoints = 100;
            tempPoints = zeros(numPoints, 2);
            for i = 1:numPoints
                tempPoints(i, :) = [x + r * cos((i / numPoints) * 2 * pi), y + r * sin((i / numPoints) * 2 * pi)];
            end
            
            obj.p = patch(tempPoints(:, 1), tempPoints(:, 2), obj.color, 'PickableParts', 'all', 'HitTest', 'on', 'ButtonDownFcn', {@split, obj});
            
            function split(~, ~,thisObj)
                thisObj.addChild()
            end
            
        end
        
        function addChild(obj)
            
            angle = (2 * pi) * rand();
            for i = [angle, angle + pi]
                newX = obj.x + obj.r * cos(i) / 2;
                newY = obj.y + obj.r * sin(i) / 2;
                obj.children = [obj.children, Cell(newX, newY, obj.r / 2)];
            end
            
            delete(obj.p);
            obj.p = [];
            
        end
        
        
        function jiggle(obj, val)
            
            if ~isempty(obj.p)
                xJiggle = randi([-val, val]);
                yJiggle = randi([-val, val]);
                obj.p.Vertices(:, 1) = obj.p.Vertices(:, 1) + xJiggle;
                obj.p.Vertices(:, 2) = obj.p.Vertices(:, 2) + yJiggle;
                obj.x = obj.x + xJiggle;
                obj.y = obj.y + yJiggle;
            end
            
            for i = 1:length(obj.children)
                obj.children(i).jiggle(randi([0, val]))
            end
            %             obj.draw();
        end
        
        %         function split(obj)
        %             disp("I'm in split");
        %         end
        
        %         function draw(obj)
        %             obj.p = patch(obj.points(:, 1), obj.points(:, 2), obj.color, 'PickableParts', 'all', 'HitTest', 'on', 'ButtonDownFcn', @split);
        %             %             image('XData', obj.imgX, 'YData', obj.imgY, 'CData', obj.thisImg, 'ButtonDownFcn', @click)
        %         end
        
        
    end
end

