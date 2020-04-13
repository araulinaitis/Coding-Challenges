classdef Drop < handle
    properties
        x
        y
        z % will determine size and speeds from z
        size
        speed
    end
    
    properties(Constant)
       color = [138/255, 43/255, 226/255]; 
    end
    
    methods
        function obj = Drop(x, y, z)
            obj.x = x;
            obj.y = y;
            obj.z = z;
            
            obj.size = round([5, 0.3] * map(z, 0, 5, 10, 1));
            obj.speed = round(5 * map(z, 0, 5, 10, 5));
            
        end
        
        function move(obj)
            obj.x = obj.x + obj.speed;
        end
        
        function out = getX(obj)
           out = obj.x; 
        end
        
        function draw(obj)
           global world
           
           world(obj.x:(obj.x + obj.size(1)), obj.y:(obj.y + obj.size(2)), 1) = obj.color(1);
           world(obj.x:(obj.x + obj.size(1)), obj.y:(obj.y + obj.size(2)), 2) = obj.color(2);
           world(obj.x:(obj.x + obj.size(1)), obj.y:(obj.y + obj.size(2)), 3) = obj.color(3);
           
        end
        
    end
end