clear all; clc; close all;

% https://en.wikipedia.org/wiki/Superellipse

figure('WindowState', 'maximized');
axis equal
% axis off
ax = gca;
hold on

worldWidth = 25;
worldLength = 25;

frameRate = 4;

writerObj = VideoWriter('Superellipse.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

numPoints = 100;
t = linspace(0, 2 * pi, numPoints)';

a = 1;
b = 1;

% make first shape
n = 0.1;

x = abs(cos(t)).^(2 / n) .* (a * sign(cos(t)));
y = abs(sin(t)).^(2 / n) .* (b * sign(sin(t)));

p = patch(x, y, 'k', 'FaceColor', 'none');
title(['n = ', num2str(n)]);

numInterpPoints = 10;
interpX = cell(1, numPoints);
interpY = interpX;

    writeVideo(writerObj, getframe(gcf))

for n = 0.2:0.1:5
    startLoop = now;
    
    lastX = x;
    lastY = y;
    
    % make next points
    x = abs(cos(t)).^(2 / n) .* (a * sign(cos(t)));
    y = abs(sin(t)).^(2 / n) .* (b * sign(sin(t)));
    
    % draw next shape
    p.Vertices = [x, y];
    title(['n = ', num2str(n)]);
%     drawnow
    writeVideo(writerObj, getframe(gcf))
    
    
%     while (now - startLoop) * 10^5 < (1 / frameRate)
%     end
end


for i = 1:(frameRate * 5)
    writeVideo(writerObj, getframe(gcf))
end
close(writerObj)