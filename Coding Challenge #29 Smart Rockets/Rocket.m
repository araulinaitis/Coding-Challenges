classdef Rocket < handle
    properties
        pos
        lastPos
        closestD
        closestPos
        closestIdx
        vel
        acc = [0, 0]
        dna
        count = 1
        p
        fitness
        completed = 0
        idx
        completeIdx = 0
        p1
        p2
        p3
        p4
        dt1
        dt2
        dt3
        dt4
    end
    
    properties(Access = private)
        ang
    end
    
    methods
        function obj = Rocket(dna)
            if nargin > 0
                obj.dna = dna;
            else
                obj.dna = DNA;
            end
            obj.pos = [0, 12.5];
            obj.vel = [0, 0];
            obj.ang = pi / 2;
            obj.closestD = inf;
            
            global thisIdx
            obj.idx = thisIdx;
            thisIdx = thisIdx + 1;
            
            % make rectangle
            x = [-2.5, -2.5, 2.5, 2.5];
            y = [0, 25, 25, 0];
            obj.p = patch(x, y, 'w');
            
            % prepopulate world distance calculations
            global rx1; global rw1; global ry1; global rh1
            global rx2; global rw2; global ry2; global rh2
            global target
            obj.p1 = [rx2 + rw2, ry2 + rh2];
            obj.p2 = [rx2 + rw2, ry2 - rh2];
            obj.p3 = [rx1 - rw1, ry1 + rh1];
            obj.p4 = [rx1 - rw1, ry1 - rh1];
            
            obj.dt1 = sqrt(sum((target - obj.p1) .* (target - obj.p1)));
            d12 = sqrt(sum((obj.p1 - obj.p2) .* (obj.p1 - obj.p2)));
            d23 = sqrt(sum((obj.p2 - obj.p3) .* (obj.p2 - obj.p3)));
            d34 = sqrt(sum((obj.p3 - obj.p4) .* (obj.p3 - obj.p4)));
            obj.dt2 = obj.dt1 + d12;
            obj.dt3 = obj.dt1 + d12 + d23;
            obj.dt4 = obj.dt1 + d12 + d23 +d34;
            
            
        end
        
        function applyForce(obj, force)
            obj.acc = obj.acc + force;
        end
        
        function update(obj)
            
            if ~obj.completed
                global target
                global lifeIdx
                global rx1; global rw1; global ry1; global rh1
                global rx2; global rw2; global ry2; global rh2
                global worldWidth; global worldHeight
                
                obj.applyForce(obj.dna.genes{obj.count});
                obj.count = obj.count + 1;
                
                thisD = sum((obj.pos - target) .* (obj.pos - target));
                if thisD < 31.25
                    obj.completed = 1;
                    obj.pos = target;
                    obj.completeIdx = lifeIdx;
                    obj.closestPos = obj.pos;
                    obj.closestIdx = lifeIdx;
                else
                    if thisD < obj.closestD
                        obj.closestPos = obj.pos;
                        obj.closestIdx = lifeIdx;
                    end
                end
                
                % bouncy in x
                if obj.pos(1) <= -worldWidth || obj.pos(1) >= worldWidth
                    % obj.vel = obj.vel .* [-1, 1];
                    obj.vel(1) = 0;
                    obj.acc(1) = 0;
                end
                
                if (obj.pos(2) >= obj.p2(2) && obj.pos(2) <= obj.p1(2) && obj.pos(1) <= obj.p1(1))
                    if obj.lastPos(1) > obj.p1(1)
                        % obj.vel = obj.vel .* [-1, 1];
                        obj.vel(1) = 0;
                        obj.acc(1) = 0;
                    end
                end
                
                if (obj.pos(2) >= obj.p4(2) && obj.pos(2) <= obj.p3(2) && obj.pos(1) >= obj.p3(1))
                    if obj.lastPos(1) < obj.p4(1)
%                         obj.vel = obj.vel .* [-1, 1];
                        obj.vel(1) = 0;
                        obj.acc(1) = 0;
                    end
                end
                
                % bouncy in y
                if obj.pos(2) <= 0 || obj.pos(2) >= worldHeight
                    % obj.vel = obj.vel .* [1, -1];
                    obj.vel(2) = 0;
                    obj.acc(2) = 0;
                end
                
                if (obj.pos(1) >= obj.p4(1) && (obj.pos(2) >= obj.p4(2) && obj.pos(2) <= obj.p3(2))) || (obj.pos(1) <= obj.p1(1) && (obj.pos(2) <= obj.p1(2) && obj.pos(2) >= obj.p2(2)))
                    if obj.lastPos(2) < obj.p4(2) || obj.lastPos(2) > obj.p3(2) || obj.lastPos(2) < obj.p2(2) || obj.lastPos > obj.p1(2)
                        % obj.vel = obj.vel .* [1, -1];
                        obj.vel(2) = 0;
                        obj.acc(2) = 0;
                    end
                end
                
                obj.vel = obj.vel + obj.acc;
                % limit velocity
                if sqrt(sum(obj.vel .* obj.vel)) > 4
                    obj.vel = 4 * obj.vel / sqrt(sum(obj.vel .* obj.vel));
                end
                
                obj.lastPos = obj.pos;
                obj.pos = obj.pos + obj.vel;
                obj.acc = obj.acc * 0;
                
                obj.p.Vertices = obj.p.Vertices + obj.vel;
                
                % need to rotate patch by the change in angle (accel)
                
                newAngle = angle(obj.vel(1) + 1i * obj.vel(2));
                thisAngle = newAngle - obj.ang;
                rotMat = [cos(thisAngle), -sin(thisAngle); sin(thisAngle), cos(thisAngle)];
                tempVert = obj.p.Vertices;
                tempVert = tempVert - obj.pos;
                tempVert = (rotMat * tempVert')';
                obj.p.Vertices = tempVert + obj.pos;
                obj.ang = newAngle;
                
            end
            
            
        end
        
        function kill(obj)
            delete(obj.p)
        end
        
        function fit = calcFitness(obj)
            
            global lifeCount
            %             d = obj.pos - target;
            %             obj.fitness = 1 / sum(d .* d);
            %             obj.fitness = Rocket.map(sqrt(sum(d .* d)) / obj.closestIdx, 0, 400, 400, 0);
            
            %             obj.fitness = 1 / ((1 * obj.closestD) + (0 * obj.closestIdx));
            %             obj.fitness = Rocket.map(sqrt(obj.closestD), 0, 400, 400, 0);
            
            if obj.completed
                obj.fitness = Rocket.map(obj.completeIdx, 0, lifeCount, 100, 50);
                %                 obj.fitness = obj.fitness * 10;
            else
                
                global target
                d = obj.pos - target;
                obj.fitness = Rocket.map(sqrt(sum(d .* d)), 0, 500, 10, 0);
                
                %                 global rx1; global rw1; global ry1; global rh1
                %                 global rx2; global rw2; global ry2; global rh2
                %                 % d = sqrt(sum((obj.pos - target) .* (obj.pos - target)));
                %                 if obj.pos(2) < ry1 - rh1
                %                     d = sqrt(sum((obj.pos - obj.p4) .* (obj.pos - obj.p4)));
                %                     d = d + obj.dt4;
                %                 obj.fitness = Rocket.map(d, 0, 0.75 * (obj.dt4 + sqrt(sum(obj.p4 .* obj.p4))), 1, 0);
                %                 elseif obj.pos(2) < ry1 + rh1
                %                     d = sqrt(sum((obj.pos - obj.p3) .* (obj.pos - obj.p3)));
                %                     d = d + obj.dt3;
                %                     if obj.pos(1) < rx1 - rw1
                %                         d = min([d, obj.dt2 + sqrt(sum((obj.pos - obj.p2) .* (obj.pos - obj.p2)))]);
                %                     end
                %                 obj.fitness = Rocket.map(d, 0, 0.75 * (obj.dt4 + sqrt(sum(obj.p4 .* obj.p4))), 1, 0);
                %                 elseif obj.pos(2) < ry2 - rh2
                %                     d = sqrt(sum((obj.pos - obj.p2) .* (obj.pos - obj.p2)));
                %                     d = d + obj.dt2;
                %                 obj.fitness = Rocket.map(d, 0, 0.75 * (obj.dt4 + sqrt(sum(obj.p4 .* obj.p4))), 1, 0);
                %                 elseif obj.pos(2) < ry2 + rh2
                %                     d = sqrt(sum((obj.pos - obj.p1) .* (obj.pos - obj.p1)));
                %                     d = d + obj.dt1;
                %                     if obj.pos(1) > rx2 + rw2
                %                         d = min([d, sqrt(sum((obj.pos - target) .* (obj.pos - target)))]);
                %                     end
                %                 obj.fitness = Rocket.map(d, 0, 0.75 * (obj.dt4 + sqrt(sum(obj.p4 .* obj.p4))), 1, 0);
                %                 else
                %                     d = sqrt(sum((obj.closestPos - target) .* (obj.closestPos - target)));
                %                     if d < 25
                %                         obj.fitness = Rocket.map(obj.closestIdx, 0, lifeCount, 7, 1);
                %                     else
                %                         obj.fitness = Rocket.map(d, 0, obj.dt1, 7, 5);
                %                     end
                %                 end
                %
                % %                 obj.fitness = Rocket.map(d, 0, 0.75 * (obj.dt1 + obj.d12 + obj.d23 + obj.d34 + sqrt(sum(obj.p4 .* obj.p4))), 1, 0);
                %
                %                 if obj.fitness < 0
                %                     obj.fitness = 0;
                %                 end
            end
            fit = obj.fitness;
        end
        
        function color(obj)
            colR = linspace(1, 0, 256);
            colG = linspace(0, 1, 256);
            %             colB = zeros(255, 1);
            
            val = round(Rocket.map(obj.fitness, 0, 1, 1, 256));
            obj.p.FaceColor = [colR(val), colG(val), 0];
        end
        
    end
    
    methods(Static)
        function out = map(x, in_min, in_max, out_min, out_max)
            out = (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
        end
        
        function showFitnessField(width, height)
            
            step = 4;
            iArr = -width:step:width;
            jArr = 1:step:height;
            
            fitArr = zeros(length(jArr), length(iArr));
            for i = 1:length(iArr)
                for j = 1:length(jArr)
                    thisRocket = Rocket();
                    thisRocket.pos = [iArr(i), jArr(j)];
                    thisRocket.closestPos = [iArr(i), j];
                    fitArr(j, i) = thisRocket.calcFitness;
                    thisRocket.kill;
                    
                end
            end
            
            fitArr = fitArr / max(max(fitArr));
            fitArr = uint8(Rocket.map(fitArr, 0, 1, 1, 256));
            fitArr = fitArr(end:-1:1, :); % flip fitArr top/bottom to make y positive "up"
            
            img = zeros(length(jArr), length(iArr), 3);
            
            rArr = linspace(255, 0, 256);
            gArr = linspace(0, 255, 256);
            img(:, :, 1) = rArr(fitArr);
            img(:, :, 2) = gArr(fitArr);
            
            image(uint8(img));
            
            
        end
        
    end
    
end





