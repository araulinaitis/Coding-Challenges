clear all; clc; close all

figure('WindowState', 'maximized');

worldWidth = 25;
worldLength = 200;

noise = perlin2D(worldWidth, worldLength);

frameRate = 15;

writerObj = VideoWriter('PerlinNoiseTerrain.avi');
writerObj.FrameRate = frameRate;

open(writerObj);


curLength = [0, worldWidth];

surf(noise, 'facecolor', [0.5, 0.5, 0.5], 'edgecolor', 'k', 'facelighting', 'gouraud')
light
axis off
set(gcf, 'color', 'k');
view(-55, 60)

axis([curLength, 0, worldWidth, 0, 1])

% while 1
for idx = 1:(worldLength - worldWidth)
    startLoop = now;
    
    curLength = curLength + 1;
    axis([curLength, 0, worldWidth, 0, 1])
    
    drawnow
    writeVideo(writerObj, getframe(gcf))
    
    
    while (now - startLoop) * 10^5 < (1 / frameRate)
    end
end

for i = 1:(frameRate * 5)
    writeVideo(writerObj, getframe(gcf))
end
close(writerObj)