classdef Snake < handle
    properties
        head
        tail
        length
        dir
        tailIdx
    end
    
    methods
        function obj = Snake(x, y)
            obj.head = [x, y];
            obj.length = 0;
            obj.dir = [0, 0];
            obj.tail = [];
            obj.tailIdx = 1;
        end
        
        function grow(obj)
            obj.length = obj.length + 1;
            if obj.length == 1
                obj.tail = obj.head
            else
                obj.tail =[obj.tail; obj.tail(obj.tailIdx, :)];
            end
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
                    if sum(abs(obj.dir - [1, 0])) ~=0
                        obj.dir = [-1, 0];
                    end
                    assignin('base','keystroke','0')
                case 'downarrow'
                    if sum(abs(obj.dir - [-1, 0])) ~=0
                        obj.dir = [1, 0];
                    end
                    assignin('base','keystroke','0')
                case 'leftarrow'
                    if sum(abs(obj.dir - [0, 1])) ~=0
                        obj.dir = [0, -1];
                    end
                    assignin('base','keystroke','0')
                case 'rightarrow'
                    if sum(abs(obj.dir - [0, -1])) ~=0
                        obj.dir = [0, 1];
                    end
                    assignin('base','keystroke','0')
                otherwise
                    keyboard
            end
            
        end
        
        function out = getLength(obj)
            out = obj.length;
        end
        
        function out = touchesTail(obj, x, y)
            out = 0;
            for i = 1:obj.length
                if x == obj.tail(i, 1) && y == obj.tail(i, 2)
                    out = 1;
                    break
                end
            end
        end
        
        function move(obj)
            if obj.length ~= 0
                obj.tailIdx = mod((obj.tailIdx - 1) + 1, obj.length) + 1;
                obj.tail(obj.tailIdx, :) = obj.head;
            end
            
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