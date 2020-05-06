classdef Blob < handle
    properties
        r
        g
        b
        count
        rad
    end
    
    properties(Access = private)
        s
    end
    
    methods
        function obj = Blob(r, g, b)
            obj.r = r;
            obj.g = g;
            obj.b = b;
            obj.count = 1;
            
%             obj.rad = 1;
%             [X, Y, Z] = sphere(5);
%             X = obj.rad * X + double(r);
%             Y = obj.rad * Y + double(g);
%             Z = obj.rad * Z + double(b);
            global axBot
%             obj.s = surf(axBot, X, Y, Z, 'FaceColor', [r, g, b], 'EdgeColor', 'none');
            plot3(r, g, b, 'Marker', '.', 'Color', [r, g, b])
        end
        
        function addCount(obj)
%             obj.count = obj.count + 1;
%             obj.rad = obj.rad + .01;
%             
%             % scale surface object
%             obj.s.XData = (obj.s.XData - double(obj.r)) * 1.1 + double(obj.r);
%             obj.s.YData = (obj.s.YData - double(obj.g)) * 1.1 + double(obj.g);
%             obj.s.ZData = (obj.s.ZData - double(obj.b)) * 1.1 + double(obj.b);
        end
            
    end
end
            