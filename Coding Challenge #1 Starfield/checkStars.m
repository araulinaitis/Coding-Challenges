function out = checkStars(in, xMin, xMax, yMin, yMax)
i = 1;
while i <= length(in)
    thisObj = in{i};
    if thisObj.x < xMin || thisObj.x > xMax || thisObj.y < yMin || thisObj.y > yMax
        delete(thisObj)
        in(i) = [];
    else
        i = i + 1;
    end
end

out = in;