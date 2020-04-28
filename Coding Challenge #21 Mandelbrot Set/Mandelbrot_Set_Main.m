clear all; clc; close all;

figure('WindowState', 'maximized');
axis equal
% axis off
ax = gca;
hold on
% axis([-20, 20, -20, 20, -20, 5])
% set(ax,'CameraViewAngleMode','Manual')
% set(ax, 'Projection', 'perspective');
hold on

worldWidth = 2;
worldHeight = 2;
% axis([-worldWidth, worldHeight, -worldWidth, worldHeight]);

frameRate = 20;

thresh = 2;


% writerObj = VideoWriter('3D Cloth Simulation.avi');
% writerObj.FrameRate = frameRate;

% open(writerObj);

numSteps = 20000;
% c = [linspace(-worldHeight, worldHeight, numSteps)', linspace(-worldWidth, worldWidth, numSteps)']; % points listed [y, x] so I can iterate through the list and get the image in the right orientation

img = ones(numSteps, numSteps);

[a, b] = meshgrid(linspace(-2, 1, numSteps), linspace(-1.5, 1.5, numSteps));

c = complex(a, b);

numPoints = size(c, 1);

f = @(z) z.^2 + c;

numIter = 400;
z = 0;
pingFreq = 0.01;
nextPing = pingFreq;
for i = 1:numIter
    
    z = f(z);
    
    img(img == 1 & z > thresh) = i; % indicate iteration that the point was found to be invalid
    
    if (i / numIter) >= nextPing
        disp(i / numIter)
        nextPing = nextPing + pingFreq;
    end
end

% img(z < thresh) = 1;

% img = ~(abs(z) < thresh);
img = uint16((2^16 - 1) * (img / max(max(img))));
image(img);
imwrite(img, 'Mandelbrot.png')

col = linspace(0, 1, 2^16 - 1)';

colormap([col, col, col])
% colormap([0, 0, 0; 1, 1, 1])


% for i = 1:numPoints
%     
%     f = @(z) z
        

% while 0
% for idx = 1:(20 * frameRate)
%     startLoop = now;
%     
%     
%    
%     drawnow
% %         writeVideo(writerObj, getframe(gcf))
%     
%     
%     %     while (now - startLoop) * 10^5 < (1 / frameRate)
%     %     end
% end


% for i = 1:(frameRate * 5)
%     viewAng = viewAng + 1;
%     view([viewAng, 15]);
%     writeVideo(writerObj, getframe(gcf))
% end
% close(writerObj)