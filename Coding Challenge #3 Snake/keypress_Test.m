clear all;close all;clc
a='0';
S.fh = figure('keypressfcn',@f_capturekeystroke);

guidata(S.fh,S)

function  f_capturekeystroke(H,E)
% capturing and logging keystrokes
S2 = guidata(H);
assignin('base','a',E.Key)    % passing 1 keystroke to workspace variable
end
