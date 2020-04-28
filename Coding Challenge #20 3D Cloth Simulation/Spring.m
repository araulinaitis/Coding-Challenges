classdef Spring < handle
    properties
        point1
        point2
        k
        x0
        x
        l
        color = [0, 0, 0]
        force1
        force2
    end
    
    methods
        function obj = Spring(point1, point2, k)
            if nargin > 0
                obj.point1 = point1;
                obj.point2 = point2;
                
                obj.x = sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y) + (point1.z - point2.z) * (point1.z - point2.z));
                obj.x0 = obj.x;
                
                obj.k = k;
                obj.l = line([point1.x; point2.x], [point1.y; point2.y], [point1.z; point2.z], 'Color', obj.color, 'LineWidth', 2);
            end
        end
        
        function updateLength(obj)
            x1 = obj.point1.x;
            x2 = obj.point2.x;
            y1 = obj.point1.y;
            y2 = obj.point2.y;
            z1 = obj.point1.z;
            z2 = obj.point2.z;
            
            obj.l.XData = [x1, x2];
            obj.l.YData = [y1, y2];
            obj.l.ZData = [z1, z2];
            
            obj.x = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2));
            vec = [x2 - x1, y2 - y1, z2 - z1];
            vec = vec / sqrt(sum(vec .* vec));
            
            obj.force1 = obj.k * (obj.x - obj.x0) * vec;
            obj.force2 = -obj.force1;
%             
%             vec = [x1 - x2, y1 - y2];
%             vec = vec / sqrt(sum(vec .* vec));
%             
%             obj.force2 = obj.k * (obj.x0 - obj.x) .* vec;
            
            obj.applyForce;
            
        end
        
        function applyForce(obj)
            obj.point1.addConnectionForce(obj.force1);
            obj.point2.addConnectionForce(obj.force2);
        end
        
    end
end