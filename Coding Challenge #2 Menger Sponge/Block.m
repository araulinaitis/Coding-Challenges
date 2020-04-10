classdef Block
    properties
        x;
        y;
        z;
        size;
    end
    
    properties(Access = private)
       xMat;
       yMat;
       zMat1;
       zMat2;
       cMat
       
    end
    
    methods
        function obj = Block(x, y, z, size)
            obj.x = x;
            obj.y = y;
            obj.z = z;
            obj.size = size;
            
            obj.xMat = [x - (size / 2), x + (size / 2); x - (size / 2), x + (size / 2)];
            obj.yMat = [y + (size / 2), y + (size / 2); y - (size / 2), y - (size / 2)];
            obj.zMat1 = (z - (size / 2)) * ones(2, 2);
            
            obj.zMat2 = (z + (size / 2)) * ones(2, 2);
            obj.cMat(:, :, 1) = 0.5 * ones(2, 2);
            obj.cMat(:, :, 2) = 0.5 * ones(2, 2);
            obj.cMat(:, :, 3) = 0.5 * ones(2, 2);
            
        end
        
        function draw(obj)
            
            % Draw Top wall
            surf(obj.xMat, obj.yMat, obj.zMat2, obj.cMat);
            % Draw Bottom wall
            surf(obj.xMat, obj.yMat, obj.zMat1, obj.cMat);
            % Draw North wall
            surf(obj.xMat, [obj.yMat(1,:); obj.yMat(1,:)], [obj.zMat1(1, :); obj.zMat2(1, :)], obj.cMat);
            % Draw South Wall
            surf(obj.xMat, [obj.yMat(2, :); obj.yMat(2, :)], [obj.zMat1(1, :); obj.zMat2(1, :)], obj.cMat);
            % Draw West Wall
            surf([obj.xMat(:, 1), obj.xMat(:, 1)], obj.yMat, [obj.zMat1(:, 1), obj.zMat2(:, 1)], obj.cMat);
            % Draw East Wall
            surf([obj.xMat(:, 2), obj.xMat(:, 2)], obj.yMat, [obj.zMat1(:, 1), obj.zMat2(:, 1)], obj.cMat);
        end
    end
end