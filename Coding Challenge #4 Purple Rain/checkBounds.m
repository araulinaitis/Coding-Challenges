function out = checkBounds(in, max)

i = 1;
while i <= size(in, 1)
    if in{i}.getX() > max
        in(i) = [];
    else
        i = i + 1;
    end
end

out = in;

end