clear all; clc; close all;


keystroke='';
S.fh = figure('units','normalized','outerposition',[0 0 1 1],...
    'keypressfcn',@f_capturekeystroke,...
    'KeyReleaseFcn', @f_releaseKey,...
    'Color', 'k');

% axis manual


frameRate = 3;

% writerObj = VideoWriter('SpaceInvaders.avi');
% writerObj.FrameRate = frameRate;

% open(writerObj);

global world; global worldHeight; global worldWidth;

worldHeight = 200;
worldWidth = 500;
world = zeros(worldHeight, worldWidth, 3);
baseWorld = world;

% axis([0, worldWidth, 0, worldHeight]);

% Create player
player = Player(round(worldWidth / 2));

while 1
    % reset world image
    if keystroke == "escape"
        break
    end
    
    lastKey = keystroke;
    
    world = baseWorld;
    
    player.move(keystroke);
    player.draw
%     keystroke
    
    imshow(world)
    
    test = 1;
    %     writeVideo(writerObj, getframe(gcf))
    
end

% close(writerObj);




function endGame()
uicontrol('Style', 'text',...
    'String', 'YOU LOSE',...
    'Position', [675 500 600 110],...
    'BackgroundCOlor', 'k',...
    'ForegroundColor', 'g',...
    'FontSize', 75);
end

function winGame()
uicontrol('Style', 'text',...
    'String', 'YOU WIN',...
    'Position', [675 500 600 110],...
    'BackgroundCOlor', 'k',...
    'ForegroundColor', 'g',...
    'FontSize', 75);
end


function  f_capturekeystroke(H,E)
% capturing and logging keystrokes
S2 = guidata(H);
% if evalin('base','isempty(keystroke)')
%     assignin('base','keystroke',E.Key)    % passing 1 keystroke to workspace variable
% else
%     newStr = [evalin('base', 'keystroke'), ',', E.Key];
%     assignin('base','keystroke', newStr);
% end

switch E.Key
    case 'space'
        lastKey = evalin('base', 'lastKey');
        evalin('base', 'player.fire;');
        assignin('base', 'keystroke', lastKey);
    otherwise
        assignin('base','keystroke',E.Key);
end
end

function f_releaseKey(H, E)
lastKey = evalin('base', 'lastKey');
switch lastKey
    case 'space'
        assignin('base', 'keystroke', lastKey);
    otherwise
        assignin('base','keystroke', '');
end
end









