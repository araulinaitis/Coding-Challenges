classdef Branch < handle
    properties
        startPt
        endPt
        angle
        length
        parent
        left
        right
    end
    
    properties(Access = private)
        l
        splitAngle = pi/6;
        lineThk
    end
    
    methods
        function obj = Branch(startPt, angle, length, lineThk)
            obj.startPt = startPt;
            obj.angle = angle;
            obj.length = length;
            obj.lineThk = lineThk;
            
            endX = startPt.x + length * cos(angle);
            endY = startPt.y + length * sin(angle);
            
            endPt = Point(endX, endY);
            
            obj.l = line([startPt.x, endX], [startPt.y, endY], 'color', 'k', 'LineWidth', lineThk);
%             evalin('base', 'writeVideo(writerObj, getframe(gcf))')
        end
        
        function split(obj)
            if ~isempty(obj.left)
                obj.left.split;
                obj.right.split;
            else
%             obj.length = 2 * obj.length / 3;
            obj.endPt.x = obj.startPt.x + obj.length * cos(obj.angle);
            obj.endPt.y = obj.startPt.y + obj.length * sin(obj.angle);
%             obj.updateLineObj;
            
            obj.left = Branch(obj.endPt, obj.angle + obj.splitAngle, 2 * obj.length / 3, obj.lineThk - 1);
            obj.right = Branch(obj.endPt, obj.angle - obj.splitAngle, 2 * obj.length / 3, obj.lineThk - 1);
            end
            
        end
        
        function updateLineObj(obj)
            obj.l.XData(2) = obj.endPt.x;
            obj.l.YData(2) = obj.endPt.y;
        end
    end
end