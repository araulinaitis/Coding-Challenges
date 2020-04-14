classdef Bullet < handle
    properties
        x
        y
        health
    end
    
    properties(Access = private)
        width = uint16(1);
        height = uint16(1);
    end
    
    methods
        function obj = Bullet(x)
            global worldHeight
            obj.x = uint16(x);
            obj.y = uint16(worldHeight - 10);
            obj.health = 1;
        end
        
        function move(obj)
            obj.y = obj.y - 4;
        end
        
        function out = getPos(obj)
            out = obj.y;
        end
        
        function draw(obj)
            global world
            world((obj.y - obj.height / 2) : (obj.y + obj.height / 2), (obj.x - obj.width / 2) : (obj.x + obj.width / 2) , :) = 1;
        end
        
    end
end