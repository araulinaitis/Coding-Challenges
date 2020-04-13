classdef Player < handle
    properties
        x
    end
    
    properties(Access = private)
        width
        height
        y
        bullets = {};
    end
    
    methods
        function obj = Player(x)
            global worldHeight
            obj.x = x;
            obj.y = worldHeight - 4;
            obj.width = 10;
            obj.height = 4;
        end
        
        function move(obj, keystroke)
            switch keystroke
                case ''
                case 'leftarrow'
                    obj.x = obj.x - 1;
                case 'rightarrow'
                    obj.x = obj.x + 1;
            end
            
            i = 1;
            while i <= size(obj.bullets, 1)
                obj.bullets
%                 i
                if obj.bullets{i}.getPos < 2
                    % kill it
                    obj.bullets(i) = [];
                else
                    obj.bullets{i}.move;
                    i = i + 1;
                end
            end
        end
        
        function fire(obj)
            obj.bullets = [obj.bullets; {Bullet(obj.x)}];
        end
        
        function draw(obj)
            global world
            world(round(obj.y - obj.height / 2) : round(obj.y + obj.height / 2), round(obj.x - obj.width / 2) : round(obj.x + obj.width / 2) , :) = 1;
            
            for i = 1:size(obj.bullets, 1)
                obj.bullets{i}.draw;
            end
        end
        
    end
    
end
