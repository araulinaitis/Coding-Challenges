clear all; clc; close all;

% http://karlsims.com/rd.html

figure('WindowState', 'maximized', 'color', 'k');
axis equal
axis off
axis ij
ax = gca;
hold on

worldWidth = 150;
worldHeight = 150;

% A = zeros(worldHeight, worldWidth);
% B = A;
% A = rand(worldHeight, worldWidth);
A = ones(worldHeight, worldWidth);
B = zeros(worldHeight, worldWidth);
% B = ones(worldHeight, worldWidth);

% seed B

numBlots = randi([3, 5]);
for idx = 1:numBlots
    
    startWidth = randi([5, 10]);
    startHeight = randi([5, 10]);
    
    centerI = randi([1 + startHeight, worldHeight - startHeight]);
    centerJ = randi([1 + startWidth, worldWidth - startWidth]);
    
    
    for i = (centerI - startHeight):(centerI + startHeight)
        if i < 1 || i > worldHeight
            continue
        end
        for j = (centerJ - startWidth):(centerJ + startWidth)
            if j < 1 || j > worldWidth
                continue
            end
            B(i, j) = B(i, j) + (1 / numBlots);
        end
    end
end


DA = 1;
DB = 0.5;
f = 0.055;
k = 0.062;

LP = [0.05, 0.2, 0.05;
    0.2, -1, 0.2;
    0.05, 0.2, 0.05]; % Laplacian

frameRate = 60;

dt = 1;

writerObj = VideoWriter('Reaction Diffusion.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

img = zeros(worldHeight, worldWidth, 3);

newA = zeros(worldHeight, worldWidth);
newB = zeros(worldHeight, worldWidth);

recordLength = 120;
for idx = 1:(frameRate * recordLength)
    % while 1
    startLoop = now;
    
    % do equation stuff
    for i = 2:(worldHeight - 1)
        for j = 2:(worldWidth - 1)
            thisA = A(i, j);
            thisB = B(i, j);
            newA(i, j) = DA * sum(sum(LP .* A((i - 1):(i + 1), (j - 1):(j + 1)))) - thisA * thisB * thisB + f * (1 - thisA);
            newB(i, j) = DB * sum(sum(LP .* B((i - 1):(i + 1), (j - 1):(j + 1)))) + thisA * thisB * thisB - (k + f) * thisB;
        end
    end
    
    A = A + (newA * dt);
    B = B + (newB * dt);
    
    img(:, :, 1) = A;
    img(:, :, 2) = A;
    img(:, :, 3) = A;
    %     hold off
    image(ax,img);
    
    %     drawnow
    writeVideo(writerObj, getframe(gcf))
    
    idx / (frameRate * recordLength)
    
    while (now - startLoop) * 10^5 < (1 / frameRate)
    end
    %     1 / ((now - startLoop) * 10^5)
end

% for i = 1:(frameRate * 5)
%     writeVideo(writerObj, getframe(gcf))
% end
close(writerObj)