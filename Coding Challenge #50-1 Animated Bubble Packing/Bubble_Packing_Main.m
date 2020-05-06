clear all; clc; close all;

figure('WindowState', 'maximized', 'color', 'k');

img = imread('Bubbles', 'png');
imgSize = size(img);

colormap([0, 0, 0,; 1, 1, 1])

% image(img)

img = logical(img(:, :, 1));
img = img(end:-1:1, :);

axis([1, imgSize(2), 1, imgSize(1)])
axBot = gca;
% axis equal
axis off
axis manual
hold on

frameRate = 60;

writerObj = VideoWriter('Bubble Packing.avi');
writerObj.FrameRate = frameRate;

record = 1;

if record
    open(writerObj);
end

world = CircleKeeper(img);


while 1
    % for i = 1:numPixels
    % startLoop = now;
    
    cnt = world.add;
    
    
    %     if i > nextVideoFrame
    if record
        writeVideo(writerObj, getframe(gcf))
    else
        drawnow
    end
    %     end
    
    if cnt > 4000
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