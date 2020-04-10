clear all; clc;
close all;

xSize = 500;
ySize = 500;
xCenter = xSize / 2;
yCenter = ySize / 2;


figure(1)
hold on
axis off
set(gcf,'color','k');
axis([0, xSize, 0, ySize])

starArr = {};
tStep = .01;
vel = 100;

writerObj = VideoWriter('Starfield.avi');
writerObj.FrameRate = 10;

open(writerObj)

for idx = 1:100
    % clear figure
    figure(1)
    clf
    hold on
    axis off
    set(gcf,'color','k');
    axis([0, xSize, 0, ySize])
    % create new stars
    
    for i = 1:5
        % make velocity vector based on the offset from center
%         thisX = randi([0, xSize]);
%         thisY = randi([0, ySize]);
        thisX = xSize * rand(1);
        thisY = ySize * rand(1);
        vec = [thisX - xCenter, thisY - yCenter];
%         vec = vec / vel;
        vecMag = sqrt(vec(1) * vec(1) + vec(2) * vec(2));
        vec = vel * vec / vecMag;
        
        starArr = [starArr, {Star(thisX, thisY, 1, [vec, 10])}];
    end
    
    for i = 1:length(starArr)
        starArr{i}.draw();
        starArr{i}.update(tStep);
    end
    
    starArr = checkStars(starArr, 0, xSize, 0, ySize);
    drawnow
    writeVideo(writerObj, getframe(gcf))
    a = 1;
end
close(writerObj);