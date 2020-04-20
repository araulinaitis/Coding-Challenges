clear all; clc; close all
% https://en.wikipedia.org/wiki/Maze_generation_algorithm


figure();

worldWidth = 20;
worldHeight = 20;

frameRate = 60;

writerObj = VideoWriter('MazeGenerator.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

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

% while 1
%     startTime = now;
    cells(startCellY, startCellX).build();
    
    drawnow
%     writeVideo(writerObj, getframe(gcf))
    
%     while (now - startLoop) * 10^5 < (1 / frameRate)
%     end
% end
for i = 1:500
    writeVideo(writerObj, getframe(gcf))
end
close(writerObj)