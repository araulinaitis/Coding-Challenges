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
        cellSize = 10;
        order
    end
    
    methods
        function obj = MazeCell(x, y)
            if nargin > 0
                obj.x = x;
                obj.y = y;
            end
            
            obj.order = randperm(4);
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
        
    end
end