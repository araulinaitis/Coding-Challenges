clear all; clc; close all;

figure('WindowState', 'maximized')
worldWidth = 100;
worldHeight = 100;
% axis([0, worldWidth, 0, worldHeight]);
axis([-40, 140 0 140])
axis square
axis off
% axis manual

frameRate = 5;
writerObj = VideoWriter('Fractal Tree.avi');
writerObj.FrameRate = frameRate;
open(writerObj);

numSplits = 8;
% Make first branch
tree = Branch(Point(worldWidth / 2, 0), pi/2, worldHeight / 2, numSplits + 1);

% while 1
for idx = 1:numSplits
    startLoop = now;
    
    tree.split;
    
    drawnow
    writeVideo(writerObj, getframe(gcf))
    
%     disp(idx / (frameRate * recordLength));
    
    while (now - startLoop) * 10^5 < (1 / frameRate)
    end
end

for i = 1:(frameRate * 5)
    writeVideo(writerObj, getframe(gcf))
end

close(writerObj)