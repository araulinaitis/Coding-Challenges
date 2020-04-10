clear all;close all;clc
          a='0';b='0';
          S.fh = figure( 'units','pixels',...
                         'position',[500 500 200 260],...
                         'menubar','none','name','move_fig',...
                         'numbertitle','off','resize','off',...
                         'keypressfcn',@f_capturekeystroke,...
                         'CloseRequestFcn',@f_closecq);
          S.tx = uicontrol('style','text',...
          'units','pixels',...
          'position',[60 120 80 20],...
          'fontweight','bold'); 
          guidata(S.fh,S)     
     function  f_capturekeystroke(H,E)          
        % capturing and logging keystrokes
        S2 = guidata(H);
        P = get(S2.fh,'position');
        set(S2.tx,'string',E.Key)
        assignin('base','a',E.Key)    % passing 1 keystroke to workspace variable
        evalin('base','b=[b a]')  % accumulating to catch combinations like ctrl+S
     end
     function f_closecq(src,callbackdata)
      selection = questdlg('Close This Figure?','Close Request Function','Yes','No','Yes'); 
       switch selection
          case 'Yes'
             S.fh.WindowSyle='normal'
             delete(gcf)
          case 'No'
          return 
       end
     end