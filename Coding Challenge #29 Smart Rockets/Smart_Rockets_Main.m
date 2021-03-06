clear all; clc; close all;

figure()
fitFig = gcf;

figure('WindowState', 'maximized', 'Color', 'k');
mainFig = gcf;
axis equal
axis off

global rx1; global rw1; global ry1; global rh1
global rx2; global rw2; global ry2; global rh2
global target
global thisIdx
global worldWidth
global worldHeight
global lifeIdx
global lifeCount

worldWidth = 150;
worldHeight = 500;

target = [0, 450];

ry1 = 175;
rw1 = 125;
rh1 = 10;
rx1 = worldWidth - (rw1 / 2);

ry2 = 275;
rw2 = 125;
rh2 = 10;
rx2 = -worldWidth + (rw2 / 2);

rectMain = patch([rx1 - rw1, rx1 - rw1, rx1 + rw1, rx1 + rw1], [ry1 - rh1, ry1 + rh1, ry1 + rh1, ry1 - rh1], 'w');
rectMain2 = patch([rx2 - rw2, rx2 - rw2, rx2 + rw2, rx2 + rw2], [ry2 - rh2, ry2 + rh2, ry2 + rh2, ry2 - rh2], 'w');
numPoints = 20;
targetR = 5;
x = target(1) + targetR * cos(linspace(0, 2 * pi, 20));
y = target(2) + targetR * sin(linspace(0, 2 * pi, 20));
targMain = patch(x, y, 'r');
mainGen = uicontrol('Style', 'text', 'Position', [400, 45, 120, 20], 'String', 'Gen 1');
hold on


axis([-worldWidth, worldWidth, 0, worldHeight]);
lifeCount = 300;

figure('WindowState', 'maximized', 'Color', 'k');
bestFig = gcf;
axis equal
axis off
axis([-worldWidth, worldWidth, 0, worldHeight]);
rectBest = patch([rx1 - rw1, rx1 - rw1, rx1 + rw1, rx1 + rw1], [ry1 - rh1, ry1 + rh1, ry1 + rh1, ry1 - rh1], 'w');
rectBest2 = patch([rx2 - rw2, rx2 - rw2, rx2 + rw2, rx2 + rw2], [ry2 - rh2, ry2 + rh2, ry2 + rh2, ry2 - rh2], 'w');
targBest = patch(x, y, 'r');
bestGen = uicontrol('Style', 'text', 'Position', [400, 45, 120, 20], 'String', 'Gen 1');
hold on

frameRate = 30;

writerObj = VideoWriter('Smart Rockets.avi');
writerObj.FrameRate = frameRate;

record = 1;

if record
    open(writerObj);
end

figure(mainFig)
pop = Population(100);
dt = 0.075;

drawCutoff = 10;
maxFitArr = [];
avgFitArr = [];

nextVidLoop = 100;

gen = 1;
while gen <= 500
    
    genStr = sprintf('Gen %i', gen);
    set(mainGen, 'String', genStr);
    set(bestGen, 'String', genStr);
    
    figure(mainFig)
    
    for lifeIdx = 1:lifeCount
        % while 1
        startLoop = now;
        
        pop.update
        
        if gen <= drawCutoff
            if record
                writeVideo(writerObj, getframe(gcf))
            else
                drawnow
            end
        end
        
        if pop.allStopped
            break
        end
        
    end
    
    pop.evaluate
    
    maxFitArr = [maxFitArr, pop.popMaxFit];
    avgFitArr = [avgFitArr, pop.popAvgFit];
    figure(fitFig)
    clf
    hold on
    plot(avgFitArr)
    plot(maxFitArr)
    legend({'Average Fitness', 'Max Fitness'});
    
    if gen > drawCutoff
        figure(bestFig)
        bestRocket = pop.getBest;
        bestPop = Population(1);
        bestPop.rockets(1).dna = bestRocket.dna;
        
        for lifeIdx = 1:lifeCount
            bestPop.update
            if record
                writeVideo(writerObj, getframe(gcf))
            else
                drawnow
            end
            
        end
        if record
            for i = 1:(frameRate * 0.5)
                writeVideo(writerObj, getframe(gcf))
            end
        end
        
        bestPop.kill;
    end
    lastMax = maxFitArr(end);
    lastAvg = avgFitArr(end);
    dev = abs(lastAvg - lastMax) / lastAvg;
    
    if dev < 0.03
        break
    else
        figure(mainFig)
        % make new pop
        thisIdx = 1;
        pop.selection
        
        % make new video file every 100 generations
        if record
            if gen >= nextVidLoop
                close(writerObj)
                fname = sprintf('Smart Rockets %i.avi', gen);
                writerObj = VideoWriter(fname);
                writerObj.FrameRate = frameRate;
                open(writerObj)
                nextVidLoop = nextVidLoop + 100;
            end
        end
        
        gen = gen + 1;
    end
end

if record
    for i = 1:(frameRate * 5)
        writeVideo(writerObj, getframe(gcf))
    end
    close(writerObj)
end