classdef CircleKeeper < handle
    properties
        circles
        xyArr
        rArr
        rSqArr
        baseImg
        maxR = 5;
    end
    
    properties(Access = private)
        xLim
        yLim
    end
    
    methods
        function obj = CircleKeeper(img)
            obj.circles = Circle.empty;
            obj.baseImg = img;
            
            obj.xLim = size(img, 2);
            obj.yLim = size(img, 1);
            
            % pre-populate one circle to make the add function easier/take
            % less logic
            
            
            % pick new point at random
            x = 0.5 + (obj.xLim - 1) * rand;
            y = 0.5 + (obj.yLim - 1) * rand;
            r = 0.1 + 5 * rand;
            
            % check image to see if point is valid
            while ~img(round(y), round(x))
                x = 0.5 + (obj.xLim - 1) * rand;
                y = 0.5 + (obj.yLim - 1) * rand;
            end
            
            
            obj.circles = [obj.circles, Circle(x, y, r)];
            obj.xyArr = [x, y];
            obj.rArr = r;
            obj.rSqArr = r * r;
            
        end
        
        function loopCnt = add(obj)
            % pick new point at random
            x = 0.5 + (obj.xLim - 1) * rand;
            y = 0.5 + (obj.yLim - 1) * rand;
            r = 0.2 + 5 * rand;
            
            % check other circles to make sure this is outside
            distSqArr = sum((obj.xyArr - [x, y]) .* (obj.xyArr - [x, y]), 2);
            
            loopCnt = 0;
            % check image to see if point is valid
            while ~obj.baseImg(round(y), round(x)) || sum(distSqArr < (r + obj.rArr).^2)
                x = 0.5 + (obj.xLim - 1) * rand;
                y = 0.5 + (obj.yLim - 1) * rand;
                r = 0.1 + obj.maxR * rand;
                
                % check other circles to make sure this is outside
                distSqArr = sum((obj.xyArr - [x, y]) .* (obj.xyArr - [x, y]), 2);
                loopCnt = loopCnt + 1;
            end
            
            % add new circle
            obj.circles = [obj.circles, Circle(x, y, r)];
            obj.xyArr = [obj.xyArr; x, y];
            obj.rArr = [obj.rArr; r];
            obj.rSqArr = [obj.rSqArr; r * r];
        end
        
    end
end



















