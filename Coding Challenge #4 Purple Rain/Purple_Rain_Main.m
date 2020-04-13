clear all; clc; close all;

worldHeight = 500;
worldWidth = worldHeight * 2;

figure()
axis manual
    axis([0, worldHeight, 0, worldWidth])
hold on
axis equal


global world

world = ones(worldHeight, worldWidth, 3)/255;
world(:, :, 1) = world(:, :, 1) * 230;
world(:, :, 2) = world(:, :, 1);
world(:, :, 3) = world(:, :, 3) * 250;

worldBase = world;

newDrops = 20; % number of new drops per loop

dropArr = {};

frameRate = 10;

writerObj = VideoWriter('PurpleRain.avi');
writerObj.FrameRate = frameRate;

open(writerObj)

for idx = 1:100
    startLoop = now;
    % reset image background
    world = worldBase;
    
    for i = 1:newDrops
%         newX = randi([1, worldSize]);
        newX = 1 + randi([0, worldHeight / 10]);
        newY = randi([1, worldWidth]);
        newZ = randi([0, 5]);
        dropArr = [dropArr; {Drop(newX, newY, newZ)}];
    end
    
    for i = 1:size(dropArr, 1)
       dropArr{i}.draw;
    end
    
    world = world(1:worldHeight, 1:worldWidth, :);
    
    imshow(world)
    drawnow
    writeVideo(writerObj, getframe(gcf))
    
    for i = 1:size(dropArr, 1)
       dropArr{i}.move;
    end
    
    dropArr = checkBounds(dropArr, worldHeight);
    pause((1/frameRate) - ((now - startLoop) * 10^5))
    
end

close(writerObj);
