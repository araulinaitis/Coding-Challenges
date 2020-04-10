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
boardSize = 27;

global gBoard
gBoard = zeros(boardSize, boardSize, 3);

% create snake object
xTarget = randi([2, boardSize - 1]);
yTarget = randi([2, boardSize - 1]);
player = Snake(xTarget, yTarget);

% Make initial target
xTarget2 = randi([2, boardSize - 1]);
yTarget2 = randi([2, boardSize - 1]);
while xTarget2 == xTarget && yTarget2 == yTarget
    xTarget2 = randi([2, boardSize - 1]);
    yTarget2 = randi([2, boardSize - 1]);
end

gBoard(xTarget2, yTarget2, 1) = 1;

frameRate = 7;

writerObj = VideoWriter('Snake1.avi');
writerObj.FrameRate = frameRate;

open(writerObj)


while 1
    startLoop = now;
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
        endGame();
        break
    elseif playerPos(1) < 2 || playerPos(1) >= boardSize || playerPos(2) < 2 || playerPos(2) >= boardSize
        endGame();
        break
    elseif playerPos(1) == xTarget2 && playerPos(2) == yTarget2
        % grow snake
        player.grow();
        
        % check win condition
        if player.getLength == ((boardSize - 2) * (boardSize - 2))
            winGame();
            break
        end
        
        % make new target
        while xTarget2 == playerPos(1) && yTarget2 == playerPos(2) || player.touchesTail(xTarget2, yTarget2)
            xTarget2 = randi([2, boardSize - 1]);
            yTarget2 = randi([2, boardSize - 1]);
            gBoard(xTarget2, yTarget2, 1) = 1;
        end
        
    end
    
    player.draw();
    imshow(gBoard, 'InitialMagnification', 'fit');
    drawnow
        writeVideo(writerObj, getframe(gcf))
    

pause((1/frameRate) - ((now - startLoop) * 10^5))
% end

end

for i = 1:25
    imshow(gBoard, 'InitialMagnification', 'fit');
    drawnow
    writeVideo(writerObj, getframe(gcf))
end
close(writerObj);

function endGame()
txt = uicontrol('Style', 'text',...
    'String', 'YOU LOSE',...
    'Position', [675 500 600 110],...
    'BackgroundCOlor', 'k',...
    'ForegroundColor', 'g',...
    'FontSize', 75);
end

function winGame()
txt = uicontrol('Style', 'text',...
    'String', 'YOU WIN',...
    'Position', [675 500 600 110],...
    'BackgroundCOlor', 'k',...
    'ForegroundColor', 'g',...
    'FontSize', 75);
end


function  f_capturekeystroke(H,E)
% capturing and logging keystrokes
S2 = guidata(H);
assignin('base','keystroke',E.Key)    % passing 1 keystroke to workspace variable
end