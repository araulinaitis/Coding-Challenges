clear all; clc; close all;

figure('WindowState', 'maximized')
worldWidth = 400;
worldHeight = 400;
% axis([0, worldWidth, 0, worldHeight]);
axis equal
axis off
hold on
% axis manual

frameRate = 240;
writerObj = VideoWriter('L-System Fractal Tree.avi');
writerObj.FrameRate = frameRate;
open(writerObj);

numSplits = 5;

% Make L-System String
tree = 'F';
nextTree = '';
for idx = 1:numSplits
    i = 1;
    while i <= length(tree)
        %     for i = 1:length(tree)
        switch tree(i)
            case 'F'
                %                 nextTree = [nextTree, 'FF+[+F-F-F]-[-F+F+F]'];
                tree = [tree(1:(i - 1)), 'FF+[+F-F-F]-[-F+F+F]', tree((i + 1):end)];
                i = i + 20;
            otherwise
                i = i + 1;
        end
    end
    %     tree = nextTree;
end

% set up turtle

turtle = Turtle(worldWidth / 2, 0, tree);

% while 1
for idx = 1:length(tree)
%     startLoop = now;
    
    turtle.step;
    
%     drawnow
%     writeVideo(writerObj, getframe(gcf))
    
     disp(idx / (length(tree)));
    
%     while (now - startLoop) * 10^5 < (1 / frameRate)
%     end
end

for i = 1:(frameRate * 5)
    writeVideo(writerObj, getframe(gcf))
end

close(writerObj)