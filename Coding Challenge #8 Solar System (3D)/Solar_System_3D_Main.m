clear all; clc; close all;clear all; clc; close all;

figure('Color', 'k', 'WindowState', 'maximized');
axis equal
axis off
axis([-1000, 1000, -1000, 1000, -1000, 1000]);
% colormap([1, 1, 1]);
light
axis manual
hold on

frameRate = 60;

writerObj = VideoWriter('SolarSystem3D.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

% Make sun
sun = Body3D(0, 0, 0, 100, []);

sun.addChildren(randi([1, 2]));

for i = 1:length(sun.children)
    sun.children(i).addChildren(randi([1, 2]));
end

for i = 1:length(sun.children)
    for j = 1:length(sun.children(i).children)
        sun.children(i).children(j).addChildren(randi([1, 3]));
    end
end
    
for idx = 1:1000
% while 1
    startLoop = now;
    
    for i = 1:length(sun.children)
        sun.children(i).rotate;
    end
    
    drawnow
    writeVideo(writerObj, getframe(gcf))
    
    while (now - startLoop) * 10^5 < (1 / frameRate)
    end
   
%     1/((now - startLoop) * 10^5)
    
end

close(writerObj)