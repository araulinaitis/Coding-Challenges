classdef Point < handle
    properties
        x
        y
        z
        vx = 0;
        vy = 0;
        vz = 0;
        m
        r = 1;
        color = [0, 0, 0];
        connections = [];
        connectionForce = [];
        force = [0, 0];
        dynamic = 1;
%         s
%         f
        
    end
    
    methods
        function obj = Point(x, y, z, m)
            if nargin > 0
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.m = m;
                
%                 numPoints = 20;
%                 [X, Y, Z] = sphere(numPoints);
                
%                 obj.s = surf(X, Y, Z);
%                 obj.f = line([x, y], [x, y], 'color', 'r', 'lineWidth', 2);
            end
        end
        
        function makeStatic(obj)
            obj.dynamic = 0;
%             set(obj.s, 'FaceColor', 'r');
        end
        
        function makeDynamic(obj)
            obj.dynamic = 1;
%             set(obj.s, 'FaceColor', 'g');
        end
        
        function calculateForce(obj)
            if obj.dynamic
                obj.force = sum(obj.connectionForce, 1);
            end
            
%             obj.f.XData = [obj.x, obj.x + obj.force(1) / 10];
%             obj.f.YData = [obj.y, obj.y + obj.force(2) / 10];
            
        end
        
        function addConnectionForce(obj, force)
            % only add non-zero forces
            if sum(abs(force)) > 1e-10
                obj.connectionForce = [obj.connectionForce; force];
            end
        end
        
        function resetForce(obj)
            obj.connectionForce = [0, 0, -obj.m * 1];
        end
        
        function move(obj, dt)
            damping = 0.05;
            if obj.dynamic
                dvx = (obj.force(1) / obj.m) * dt - obj.vx * damping;
                dvy = (obj.force(2) / obj.m) * dt - obj.vy * damping;
                dvz = (obj.force(3) / obj.m) * dt - obj.vz * damping;
                
                obj.vx = obj.vx + dvx;
                obj.vy = obj.vy + dvy;
                obj.vz = obj.vz + dvz;
                
                obj.x = obj.x + obj.vx * dt;
                obj.y = obj.y + obj.vy * dt;
                obj.z = obj.z + obj.vz * dt;
%                 obj.s.XData = obj.s.XData + obj.vx * dt;
%                 obj.s.YData = obj.s.YData + obj.vy * dt;
%                 obj.s.ZData = obj.s.ZData + obj.vz * dt;
            end
        end
    end
end