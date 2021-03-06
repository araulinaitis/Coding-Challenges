classdef Player < handle
    properties
        x
    end
    
    properties(Access = private)
        width
        height
        y
        bullets
        numBullets = uint16(0);
        vel = uint16(4);
    end
    
    methods
        function obj = Player(x)
            global worldHeight
            obj.x = uint16(x);
            obj.y = uint16(worldHeight - 4);
            obj.width = uint16(10);
            obj.height = uint16(4);
        end
        
        function move(obj, keystroke)
            global worldWidth
            switch keystroke
                case ''
                case 'leftarrow'
                    if obj.x - obj.width / 2 - obj.vel > 0
                        obj.x = obj.x - obj.vel;
                    end
                case 'rightarrow'
                    if obj.x + obj.width / 2 + obj.vel < worldWidth
                        obj.x = obj.x + obj.vel;
                    end
            end
            
            for i = 1:obj.numBullets
                obj.bullets(i).move;
            end
            
            i = 1;
            while i <= obj.numBullets
                if obj.bullets(i).getPos < 2
                    % kill it
                    obj.bullets(i) = [];
                    obj.numBullets = obj.numBullets - 1;
                else
                    i = i + 1;
                end
            end
        end
        
        function fire(obj)
            obj.bullets = [obj.bullets; Bullet(obj.x)];
            obj.numBullets = obj.numBullets + 1;
        end
        
        function [invaders, numInvaders] = checkHits(obj, invaders, numInvaders)
            
            i = 1;
            while i <= obj.numBullets
                thisBullet = obj.bullets(i);
                j = 1;
                while j <= numInvaders
                    
                    if invaders(j).checkBullet(thisBullet)
                        if invaders(j).getHealth
                            invaders(j).hit;
                        else
                            invaders(j) = [];
                            numInvaders = numInvaders - 1;
                        end
                        obj.bullets(i) = [];
                        obj.numBullets = obj.numBullets - 1;
                        break
                    else
                        j = j + 1;
                    end
                end
                
                i = i + 1;
            end
            
        end
        
        function draw(obj)
            global world
            world((obj.y - obj.height / 2) : (obj.y + obj.height / 2), (obj.x - obj.width / 2) : (obj.x + obj.width / 2) , :) = 1;
            
            for i = 1:obj.numBullets
                obj.bullets(i).draw;
            end
        end
        
    end
    
end
