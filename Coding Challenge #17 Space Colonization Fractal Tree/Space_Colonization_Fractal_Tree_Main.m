clear all; clc; close all;
% http://algorithmicbotany.org/papers/colonization.egwnp2007.large.pdf

figure('WindowState', 'maximized')
worldWidth = 400;
worldHeight = 400;
% axis([0, worldWidth, 0, worldHeight]);
axis equal
axis off
hold on
% axis manual

frameRate = 30;
writerObj = VideoWriter('Space Colonization Fractal Tree.avi');
writerObj.FrameRate = frameRate;
open(writerObj);

% Make attractors

attractorRangeRadius = 20;
attractorRangeCenter = 30;
numAttractors = 20^2;

attractorX = -attractorRangeRadius + (2 * attractorRangeRadius) * rand(round(sqrt(numAttractors)));
attractorY = (attractorRangeCenter - attractorRangeRadius) + (2 * attractorRangeRadius) * rand(round(sqrt(numAttractors)));

for i = 1:size(attractorX, 1)
    for j = 1:size(attractorX, 2)
        thisX = attractorX(i, j);
        thisY = attractorY(i, j);
        
        if thisY > attractorRangeCenter + sqrt(attractorRangeRadius * attractorRangeRadius - thisX * thisX) || thisY < attractorRangeCenter - sqrt(attractorRangeRadius * attractorRangeRadius - thisX * thisX)
            attractorX(i, j) = nan;
            %             attractorY(i, j) = nan;
        end
    end
end

attractorArr = Attractor(attractorX(1), attractorY(1));
for i = 2:(size(attractorX, 1) * size(attractorX, 2))
    if ~isnan(attractorX(i))
        attractorArr = [attractorArr, Attractor(attractorX(i), attractorY(i))];
    end
end


% make first tree node
% treeArr = TreeNode(0, attractorRangeCenter - attractorRangeRadius, .5);
treeArr = TreeNode(0, 0, .5);

nextPing = 0.05;
idx = 1;
while 1
    startLoop = now;
    
    found = zeros(1, length(attractorArr));
    
    % reset attractors for each tree node
    for i = 1:length(treeArr)
        treeArr(i).clearAttractors;
    end
    
    % Find closest tree node to each attractor
    for i = 1:length(attractorArr)
        found(i) = attractorArr(i).findClosestNode(treeArr);
        
    end
    
    % Find average unit vector for each tree node
    for i = 1:length(treeArr)
        treeArr(i).findAverageVector
    end
    
    % create child nodes
    for i = 1:length(treeArr)
        newNode = treeArr(i).makeChild;
        if ~isempty(newNode)
            treeArr = [treeArr, treeArr(i).makeChild];
        end
    end
    
    % check attractors to see if tree nodes are inside kill distance
    i = 1;
    while i <= length(attractorArr)
        if attractorArr(i).checkKillZone(treeArr)
            attractorArr(i).kill
            attractorArr(i) = [];
        else
            i = i + 1;
        end
    end
    
    
%     drawnow
        writeVideo(writerObj, getframe(gcf))
    
    idx = idx + 1;
    % check exit condition
    if isempty(attractorArr) || sum(found) == 0 || idx > 200
        break
    end
    
    while (now - startLoop) * 10^5 < (1 / frameRate)
    end
end

% kill remaining attractors
for i = 1:length(attractorArr)
    attractorArr(i).kill
end

disp(1)
drawnow
thisF = getframe(gcf);
for i = 1:(frameRate * 5)
    writeVideo(writerObj, thisF)
end

close(writerObj)