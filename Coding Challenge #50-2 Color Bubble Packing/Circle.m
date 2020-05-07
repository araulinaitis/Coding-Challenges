classdef Circle < handle
    properties
        x
        y
        r
        c
    end
    
    properties(Access = private)
        img
    end
    
    methods
        function obj = Circle(x, y, r, c)
            if nargin > 0
                obj.x = x;
                obj.y = y;
                obj.r = r;
                obj.c = c;
                
                points = linspace(0, 2 * pi, 20);
                xArr = x + r * cos(points);
                yArr = y + r * sin(points);
                
                obj.img = patch(xArr, yArr, c, 'EdgeColor', 'none');
                
            end
            
        end
        
        function draw(obj)
            points = linspace(0, 2 * pi, 20);
            xArr = obj.x + obj.r * cos(points);
            yArr = obj.y + obj.r * sin(points);
            
            plot(xArr, yArr, 'w');
            
        end
    end
end