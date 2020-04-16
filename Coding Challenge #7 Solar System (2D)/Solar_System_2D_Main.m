clear all; clc; close all;

figure('Color', 'k');
axis equal
axis off
axis manual
axis([-1000, 1000, -1000, 1000]);

frameRate = 30;

writerObj = VideoWriter('SolarSystem2D.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

% Make sun
sun = Body(0, 0, 100, []);

for i = 1:randi([1, 2])
    sun.addChild;        
end

for i = 1:length(sun.children)
    for j = 1:randi([1, 2])
        sun.children(i).addChild; 
    end
end

for i = 1:length(sun.children)
    for j = 1:length(sun.children(i).children)
        for k = 1:randi([1, 3])
            sun.children(i).children(j).addChild;
        end
    end
end
    
for idx = 1:500
% while 1
    startLoop = now;
    
    for i = 1:length(sun.children)
        sun.children(i).rotate;
    end
    
    drawnow
    writeVideo(writerObj, getframe(gcf))
    
    while (now - startLoop) * 10^5 < (1 / frameRate)
    end
    
end

close(writerObj)