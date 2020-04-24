clear all; clc; close all;

figure('WindowState', 'maximized')
worldWidth = 400;
worldHeight = 400;
% axis([0, worldWidth, 0, worldHeight]);
axis equal
axis off
hold on
% axis manual

frameRate = 60;
writerObj = VideoWriter('L-System Fractal Tree.avi');
writerObj.FrameRate = frameRate;
open(writerObj);

numSplits = 5;

% Make L-System String
tree = 'F';
for idx = 1:numSplits
    
nextTree = '';
%     i = 1;
%     while i <= length(tree)
            for i = 1:length(tree)
        switch tree(i)
            case 'F'
                                nextTree = [nextTree, 'FF+[+F-F-F]-[-F+F+F]'];
%                 tree = [tree(1:(i - 1)), 'FF+[+F-F-F]-[-F+F+F]', tree((i + 1):end)];
%                 i = i + 20;
            otherwise
                nextTree = [nextTree, tree(i)];
%                 i = i + 1;
        end
    end
        tree = nextTree;
end

% set up turtle

turtle = Turtle(worldWidth / 2, 0, tree);

nextPing = 0.05;
% while 1
for idx = 1:length(tree)
%     startLoop = now;
    
    turtle.step;
    
%     drawnow
%     writeVideo(writerObj, getframe(gcf))
    
if (idx / length(tree)) >= nextPing
     disp(idx / (length(tree)));
     nextPing = nextPing + 0.05;
end
    
%     while (now - startLoop) * 10^5 < (1 / frameRate)
%     end
end
disp(1)
drawnow
thisF = getframe(gcf);
for i = 1:(frameRate * 5)
    writeVideo(writerObj, thisF)
end

close(writerObj)