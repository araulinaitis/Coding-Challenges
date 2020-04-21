clear all; clc; close all;

figure('WindowState', 'maximized', 'color', 'k');
axis equal
axis off
hold on

worldWidth = 25;
worldLength = 25;

sigma = 10;
rho = 28;
beta = 8/3;

delX = @(x_, y_, z_) sigma * (y_ - x_);
delY = @(x_, y_, z_) x_ * (rho - z_) - y_;
delZ = @(x_, y_, z_) x_ * y_ - beta * z_;

% color equations, for fun!
red = @(t_) 0.5 + 0.5 * sin(t_);
green = @(t_) 0.5 + 0.5 * sin(t_ + (2 * pi / 3));
blue = @(t_) 0.5 + 0.5 * sin(t_ + (4 * pi / 3));

x = -.1 + .2 * rand;
y = -.1 + .2 * rand;
z = -.1 + .2 * rand;

frameRate = 30;
dt = 1 / (4 * frameRate);

writerObj = VideoWriter('Lorenze Attractor.avi');
writerObj.FrameRate = frameRate;

open(writerObj);

viewAng = 0;
view(viewAng, 30);
t = 0;


for i = 1:(frameRate * 120)
    startLoop = now;
    
    t = t + dt;
    viewAng = viewAng + 30 / frameRate;
    view(viewAng, 30);
    
    % save last coords
    lastX = x;
    lastY = y;
    lastZ = z;
    
    % get new coords
    x = x + delX(lastX, lastY, lastZ) * dt;
    y = y + delY(lastX, lastY, lastZ) * dt;
    z = z + delZ(lastX, lastY, lastZ) * dt;
    
    % calculate new color
    r = red(t);
    g = green(t);
    b = blue(t);
    
    % make line between last point and this point
    line([lastX, x], [lastY, y], [lastZ, z], 'color', [r, g, b])
    
    drawnow
    writeVideo(writerObj, getframe(gcf))
    
    
    while (now - startLoop) * 10^5 < (1 / frameRate)
    end
end

for i = 1:(frameRate * 5)
    viewAng = viewAng + 30 / frameRate;
    view(viewAng, 30);
    writeVideo(writerObj, getframe(gcf))
end
close(writerObj)