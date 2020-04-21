classdef MazeCell < handle
    properties
        x
        y
        north
        south
        east
        west
        nWall
        sWall
        eWall
        wWall
        visited = 0;
        cellSize
        order
        prev
        next
    end
    properties(Access = private)
        p
    end
    
    methods
        function obj = MazeCell(x, y)
            if nargin > 0
                obj.x = x;
                obj.y = y;
                
                
                obj.order = randperm(4);
                
                thisSize = 10;
                obj.cellSize = thisSize;
                
                x1 = thisSize * (x - 1);
                y1 = thisSize * (y - 1);
                x2 = thisSize * x;
                y2 = y1;
                x3 = x2;
                y3 = thisSize * y;
                x4 = x1;
                y4 = y3;
                
                obj.p = patch([x1; x2; x3; x4], [y1; y2; y3; y4], 'w', 'EdgeColor', 'none');
            end
            
        end
        
        function build(obj)
            obj.visited = 1;
            
            
            for i = obj.order
                switch i
                    case 1
                        if ~isempty(obj.north) && ~obj.north.visited
                            % delete wall
                            obj.nWall.deleteWall;
                            obj.nWall = [];
                            obj.north.sWall = [];
                            
                            % go to next cell
                            obj.north.build();
                        end
                    case 2
                        if ~isempty(obj.south) && ~obj.south.visited
                            % delete wall
                            obj.sWall.deleteWall;
                            obj.sWall = [];
                            obj.south.nWall = [];
                            
                            % go to next cell
                            obj.south.build();
                        end
                    case 3
                        if ~isempty(obj.east) && ~obj.east.visited
                            % delete wall
                            obj.eWall.deleteWall;
                            obj.eWall = [];
                            obj.east.wWall = [];
                            
                            % go to next cell
                            obj.east.build();
                        end
                    case 4
                        if ~isempty(obj.west) && ~obj.west.visited
                            % delete wall
                            obj.wWall.deleteWall;
                            obj.wWall = [];
                            obj.west.eWall = [];
                            
                            % go to next cell
                            obj.west.build();
                        end
                end
            end
        end
        
        function makeWalls(obj, cells)
            
            if isempty(obj.nWall)
                if ~isempty(obj.north)
                    obj.nWall = Wall(obj, cells(obj.y - 1, obj.x), 'n');
                    cells(obj.y - 1 , obj.x).sWall = obj.nWall;
                else
                    obj.nWall = Wall(obj, [], 'n');
                end
            end
            
            if isempty(obj.sWall)
                if ~isempty(obj.south)
                    obj.sWall = Wall(obj, cells(obj.y + 1, obj.x), 's');
                    cells(obj.y + 1 , obj.x).nWall = obj.sWall;
                else
                    obj.sWall = Wall(obj, [], 's');
                end
            end
            
            if isempty(obj.eWall)
                if ~isempty(obj.east)
                    obj.eWall = Wall(obj, cells(obj.y, obj.x + 1), 'e');
                    cells(obj.y , obj.x + 1).wWall = obj.eWall;
                else
                    obj.eWall = Wall(obj, [], 'e');
                end
            end
            
            if isempty(obj.wWall)
                if ~isempty(obj.west)
                    obj.wWall = Wall(obj, cells(obj.y - 1, obj.x - 1), 'w');
                    cells(obj.y, obj.x - 1).eWall = obj.wWall;
                else
                    obj.wWall = Wall(obj, [], 'w');
                end
            end
            
        end
        
        function assignNeighbors(obj, cells, worldWidth, worldHeight)
            
            if obj.y == 1
                obj.north = [];
                obj.south = cells(obj.y + 1, obj.x);
            elseif obj.y == worldHeight
                obj.south = [];
                obj.north = cells(obj.y - 1, obj.x);
            else
                obj.north = cells(obj.y - 1, obj.x);
                obj.south = cells(obj.y + 1, obj.x);
            end
            
            if obj.x == 1
                obj.west = [];
                obj.east = cells(obj.y, obj.x + 1);
            elseif obj.x == worldWidth
                obj.east = [];
                obj.west = cells(obj.y, obj.x - 1);
            else
                obj.west = cells(obj.y, obj.x - 1);
                obj.east = cells(obj.y, obj.x + 1);
            end
            
        end
        
        function highlight(obj)
            set(obj.p, 'FaceColor', [.7, 0, 0]);
        end
        
        function dehighlight(obj)
            set(obj.p, 'FaceColor', [0.95, .75, .75]);
        end
        
    end
end