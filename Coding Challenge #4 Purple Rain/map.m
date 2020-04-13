function out = map(in, inMin, inMax, outMin, outMax)
out = outMin + ((in - inMin) / (inMax - inMin)) * (outMax - outMin);
end