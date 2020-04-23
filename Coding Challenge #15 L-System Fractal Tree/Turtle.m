classdef Turtle < handle
    properties
        point
        dir
        curLoc
        savedLoc = [];
        savedDir = [];
        string
    end
    
    properties(Access = private)
       rightTurn
       leftTurn
    end
    
    methods
        function obj = Turtle(x, y, string)
            obj.point = [x, y];
            obj.string = string;
            obj.curLoc = 1;
            obj.dir = [0, 1];
            
            turnAngle = (25 * pi / 180);
            obj.leftTurn = [cos(turnAngle), -sin(turnAngle); sin(turnAngle), cos(turnAngle)];
            turnAngle = -turnAngle;
            obj.rightTurn = [cos(turnAngle), -sin(turnAngle); sin(turnAngle), cos(turnAngle)];
            
        end
        
        function step(obj)
            switch obj.string(obj.curLoc)
                case 'F'
                    lastPoint = obj.point;
                    obj.point = obj.point + obj.dir;
                    line([lastPoint(1), obj.point(1)], [lastPoint(2), obj.point(2)], 'color', 'k')
                    evalin('base', 'writeVideo(writerObj, getframe(gcf))');
                case '+'
                    obj.dir = (obj.rightTurn * obj.dir')';
                case '-'
                    obj.dir = (obj.leftTurn * obj.dir')';
                case '['
                    obj.savedLoc = [obj.savedLoc; obj.point];
                    obj.savedDir = [obj.savedDir; obj.dir];
                case ']'
                    obj.point = obj.savedLoc(end, :);
                    obj.savedLoc(end, :) = [];
                    obj.dir = obj.savedDir(end, :);
                    obj.savedDir(end, :) = [];
            end
            obj.curLoc = obj.curLoc + 1;
        end
        
    end
end

        