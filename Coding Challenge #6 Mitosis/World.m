classdef World < handle
    properties
        world
        cells
    end
    
    properties(Access = private)
        color
    end
    
    methods
        function obj = World(height, width, color)
            obj.world = zeros(height, width, 3);
            
            obj.world(:, :, 1) = color(1);
            obj.world(:, :, 2) = color(2);
            obj.world(:, :, 3) = color(3);
            
            obj.color = color;
            
        end
        
        function addCell(obj, x, y, r)
            obj.cells = [obj.cells, Cell(x, y, r)];
        end
        
        function draw(obj, thisFig)
           image(thisFig, obj.world);
           for i = 1:length(obj.cells)
            obj.cells(i).draw(thisFig);
           end
        end
        
    end
end