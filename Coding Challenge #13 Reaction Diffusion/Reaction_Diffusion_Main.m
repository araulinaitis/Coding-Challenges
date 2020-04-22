clear all; clc; close all;

% http://karlsims.com/rd.html

worldWidth = 50;
worldHeight = 50;

figure('WindowState', 'maximized', 'color', 'k');
axis equal
axis off
axis ij
% axis manual
xlim([0, worldWidth]);
ylim([0, worldHeight]);
set(gca, 'xlimmode','manual',...
           'ylimmode','manual',...
           'zlimmode','manual',...
           'climmode','manual',...
           'alimmode','manual');
ax = gca;
hold on


% A = zeros(worldHeight, worldWidth);
% B = A;
% A = rand(worldHeight, worldWidth);
A = ones(worldHeight, worldWidth);
B = zeros(worldHeight, worldWidth);
% B = ones(worldHeight, worldWidth);

% B(worldHeight / 2 - 5: worldHeight / 2 + 5, worldWidth / 2 - 5: worldWidth / 2 + 5) = 1;
B(worldHeight / 2 - 2: worldHeight / 2 + 2, worldWidth / 2 - 2: worldWidth / 2 + 2) = 1;
% B(250:260, 250:260) = 1;

% seed B

% numBlots = randi([3, 5]);
% % numBlots = 1;
% for idx = 1:numBlots
%     
%     startWidth = randi([5, 10]);
%     startHeight = randi([5, 10]);
%     
%     centerI = randi([1 + startHeight, worldHeight - startHeight]);
%     centerJ = randi([1 + startWidth, worldWidth - startWidth]);
%     
%     
%     for i = (centerI - startHeight):(centerI + startHeight)
%         if i < 1 || i > worldHeight
%             continue
%         end
%         for j = (centerJ - startWidth):(centerJ + startWidth)
%             if j < 1 || j > worldWidth
%                 continue
%             end
%             B(i, j) = B(i, j) + (1 / numBlots);
%         end
%     end
% end



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

% open(writerObj);

% img(:, :, 1) = A - B;
% img(:, :, 2) = A - B;
% img(:, :, 3) = A - B;

img = A - B;

img = uint8(round(img * 255));

newA = zeros(worldHeight, worldWidth);
newB = zeros(worldHeight, worldWidth);

% im = image(ax, img);
im = imagesc(img, [0, 255]);
colors = linspace(0, 1, 255);
colormap([colors', colors', colors']);
kBase = k;
fBase = f;

recordLength = 30;
for idx = 1:(frameRate * recordLength)
    % while 1
    startLoop = now;
    
% k = k + (randn(worldHeight, worldWidth)) / 16000;
% f = f + (randn(worldHeight, worldWidth)) / 16000;

    LPA = conv2(A, LP, 'same');
    LPB = conv2(B, LP, 'same');
    % do equation stuff
    for i = 2:(worldHeight - 1)
        for j = 2:(worldWidth - 1)
            thisA = A(i, j);
            thisB = B(i, j);
            newA(i, j) = DA * LPA(i, j) - thisA * thisB * thisB + f * (1 - thisA);
            newB(i, j) = DB * LPB(i, j) + thisA * thisB * thisB - (k + f) * thisB;
%             newA(i, j) = DA * LPA(i, j) - thisA * thisB * thisB + f(i, j) * (1 - thisA);
%             newB(i, j) = DB * LPB(i, j) + thisA * thisB * thisB - (k(i,j) + f(i, j)) * thisB;
        end
    end
    
%     newA = DA * LPA - (A .* B .* B) + f * (1 - A);
%     newB = DB * LPB + (A .* B .* B) - (k + f) * B;
    
    A = A + (newA * dt);
    B = B + (newB * dt);
    
%     img(:, :, 1) = uint8(round((A - B) * 255));
%     img(:, :, 2) = uint8(round((A - B) * 255));
%     img(:, :, 3) = uint8(round((A - B) * 255));
%     img = uint8(round(img * 255));
img = uint8(round((A - B) * 255))
    
    %     hold off
    %     image(ax,img);
    
    im.CData = img;
    
        drawnow
%     writeVideo(writerObj, getframe(gcf))
    
    idx / (frameRate * recordLength)
    
%     while (now - startLoop) * 10^5 < (1 / frameRate)
%     end
    %     1 / ((now - startLoop) * 10^5)
end

% for i = 1:(frameRate * 5)
%     writeVideo(writerObj, getframe(gcf))
% end
% close(writerObj)