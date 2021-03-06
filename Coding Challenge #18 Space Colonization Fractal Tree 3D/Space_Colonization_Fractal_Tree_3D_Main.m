clear all; clc; close all;
% http://algorithmicbotany.org/papers/colonization.egwnp2007.large.pdf

figure('WindowState', 'maximized')
worldWidth = 400;
worldHeight = 400;
axis equal
axis off
ax = gca;
% set(ax, 'Projection', 'perspective');
set(ax,'CameraViewAngleMode','Manual')
hold on
light

view([0, 10]);

frameRate = 30;
writerObj = VideoWriter('Space Colonization Fractal Tree 3D.avi');
writerObj.FrameRate = frameRate;
open(writerObj);

% Make attractors

attractorRangeRadius = 50;
attractorRangeCenter = 70;
numAttractors = 30^2;

attractorX = -attractorRangeRadius + (2 * attractorRangeRadius) * rand(round(sqrt(numAttractors)));
attractorY = -attractorRangeRadius + (2 * attractorRangeRadius) * rand(round(sqrt(numAttractors)));
attractorZ = (attractorRangeCenter - attractorRangeRadius) + (2 * attractorRangeRadius) * rand(round(sqrt(numAttractors)));

for i = 1:size(attractorX, 1)
    for j = 1:size(attractorX, 2)
        thisX = attractorX(i, j);
        thisY = attractorY(i, j);
        thisZ = attractorZ(i, j);
        
        if thisZ > attractorRangeCenter + sqrt(attractorRangeRadius * attractorRangeRadius - thisX * thisX - thisY * thisY) || thisZ < attractorRangeCenter - sqrt(attractorRangeRadius * attractorRangeRadius - thisX * thisX - thisY * thisY)
            attractorX(i, j) = nan;
            %             attractorY(i, j) = nan;
        end
    end
end

i = 1;
while 1
    if ~isnan(attractorX(i))
        attractorArr = Attractor(attractorX(i), attractorY(i), 2 * attractorZ(i));
        break
    else
        i = i + 1;
    end
end
for i = 2:(size(attractorX, 1) * size(attractorX, 2))
    if ~isnan(attractorX(i))
        attractorArr = [attractorArr, Attractor(attractorX(i), attractorY(i), 2* attractorZ(i))];
    end
end


% make first tree node
% treeArr = TreeNode(0, attractorRangeCenter - attractorRangeRadius, .5);
treeArr = TreeNode(0, 0, 0, .5);

nextPing = 0.05;
idx = 1;
lastLength = length(attractorArr);
repeat = 0;

viewAng = 1;
while 1
%     startLoop = now;
    view([viewAng, 10]);
    
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
    
    % remove dead tree nodes from array.  In the future, could move them to
    % a different array if you still want to use them
    i = 1;
%     length(treeArr)
    while i <= length(treeArr)
        if treeArr(i).dead
            treeArr(i) = [];
        else
            i = i + 1;
        end
    end
    
    
%     drawnow
        writeVideo(writerObj, getframe(gcf))
    if length(attractorArr) == lastLength
        repeat = repeat + 1;
    else
        repeat = 0;
    end
    lastLength = length(attractorArr);
    
    idx = idx + 1;
    % check exit condition
    if isempty(attractorArr) || sum(found) == 0 || repeat >= 100
        break
    end
    
    viewAng = viewAng + 1;
    
%     while (now - startLoop) * 10^5 < (1 / frameRate)
%     end
end

% kill remaining attractors
for i = 1:length(attractorArr)
    attractorArr(i).kill
end

% disp(1)
drawnow
for i = 1:(frameRate * 5)
    viewAng = viewAng + 1;
    view([viewAng, 10]);
    writeVideo(writerObj, getframe(gcf))
end

close(writerObj)