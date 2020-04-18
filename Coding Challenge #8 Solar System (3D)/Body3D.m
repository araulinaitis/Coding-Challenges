classdef Body3D < handle
    properties
        x
        y
        z
        r
        parent
        parentDist;
        children = [];
    end
    
    properties(Access = private)
        s
        rotMat
    end
    
    methods
        function obj = Body3D(x, y, z, r, parent)
            obj.x = x;
            obj.y = y;
            obj.z = z;
            obj.r = r;
            obj.parent = parent;
            
            % pick axis and angle based on "Rotation matrix from axis and
            % agnle" https://en.wikipedia.org/wiki/Rotation_matrix
            
            % alpha is rotation speed (rad/simulation step), make it based on size
            if isempty(parent)
                dist = sqrt(x * x + y * y);
                parentVec = [0, 0, 0];
                obj.parentDist = 15 * r;
                
            else
                parentVec = [x - parent.x, y - parent.y, z - parent.z];
                dist = sqrt(sum(parentVec .* parentVec));
                obj.parentDist = dist;
                
%                 X = [parent.x, x];
%                 Y = [parent.y, y];
%                 Z = [parent.z, z];
%                 
%                 plot3(X, Y, Z, 'b', 'LineWidth', 2)
            
            end
            
            
            alpha = 200/(r * dist);
            
            % Axis needs to be perpendicular to the [x, y, z] vector
            % between parent and child
            
            % pick random x/y to put into plane equation
            x_ = -1 + 2 * rand;
            y_ = -1 + 2 * rand;
            z_ = -(parentVec(1) * x_ + parentVec(2) * y_) / parentVec(3);
            
            vec = [x_, y_, z_];
            
%             vec = cross(tempVec, parentVec);
            
%             vec = randn(1, 3);
            vecMag = sqrt(sum(vec .* vec));
            v = vec / vecMag;
%             dot(v, parentVec)
            
            cosa = cos(alpha);
            sina = sin(alpha);
            
            obj.rotMat = [cosa + v(1) * v(1) * (1 - cosa),        v(1) * v(2) * (1 - cosa) - v(3) * sina, v(1) * v(3) * (1 - cosa) + v(2) * sina;...
                          v(2) * v(1) * (1 - cosa) + v(3) * sina, cosa + v(2) * v(2) * (1 - cosa),        v(2) * v(3) * (1 - cosa) - v(1) * sina;...
                          v(3) * v(1) * (1 - cosa) - v(2) * sina, v(3) * v(2) * (1 - cosa) + v(1) * sina, cosa + v(3) * v(3) * (1 - cosa)       ];
            
            numPoints = 20;
            [xArr, yArr, zArr] = sphere(numPoints);
            
            xArr = r * xArr + x;
            yArr = r * yArr + y;
            zArr = r * zArr + z;
            
            obj.s = surf(xArr, yArr, zArr, 'FaceColor', '[1, 1, 1]', 'FaceLighting', 'gouraud', 'EdgeColor', 'none');
            axis off
            
%             X = [x; x + vec(1)];
%             Y = [y; y + vec(2)];
%             Z = [z; z + vec(3)];
%             
%             plot3(X, Y, Z, 'r', 'LineWidth', 3)
%             keyboard
            
            
        end
        
        function out = getCenter(obj)
            out = [obj.x, obj.y, obj.z];
        end
        
        function addChild(obj)
            newR = randi(round([obj.r / 4, obj.r / 2]));
            angle = 2 * pi * rand();
            offset = randi([2 * (obj.r + newR), 5 * (obj.r + newR)]);
            newX = obj.x + offset * cos(angle);
            newY = obj.y + offset * sin(angle);
            
            newBody = Body3D(newX, newY, newR, obj);
            
            obj.children = [obj.children; newBody];
            
        end
        
        function addChildren(obj, n)
            
            regions = (pi / n):(2 * pi / n): 2 * pi;
            
            halfScoop = (2 * pi) / n / 4 / 2;
            
            elevation = -(pi / 4) + (pi / 2) * rand();
            
            for i = 1:n
                newR = randi(round([obj.r / 3, obj.r * 2/ 3]));
                
                angle = regions(i) - halfScoop + 2 * halfScoop * rand();
                
                offset = randi([round(obj.r + newR), round(obj.parentDist / 2)]);
                
                [newX, newY, newZ] = sph2cart(angle, elevation, offset);

                newBody = Body3D(obj.x + newX, obj.y + newY, obj.z + newZ, newR, obj);

                obj.children = [obj.children; newBody];
            end
            
        end
        
        function rotateAboutPoint(obj, x, y, z, rotMat)
            
            xArr = obj.s.XData;
            yArr = obj.s.YData;
            zArr = obj.s.ZData;
            
            % convert n x n matrices into serial list of 3 x n^2 x, y, z
            % points
            
            pointArr = zeros(3, length(xArr * length(xArr)));
            
            for i = 1:(length(xArr) * length(xArr))
                pointArr(:, i) = [xArr(i); yArr(i); zArr(i)];
            end
            pointArr = [pointArr, [obj.x; obj.y; obj.z]];
            
            pointArr = pointArr - [x; y; z];
            
            rotArr = rotMat * pointArr;
            
            %move back
            rotArr = rotArr + [x; y; z];
            
            % go back from 3 x n^2 to 3 n x n matrices
            
            for i = 1:(length(xArr) * length(xArr))
               xArr(i) = rotArr(1, i);
               yArr(i) = rotArr(2, i);
               zArr(i) = rotArr(3, i);
            end
            
            % put arrays back
            obj.s.XData = xArr;
            obj.s.YData = yArr;
            obj.s.ZData = zArr;
            
            % put x and y back
            obj.x = rotArr(1, end);
            obj.y = rotArr(2, end);
            obj.z = rotArr(3, end);
            
            for i = 1:length(obj.children)
                obj.children(i).rotateAboutPoint(x, y, z, rotMat);
            end
            
        end
        
        function rotate(obj)
            
            obj.rotateAboutPoint(obj.parent.x, obj.parent.y, obj.parent.z, obj.rotMat)
            
            for i = 1:length(obj.children)
                obj.children(i).rotate
            end
            
        end
        
    end
end





