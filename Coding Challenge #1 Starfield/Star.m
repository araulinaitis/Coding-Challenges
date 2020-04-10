classdef Star < handle
    properties
        x;
        y;
        z;
        v;
        tail;
    end
    
    methods
        function obj = Star(x, y, z, v)
            obj.x = x;
            obj.y = y;
            obj.z = z;
            obj.v = v;
            obj.tail = Tail(x, y);
        end
        
        function obj = update(obj, dt)
            obj.x = obj.x + obj.v(1) * dt;
            obj.y = obj.y + obj.v(2) * dt;
            obj.z = obj.z + obj.v(3) * dt;
            
            obj.v([1, 2]) = obj.v([1, 2]) * 1.5;
            
            obj.tail.update(obj.x, obj.y)
        end
        
        function draw(obj)
           plot(obj.x, obj.y, 'wo',...
               'MarkerSize', obj.z,...
               'MarkerFaceColor', [1, 1, 1])
           obj.tail.draw();
        end
            
    end
end