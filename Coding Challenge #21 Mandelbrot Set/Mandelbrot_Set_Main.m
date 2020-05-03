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

numSteps = 30000;
% c = [linspace(-worldHeight, worldHeight, numSteps)', linspace(-worldWidth, worldWidth, numSteps)']; % points listed [y, x] so I can iterate through the list and get the image in the right orientation

imgBase = zeros(numSteps, numSteps);

[a, b] = meshgrid(linspace(-2, 1, numSteps), linspace(-1.5, 1.5, numSteps));

c = complex(a, b);

numIter = 200;

pingFreq = 0.01;
nextPing = pingFreq;

if 1
%     parfor(i = 1:(numSteps * numSteps), 6)
    for i = 1:(numSteps * numSteps)
        z = 0;
        thisC = c(i);
        
        idx = 1;
        while abs(z) < 2 && idx <= numIter
            z = z^2 + thisC;
            idx = idx + 1;
        end
        
        imgBase(i) = idx;
%         i
        if (i / (numSteps * numSteps)) >= nextPing
            disp(i / (numSteps * numSteps))
            nextPing = nextPing + pingFreq;
        end
        
    end
    
else
    
    f = @(z) z.^2 + c;
    
    numIter = 200;
    z = 0;
    for i = 1:numIter
        
        z = f(z);
        
        imgBase(imgBase == 0 & z > thresh) = i; % indicate iteration that the point was found to be invalid
        
        if (i / numIter) >= nextPing
            disp(i / numIter)
            nextPing = nextPing + pingFreq;
        end
    end
end

imgBaseBackup = imgBase;
%%
% img(z < thresh) = 0;
imgBase = imgBaseBackup;
imgBase(imgBase == numIter + 1) = 0;
% img = ~(abs(z) < thresh);
% imgBase = uint8((2^8 - 1) * (imgBase / max(max(imgBase))));
imgBase = uint8(map(sqrt(imgBase / max(max(imgBase))), 0, 1, 1, 256));

% image(img);
img(:, :, 1) = imgBase;
img(:, :, 2) = imgBase;
img(:, :, 3) = imgBase;

% col = linspace(0, 1, 2^16 - 1)';
colR = linspace(0, 0, 2^8)';
colG = linspace(0, 0, 2^8)';
% colB = 255 * ones(2^8, 1);
colB = linspace(0, 255, 2^8);

imgR = colR(imgBase);
imgG = colG(imgBase);
imgB = colB(imgBase);

imgR(imgBase == 1) = 0;
imgG(imgBase == 1) = 0;
imgB(imgBase == 1) = 0;

img(:, :, 1) = uint8(imgR);
img(:, :, 2) = uint8(imgG);
img(:, :, 3) = uint8(imgB);
img = uint8(img);

% colormap([colR, colG, colB])
% colormap([col, col, col])
% colormap([0, 0, 0; 1, 1, 1])

image(img);

fname = sprintf('Mandelbrot%i-%i.jpg', numSteps, numIter);
imwrite(img, fname)


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