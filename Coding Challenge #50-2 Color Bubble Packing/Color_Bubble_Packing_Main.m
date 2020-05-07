clear all; clc; close all;

figure('WindowState', 'maximized', 'color', 'k');

img = imread('kitten', 'png');
imgSize = size(img);

% image(img)

% flip image so indexing works
% img = img(end:-1:1, :);
temp = img(:, :, 1);
img(:, :, 1) = temp(end:-1:1, :);
temp = img(:, :, 2);
img(:, :, 2) = temp(end:-1:1, :);
temp = img(:, :, 3);
img(:, :, 3) = temp(end:-1:1, :);

axis([1, imgSize(2), 1, imgSize(1)])
% axBot = gca;
% axis equal
axis off
axis manual
hold on

frameRate = 60;

writerObj = VideoWriter('Bubble Packing.avi');
writerObj.FrameRate = frameRate;

record = 01;

if record
    open(writerObj);
end

world = CircleKeeper(img);


while 1
    % for i = 1:numPixels
    % startLoop = now;
    
    cntMax = 0;
    for i = 1:20
        cnt = world.add;
        if cnt > cntMax
            cntMax = cnt;
        end
    end
    
    
    %     if i > nextVideoFrame
    if record
        writeVideo(writerObj, getframe(gcf))
    else
        drawnow
    end
    %     end
    
    if cntMax > 4000
        break
    end
    
    %     if i / (imgSize(1) * imgSize(2)) > nextPing
    %         disp(nextPing)
    %         nextPing = nextPing + pingFreq;
    %     end
    
end



if record
    for i = 1:(frameRate * 5)
        writeVideo(writerObj, getframe(gcf))
    end
    close(writerObj)
end