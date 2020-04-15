clear all; clc; close all;

keystroke='';
fh = figure('units','pixels',...
    'keypressfcn',@f_capturekeystroke,...
    'KeyReleaseFcn', @f_releaseKey,...
    'HitTest', 'off');

ah = axes;
set(ah, 'HitTest', 'off', 'ButtonDownFcn',@(~,~)disp('axes'));

axis equal

worldWidth = 1000;
worldHeight = 1000;

world = zeros(worldHeight, worldWidth, 3);

color = [0.9, 0.9, 0.9];
world(:, :, 1) = color(1);
world(:, :, 2) = color(2);
world(:, :, 3) = color(3);

image(ah, world, 'HitTest', 'off')
            
cells = [];
numCells = 0;
% Pre-populate a few cells
for i = 1:4
    numCells = numCells + 1;
    radius = randi([50, 100]);
    newX = randi([radius + 1, worldWidth - radius]);
    newY = randi([radius + 1, worldHeight - radius]);
    
    cells = [cells, Cell(newX, newY, radius)];
%     Cell(newX, newY, radius);
end

frameRate = 15;

writerObj = VideoWriter('Mitosis.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

% fps = uicontrol('Style', 'text',...
%     'String', num2str(0),...
%     'Position', [20 20 100 55],...
%     'ForegroundColor', 'g',...
%     'FontSize', 20);



% test = Cell(100, 150, 50, [0.9, 0.9, 0.9]);


while 1
% for i = 1:100
    startLoop = now;
%     image(ah, world, 'HitTest', 'off')
    
    for i = 1:numCells
        cells(i).jiggle(randi([0, 5]));
    end
    axis equal
    axis off
    drawnow
    if keystroke == "escape"
        break
    end
    
    
    writeVideo(writerObj, getframe(gcf))
    
    while (now - startLoop) * 10^5 < (1 / frameRate)
    end
%     set(fps, 'String', num2str(1/((now - startLoop) * 10^5)));
%     1/((now - startLoop) * 10^5)

end

close(writerObj)

% ~~~~~~~~~
% functions
% ~~~~~~~~~

function  f_capturekeystroke(H,E)
% capturing and logging keystrokes
        assignin('base','keystroke',E.Key);
%         E.Key

end

function f_releaseKey(H, E)

end














