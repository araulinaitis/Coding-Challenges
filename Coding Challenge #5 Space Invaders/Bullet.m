classdef Bullet < handle
    properties
        x
        y
        health
    end
    
    properties(Access = private)
        width = 1;
        height = 1;
    end
    
    methods
        function obj = Bullet(x)
            global worldHeight
            obj.x = x;
            obj.y = worldHeight - 20;
            obj.health = 1;
        end
        
        function move(obj)
            obj.y = obj.y - 1;
        end
        
        function out = getPos(obj)
            out = obj.y;
        end
        
        function draw(obj)
            global world
            world(round(obj.y - obj.height / 2) : round(obj.y + obj.height / 2), round(obj.x - obj.width / 2) : round(obj.x + obj.width / 2) , :) = 1;
        end
        
    end
end