classdef Invader < handle
    properties
        x
        y
    end
    
    properties(Access = private)
        width = uint16(20);
        height = uint16(10);
        vel = uint16(2);
        dir = uint16(1);
        health;
        colors = {[.25, 0, 0],...
                  [0, .5, 0],...
                  [0, 0, .75],...
                  [1, 1, 1]};
    end
    
    methods
        function obj = Invader(x, y, health)
            obj.x = uint16(x);
            obj.y = uint16(y);
            obj.health = health;
        end
        
        function move(obj)
            if obj.dir
                obj.x = obj.x + obj.vel;
            else
                obj.x = obj.x - obj.vel;
            end
        end
        
        function out = getHealth(obj)
            out = obj.health;
        end
        
        function hit(obj)
            obj.health = obj.health - 1;
        end
        
        function nextLevel(obj)
            if obj.dir
                obj.dir = 0;
            else
                obj.dir = 1;
            end
            obj.y = obj.y + obj.width + 2;
        end
        
        function out = atEnd(obj, target)
            out = obj.x >= target - (obj.width / 2);
        end
        
        function out = atStart(obj, target)
            out = obj.x <= target + (obj.width / 2);
        end
        
        function out = atBottom(obj, target)
            out = obj.y >= target - (obj.height / 2);
        end
        
        function out = checkBullet(obj, bullet)
            out = bullet.y > obj.y - obj.height / 2 && bullet.y < obj.y + obj.height / 2 && bullet.x > obj.x - obj.width / 2 && bullet.x < obj.x + obj.width / 2;
        end
        
        function draw(obj)
            global world
            
            colorArr = obj.colors{obj.health + 1};
            world((obj.y - obj.height / 2) : (obj.y + obj.height / 2), (obj.x - obj.width / 2) : (obj.x + obj.width / 2) , 1) = colorArr(1);
            world((obj.y - obj.height / 2) : (obj.y + obj.height / 2), (obj.x - obj.width / 2) : (obj.x + obj.width / 2) , 2) = colorArr(2);
            world((obj.y - obj.height / 2) : (obj.y + obj.height / 2), (obj.x - obj.width / 2) : (obj.x + obj.width / 2) , 3) = colorArr(3);
        end
        
    end
end