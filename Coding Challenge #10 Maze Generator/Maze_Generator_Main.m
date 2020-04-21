clear all; clc; close all
% https://en.wikipedia.org/wiki/Maze_generation_algorithm


figure('units', 'pixels');

worldWidth = 50;
worldHeight = 50;

frameRate = 60;

% writerObj = VideoWriter('MazeGenerator.avi');
% writerObj.FrameRate = frameRate;
% 
% open(writerObj);

% Initialize all cells

% cells(worldHeight, worldWidth) = MazeCell(worldWidth, worldHeight);
cells = MazeCell.empty;


for i = 1:worldWidth
    for j = 1:worldHeight
        cells(i, j) = MazeCell(j, i);
    end
end

% assign neighbors
for i = 1:worldWidth * worldHeight
    cells(i).assignNeighbors(cells, worldWidth, worldHeight);
end

% make walls between cells

for i = 1:worldWidth * worldHeight
    cells(i).makeWalls(cells)
end


startCellX = randi([1, worldWidth]);
startCellY = randi([1, worldHeight]);
axis equal
axis off

% mode = "recursion";
mode = "linked";

if mode == "recursion"
    cells(startCellY, startCellX).build();
    
elseif mode == "linked"
    
    activeCell = cells(startCellY, startCellX);
    while 1
        startLoop = now;
        
        activeCell.highlight
%         drawnow
        activeCell.visited = 1;
        
        
        if isempty(activeCell.order)
%             drawnow
            nextCell = activeCell.prev;
            if isempty(nextCell)
                break
            end
%             if nextCell.x - startCellX == 0 && nextCell.y - startCellY == 0 && isempty(nextCell.order)
%                 break
%             end
        else
            
            while ~isempty(activeCell.order)
                nextCellDir = activeCell.order(1);
                activeCell.order(1) = [];
                
                switch nextCellDir
                    case 1
                        if ~isempty(activeCell.north) && ~activeCell.north.visited
                            % delete wall
                            activeCell.nWall.deleteWall;
                            activeCell.nWall = [];
                            activeCell.north.sWall = [];
                            
                            nextCell = activeCell.north;
                            nextCell.prev = activeCell;
                            break
                            
                        end
                    case 2
                        if ~isempty(activeCell.south) && ~activeCell.south.visited
                            % delete wall
                            activeCell.sWall.deleteWall;
                            activeCell.sWall = [];
                            activeCell.south.nWall = [];
                            
                            nextCell = activeCell.south;
                            nextCell.prev = activeCell;
                            break
                        end
                    case 3
                        if ~isempty(activeCell.east) && ~activeCell.east.visited
                            % delete wall
                            activeCell.eWall.deleteWall;
                            activeCell.eWall = [];
                            activeCell.east.wWall = [];
                            
                            nextCell = activeCell.east;
                            nextCell.prev = activeCell;
                            break
                        end
                    case 4
                        if ~isempty(activeCell.west) && ~activeCell.west.visited
                            % delete wall
                            activeCell.wWall.deleteWall;
                            activeCell.wWall = [];
                            activeCell.west.eWall = [];
                            
                            nextCell = activeCell.west;
                            nextCell.prev = activeCell;
                            break
                        end
                end
            end
        end
        
        
%         drawnow
%                 writeVideo(writerObj, getframe(gcf))
        activeCell.dehighlight
        activeCell = nextCell;
        
        while (now - startLoop) * 10^5 < (1 / frameRate)
        end
    end
end

% for i = 1:500
%     writeVideo(writerObj, getframe(gcf))
% end
% close(writerObj)


















