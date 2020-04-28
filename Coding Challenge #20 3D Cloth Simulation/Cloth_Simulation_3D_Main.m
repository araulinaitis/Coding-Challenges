clear all; clc; close all;

figure('WindowState', 'maximized');
axis square
axis off
ax = gca;
hold on
axis([-20, 20, -20, 20, -20, 5])
set(ax,'CameraViewAngleMode','Manual')
set(ax, 'Projection', 'perspective');
hold on

worldWidth = 150;
worldHeight = 150;
% axis([-worldWidth / 2, worldWidth / 2, -worldHeight / 2 , worldHeight / 2]);

frameRate = 20;

writerObj = VideoWriter('3D Cloth Simulation.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

% make grid of points

points = Point.empty;

numXPoints = 19;
numYPoints = 19;
xPoints = linspace(-10, 10, numXPoints);
yPoints = linspace(-10, 10, numYPoints);
numPoints = numXPoints * numYPoints;

for i = 1:numYPoints
    thisY = yPoints(i);
    for j = 1:numXPoints
        thisX = xPoints(j);
        points(i, j) = Point(thisX, thisY, 0, 1);
    end
end
points(end, 1).makeStatic;
points(end, end).makeStatic;
points(1, 1).makeStatic;
points(1, end).makeStatic;

% points(9, 9).makeStatic;
% points(9, 10).makeStatic;
% points(9, 11).makeStatic;
% points(10, 9).makeStatic;
% points(10, 10).makeStatic;
% points(10, 11).makeStatic;
% points(11, 9).makeStatic;
% points(11, 10).makeStatic;
% points(11, 11).makeStatic;

springs = Spring.empty;

viewAng = 0;
view([viewAng, 15]);

springIdx = 1;
for i = 1:(numYPoints)
    for j = 1:(numXPoints )
        if j ~= numXPoints
            springs(springIdx) = Spring(points(i, j), points(i, j + 1), 70);
            springIdx = springIdx + 1;
        end
        if i ~= numYPoints
            springs(springIdx) = Spring(points(i, j), points(i + 1, j), 70);
            springIdx = springIdx + 1;
        end
    end
end
numSprings = length(springs);

dt = 0.075;

% while 0
for idx = 1:(20 * frameRate)
    startLoop = now;
    
    
    viewAng = viewAng + 1;
    view([viewAng, 15]);

    % Reset forces in each point
    for i = 1:numPoints
        points(i).resetForce;
    end
    
    % calculate new spring lengths and forces
    for i = 1:numSprings
        springs(i).updateLength;
    end
    
    % calculate forces in each point
    for i = 1:numPoints
        points(i).calculateForce;
    end
    
    % move points
    for i = 1:numPoints
        points(i).move(dt);
    end
    
%     drawnow
        writeVideo(writerObj, getframe(gcf))
    
    
    %     while (now - startLoop) * 10^5 < (1 / frameRate)
    %     end
end


% for i = 1:(frameRate * 5)
%     viewAng = viewAng + 1;
%     view([viewAng, 15]);
%     writeVideo(writerObj, getframe(gcf))
% end
close(writerObj)