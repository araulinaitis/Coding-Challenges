classdef Snake < handle
    properties
        head
        tail
    end
    
    properties(Access = private)
        length
        dir
        tailIdx
    end
    
    methods
        function obj = Snake(x, y)
            obj.head = [x, y];
            obj.length = 1;
            obj.dir = [1, 0];
            obj.tail = obj.head;
            obj.tailIdx = 1;
        end
        
        function grow(obj)
            obj.length = obj.length + 1;
            obj.tail =[obj.tail; obj.tail(obj.tailIdx, :)];
        end
        
        function out = checkTailCollision(obj)
            
            out = 0;
            
            for i = 1:obj.length
                if obj.head(1) == obj.tail(i, 1) && obj.head(2) == obj.tail(i, 2)
                    out = 1;
                    break
                end
            end
            
            
        end
        function setDir(obj, key)
            switch key
                case '0'
                case 'uparrow'
                    obj.dir = [-1, 0];
                case 'downarrow'
                    obj.dir = [1, 0];
                case 'leftarrow'
                    obj.dir = [0, -1];
                case 'rightarrow'
                    obj.dir = [0, 1];
                otherwise
                    keyboard
            end
            
        end
        
        function move(obj)
            
            obj.tailIdx = mod((obj.tailIdx - 1) + 1, obj.length) + 1;
            obj.tail(obj.tailIdx, :) = obj.head;
            
            obj.head = obj.head + obj.dir;
            
        end
        
        function pos = getPos(obj)
            pos = obj.head;
        end
        
        function draw(obj)
            global gBoard
            
            % draw tail
            for i = 1:obj.length
                gBoard(obj.tail(i, 1), obj.tail(i, 2), :) = 0.75;
            end
            
            % draw head
            gBoard(obj.head(1), obj.head(2), :) = 1;
            
        end
        
    end
    
end