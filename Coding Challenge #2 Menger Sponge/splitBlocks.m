function out = splitBlocks(in)

    out = [];
    
    for i = 1:size(in, 1)
        
    thisSize = in(i, 4);
    adjust = thisSize / 3;
    newSize = thisSize / 3;
    x = in(i, 1);
    y = in(i, 2);
    z = in(i, 3);
    
    % Find centerpoints of new blocks
    newPoints = [x - adjust, y - adjust, z - adjust, newSize;
                 x, y - adjust, z - adjust, newSize;
                 x + adjust, y - adjust, z - adjust, newSize;
                 x - adjust, y - adjust, z, newSize;
                 x + adjust, y - adjust, z, newSize;
                 x - adjust, y - adjust, z + adjust, newSize;
                 x, y - adjust, z + adjust, newSize;
                 x + adjust, y - adjust, z + adjust, newSize;
                 x - adjust, y, z - adjust, newSize;
                 x + adjust, y, z - adjust, newSize;
                 x - adjust, y, z + adjust, newSize;
                 x + adjust, y, z + adjust, newSize;
                 x - adjust, y + adjust, z - adjust, newSize;
                 x, y + adjust, z - adjust, newSize;
                 x + adjust, y + adjust, z - adjust, newSize;
                 x - adjust, y + adjust, z, newSize;
                 x + adjust, y + adjust, z, newSize;
                 x - adjust, y + adjust, z + adjust, newSize;
                 x, y + adjust, z + adjust, newSize;
                 x + adjust, y + adjust, z + adjust, newSize];
             
    out = [out; newPoints];
    
    end
    
end