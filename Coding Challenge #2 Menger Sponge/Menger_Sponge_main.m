clear all; clc;
close all;

nIter = 3;

writerObj = VideoWriter('Menger_Sponge.avi');
writerObj.FrameRate = 50;

open(writerObj)

centerPoints = [0, 0, 0, 1];
figure()
    clf
    hold on
    axis off
    set(gcf,'color','w');
    axis equal
    
for i = 1:size(centerPoints, 1)
        thisRow = centerPoints(i, :);
        thisBlock = Block(thisRow(1), thisRow(2), thisRow(3), thisRow(4));
        thisBlock.draw();
    end
    drawnow
    el = 25;
    for az = 0:1:180
        view(az, el) 
        drawnow
        writeVideo(writerObj, getframe(gcf))
    end
    
for i = 1:nIter
    figure()
    clf
    hold on
    axis off
    set(gcf,'color','w');
    axis equal
    centerPoints = splitBlocks(centerPoints);
    
    for i = 1:size(centerPoints, 1)
        thisRow = centerPoints(i, :);
        thisBlock = Block(thisRow(1), thisRow(2), thisRow(3), thisRow(4));
        thisBlock.draw();
    end
    drawnow
    el = 25;
    for az = 0:1:180
        view(az, el) 
        drawnow
        writeVideo(writerObj, getframe(gcf))
    end
end

close(writerObj);

% now splitting is done, create all blocks
blocks = {};
