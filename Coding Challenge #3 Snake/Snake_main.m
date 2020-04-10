clear all;close all;clc

% https://www.mathworks.com/matlabcentral/answers/143088-real-time-detect-keypress#answer_285063

keystroke='0';
S.fh = figure('units','normalized','outerposition',[0 0 1 1],...
    'keypressfcn',@f_capturekeystroke,...
    'Color', 'k');
axis equal
% game = figure('Color', 'k',...
%     'Units', 'pixels');

% guidata(S.fh,S)

% Create game board image array
boardSize = 50;
global gBoard
gBoard = zeros(boardSize, boardSize, 3);

% create snake object
xTarget = randi([2, boardSize - 1]);
yTarget = randi([2, boardSize - 1]);
player = Snake(xTarget, yTarget);

% Make initial target
xTarget2 = randi([2, boardSize - 1]);
yTarget2 = randi([2, boardSize]);
while xTarget2 == xTarget && yTarget2 == yTarget
    xTarget2 = randi([2, boardSize - 1]);
    yTarget2 = randi([2, boardSize - 1]);
end

gBoard(xTarget2, yTarget2, 1) = 1;


while 1
    
    gBoard = zeros(boardSize, boardSize, 3);
    gBoard(1, :, :) = 1;
    gBoard(end, :, :) = 1;
    gBoard(:, 1, :) = 1;
    gBoard(:, end, :) = 1;
    gBoard(xTarget2, yTarget2, 1) = 1;
    
    % set direction based on keystroke
    player.setDir(keystroke);
    
    % move snake
    player.move();
    
    % check collisions
    playerPos = player.getPos;
    if player.checkTailCollision
        break
    elseif playerPos(1) < 1 || playerPos(1) > boardSize - 1 || playerPos(2) < 1 || playerPos(2) > boardSize - 1
        break
    elseif playerPos(1) == xTarget2 && playerPos(2) == yTarget2
        % grow snake
        player.grow();
        
        % make new target
        while xTarget2 == playerPos(1) && yTarget2 == playerPos(2)
            xTarget2 = randi([2, boardSize - 1]);
            yTarget2 = randi([2, boardSize - 1]);
        end
        
    end
    
    player.draw();
    imshow(gBoard, 'InitialMagnification', 'fit');
    drawnow
    
%     tStart = tic;
%     while toc(tStart) < .1
%     end
    pause(0.1)
end





function  f_capturekeystroke(H,E)
% capturing and logging keystrokes
S2 = guidata(H);
assignin('base','keystroke',E.Key)    % passing 1 keystroke to workspace variable
end