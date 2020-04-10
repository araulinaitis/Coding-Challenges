classdef Tail < handle
    properties
        points
    end
    methods
        function obj = Tail(x, y)
            obj.points = [x, y];
        end
        
        function update(obj, x, y)
            if size(obj.points, 1) > 2
                obj.points(1, :) = [];
            end
            obj.points = [obj.points; x, y];
        end
        
        function draw(obj)
            plot(obj.points(:, 1), obj.points(:, 2), 'w-', 'LineWidth', 0.5);
        end
    end
end