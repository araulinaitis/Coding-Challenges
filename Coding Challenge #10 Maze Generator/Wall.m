classdef Wall < handle
    properties
        cell1
        cell2
    end
    
    properties(Access = private)
        l
    end
    
    methods
        function obj = Wall(cell1, cell2, loc)
            % loc is wrt cell1
            obj.cell1 = cell1;
            obj.cell2 = cell2;
            
            cellSize = cell1.cellSize;
            
            switch loc
                case "n"
                    x1 = cellSize * (cell1.x - 1);
                    y1 = cellSize * (cell1.y - 1);
                    x2 = cellSize * cell1.x;
                    y2 = y1;
                case "s"
                    x1 = cellSize * (cell1.x - 1);
                    y1 = cellSize * cell1.y;
                    x2 = cellSize * cell1.x;
                    y2 = y1;
                case "e"
                    x1 = cellSize * cell1.x;
                    y1 = cellSize * (cell1.y - 1);
                    x2 = x1;
                    y2 = cellSize * cell1.y;
                case "w"
                    x1 = cellSize * (cell1.x - 1);
                    y1 = cellSize * (cell1.y - 1);
                    x2 = x1;
                    y2 = cellSize * cell1.y;
            end
            
            obj.l = line([x1; x2], [y1; y2], 'Color', 'k');
        end
        
        function deleteWall(obj)
            delete(obj.l);
%             drawnow
%             evalin('base', 'writeVideo(writerObj, getframe(gcf))', 'lineWidth', 2)
        end
        
    end
end

