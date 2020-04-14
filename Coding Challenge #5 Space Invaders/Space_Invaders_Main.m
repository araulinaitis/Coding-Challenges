clear all; clc; close all;

keystroke='';
S.fh = figure('units','normalized',...
    'keypressfcn',@f_capturekeystroke,...
    'KeyReleaseFcn', @f_releaseKey,...
    'Color', 'k');

% axis manual


frameRate = 15;

writerObj = VideoWriter('SpaceInvaders2.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

global world; global worldHeight; global worldWidth;

worldHeight = 200;
worldWidth = 500;
world = zeros(worldHeight, worldWidth, 3);
baseWorld = world;

% axis([0, worldWidth, 0, worldHeight]);

% Create player
player = Player(round(worldWidth / 2));
fireCD = uint8(15); % number of frames between allowed firings
fireCount = uint8(0);

% Create invaders
invaders = {};
numInvaders = 5;
for i = 1:numInvaders
    thisX = round((worldWidth / 4) + ((i -1) * 0.5 * worldWidth / 5) + (0.25 * worldWidth / 5));
    invaders = [invaders; Invader(thisX, 150, 3)];
end

while 1
% for k = 1:100
    
    startLoop = now;
    
    % Check bullet hits
    [invaders, numInvaders] = player.checkHits(invaders, numInvaders);
    
    % Check win codition
    if numInvaders == 0
        winGame()
        break
    end
    
    % Check lose condition
    if invaders(1).atBottom(worldHeight - 10)
        endGame()
        break
    end
    
    % reset world image
    if keystroke == "escape"
        break
    end
    
    fireCount = fireCount - 1;
    
    lastKey = keystroke;
    
    world = baseWorld;
    
    player.move(keystroke);
    player.draw
    
    if invaders(end).atEnd(worldWidth) || invaders(1).atStart(2)
        for i = 1:numInvaders
            invaders(i).nextLevel
        end
    end
    
    for i = 1:numInvaders
        invaders(i).move
        invaders(i).draw
    end
    
    imshow(world)
    
        writeVideo(writerObj, getframe(gcf))
    pause((1/frameRate) - ((now - startLoop) * 10^5))
    
    %     uicontrol('Style', 'text',...
    %         'String', num2str(1/((now - startLoop) * 10^5)),...
    %         'Position', [20 20 100 110],...
    %         'BackgroundCOlor', 'k',...
    %         'ForegroundColor', 'g',...
    %         'FontSize', 20);
    %     drawnow
    
end

for i = 1:25
%     imshow(world);
%     drawnow
    writeVideo(writerObj, getframe(gcf))
end
close(writerObj);




function endGame()
uicontrol('Style', 'text',...
    'String', 'YOU LOSE',...
    'Position', [50 100 600 110],...
    'BackgroundCOlor', 'k',...
    'ForegroundColor', 'r',...
    'FontSize', 30);
drawnow
end

function winGame()
uicontrol('Style', 'text',...
    'String', 'YOU WIN',...
    'Position', [50 100 600 110],...
    'BackgroundCOlor', 'k',...
    'ForegroundColor', 'g',...
    'FontSize', 30);
end


function  f_capturekeystroke(H,E)
% capturing and logging keystrokes
% S2 = guidata(H);
switch E.Key
    case 'space'
        count = evalin('base', 'fireCount');
        if count == 0
            evalin('base', 'player.fire;');
            evalin('base', 'fireCount = fireCD;');
        end
    otherwise
        assignin('base','keystroke',E.Key);
end
end

function f_releaseKey(H, E)
lastKey = evalin('base', 'lastKey');
switch E.Key
    case 'space'
        assignin('base', 'keystroke', lastKey);
    otherwise
        assignin('base','keystroke', '');
end
end









