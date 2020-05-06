classdef Circle < handle
    properties
        x
        y
        r
    end
    
    properties(Access = private)
        img
    end
    
    methods
        function obj = Circle(x, y, r)
            if nargin > 0
                obj.x = x;
                obj.y = y;
                obj.r = r;
                
                points = linspace(0, 2 * pi, 20);
                xArr = x + r * cos(points);
                yArr = y + r * sin(points);
                
                obj.img = plot(xArr, yArr, 'w');
                
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