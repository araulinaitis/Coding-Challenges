clear all; clc; close all;

figure('WindowState', 'maximized', 'Color', 'k');
mainFig = gcf;
% imgName = '12080355_10156105736780285_810595954887447918_o';
% img = imread('12080355_10156105736780285_810595954887447918_o.jpg');
% img = imread('AZHhH4n', 'jpg');
% imgName = 'AZHhH4n';
img = imread('G5xokJr', 'png');
imgName = 'G5xookJr';
% axTop = axes('Position', [0.1, 0.5, 0.8, 0.4]);
% baseImgObj = image(axTop, img);
imgSize = size(img);
% axis equal;
% axis off
% hold on
% axis([1, imgSize(2), 1, imgSize(1) * 2]);

global axBot

% axBot = axes('Position', [0.3, 0.1, 0.4, 0.4]);
axis([1, 256, 1, 256, 1, 256])
axBot = gca;
axis square
axis off
set(axBot,'CameraViewAngleMode','Manual')
axis manual
hold on

% sortedImg = uint8(zeros(imgSize(1), imgSize(2), 3));
% sortedImg = image(imgSize(2) + 1, 1, blankImg);


frameRate = 20;

writerObj = VideoWriter('PixelSort.avi');
writerObj.FrameRate = frameRate;

record = 1;

if record
    open(writerObj);
end


sortedIdx = 1;
brightArray = double(img(:, :, 1)) + double(img(:, :, 2)) + double(img(:, :, 3));
pingFreq = 0.01;
nextPing = pingFreq;

videoStep = 1000;
nextVideoFrame = videoStep;
% sortedImgObj = image(1, imgSize(1) + 1, sortedImg);

% startFrame = getframe(gcf);
% if record
%     for i = 1:(frameRate * 1.5)
%         writeVideo(writerObj, startFrame)
%     end
% end

numPixels = imgSize(1) * imgSize(2);
pixelOffset = numPixels;

% % make spiral path list of 2d coordinates
% pathLength = 0;
% currentPoint = [0, 0];
% minX = 0;
% maxX = 0;
% minY = 0;
% maxY = 0;
% pointArr = [];
%
% dir = 1;
%
% while pathLength < numPixels
%     switch dir
%         case 1
%             newArr = (currentPoint(2):(maxY + 1))';
%             newArr = [currentPoint(1) * ones(length(newArr), 1), newArr];
%             currentPoint = newArr(end, :);
%             maxY = currentPoint(2);
%             dir = 2;
%
%             %             currentPoint = currentPoint + [0, 1];
%             %             if currentPoint(2) > maxY
%             %                 maxY = currentPoint(2);
%             %                 dir = 2;
%             %             end
%
%         case 2
%             newArr = (currentPoint(1):-1:(minX - 1))';
%             newArr = [newArr, currentPoint(2) * ones(length(newArr), 1)];
%             currentPoint = newArr(end, :);
%             minX = currentPoint(1);
%             dir = 3;
%
%             %             currentPoint = currentPoint + [-1, 0];
%             %             if currentPoint(1) < minX
%             %                 minX = currentPoint(1);
%             %                 dir = 3;
%             %             end
%         case 3
%             newArr = (currentPoint(2):-1:(minY - 1))';
%             newArr = [currentPoint(1) * ones(length(newArr), 1), newArr];
%             currentPoint = newArr(end, :);
%             minY = currentPoint(2);
%             dir = 4;
%
%             %             currentPoint = currentPoint + [0, -1];
%             %             if currentPoint(2) < minY
%             %                 minY = currentPoint(2);
%             %                 dir = 4;
%             %             end
%         case 4
%             newArr = (currentPoint(1):1:(maxX + 1))';
%             newArr = [newArr, currentPoint(2) * ones(length(newArr), 1)];
%             currentPoint = newArr(end, :);
%             maxX = currentPoint(1);
%             dir = 1;
%
%             %             currentPoint = currentPoint + [1, 0];
%             %             if currentPoint(1) > maxX
%             %                 maxX = currentPoint(1);
%             %                 dir = 1;
%             %             end
%     end
%
%     pathLength = pathLength + size(newArr, 1);
%
%     pointArr = [pointArr; newArr];
%     %     pathLength = pathLength + 1;
%
% end
%
% pointArr = pointArr - [min(pointArr(:, 1)), min(pointArr(:, 2))] + [1, 1];

% sortedImg = uint8(zeros(max(pointArr(:, 2)) + 1, max(pointArr(:, 1)) + 1, 3));
% sortedImgObj = image(1, imgSize(1) + 1, sortedImg);

% axis([1, imgSize(2), 1, imgSize(1) + size(sortedImg, 1) + 1]);
idx = 1;

% make cell array 255 x 255 x 255
blobs = cell(255, 255, 255);

% [maxRow, maxCol] = find(brightArray == max(max(brightArray)), 1);

% curLoc = img(maxRow, maxCol);
% thisPix = double(img(maxRow, maxCol, :));
% img(maxRow, maxCol, :) = 0;

thisAng = 0;
view([thisAng, 15]);

% while 1
for i = 1:numPixels
    % startLoop = now;
    
    thisPix = [img(i), img(i + pixelOffset), img(i + pixelOffset + pixelOffset)] + 1;
    if isempty(blobs{thisPix(1), thisPix(2), thisPix(3)})
        blobs{thisPix(1), thisPix(2), thisPix(3)} = Blob(thisPix(1), thisPix(2), thisPix(3));
%     else
%         blobs{thisPix(1), thisPix(2), thisPix(3)}.addCount;
    end
    
    %     [maxRow, maxCol] = find(brightArray == max(max(brightArray)), 1);
    %     baseImgObj.CData(maxRow, maxCol, :) = 0;
    %     brightArray(maxRow, maxCol) = 0;
    
    %     diffArray = abs(double(img(:, :, 1)) - thisPix(1)) + abs(double(img(:, :, 2)) - thisPix(2)) + abs(double(img(:, :, 3)) - thisPix(3));
    %
    %     [minRow, minCol] = find(diffArray == min(min(diffArray)), 1);
    %     baseImgObj.CData(minRow, minCol, :) = 0;
    %     thisPix = double(img(minRow, minCol, :));
    %
    %     curPixel = pointArr(idx, :);
    %     idx = idx + 1;
    
    %     sortedImg(curPixel(2), curPixel(1), 1) = img(maxRow, maxCol, 1);
    %     sortedImg(curPixel(2), curPixel(1), 2) = img(maxRow, maxCol, 2);
    %     sortedImg(curPixel(2), curPixel(1), 3) = img(maxRow, maxCol, 3);
    
    %     sortedImg(curPixel(2), curPixel(1), 1) = img(minRow, minCol, 1);
    %     sortedImg(curPixel(2), curPixel(1), 2) = img(minRow, minCol, 2);
    %     sortedImg(curPixel(2), curPixel(1), 3) = img(minRow, minCol, 3);
    %     img(minRow, minCol, :) = 0;
    
    %     sortedImg(sortedIdx) = img(maxRow, maxCol, 1);
    %     sortedImg(sortedIdx + pixelOffset) = img(maxRow, maxCol, 2);
    %     sortedImg(sortedIdx + pixelOffset + pixelOffset) = img(maxRow, maxCol, 3);
    %     sortedIdx = sortedIdx + 1;
    
    if i > nextVideoFrame
        %         sortedImgObj.CData = sortedImg;
        thisAng = thisAng + 1;
        view([thisAng, 15])
        if record
            writeVideo(writerObj, getframe(gcf))
        else
            drawnow
        end
        nextVideoFrame = nextVideoFrame + videoStep;
    end
    
    
    if i / (imgSize(1) * imgSize(2)) > nextPing
        disp(nextPing)
        nextPing = nextPing + pingFreq;
    end
    
    if max(max(brightArray)) == 0
        break
    end
end

% image(imgSize(2) + 1, 1, sortedImg)
% imwrite(sortedImg, [imgName, '-sorted.bmp'], 'BMP');


if record
    for i = 1:(frameRate * 5)
        thisAng = thisAng + 1;
        view([thisAng, 15])
        writeVideo(writerObj, getframe(gcf))
    end
    close(writerObj)
end