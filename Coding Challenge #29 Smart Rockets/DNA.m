classdef DNA < handle
    properties
        genes
        len
    end
    
    methods
        function obj = DNA(genes)
            
            if nargin > 0
                obj.genes = genes;
            else
                global lifeCount
                
                for i = 1:lifeCount
                    ang = 2*pi*rand;
                    vec = 0.3 * [cos(ang), sin(ang)];
                    obj.genes{i} = vec;
                end
            end
        end
        
        function newdna = crossover(obj, partner)
            newgenes = {};
            midPoint = randi([1, length(obj.genes)]);
            for i = 1:length(obj.genes)
                if i > midPoint
                    newgenes{i} = obj.genes{i};
                else
                    newgenes{i} = partner.genes{i};
                end
            end
            newdna = DNA(newgenes);
        end
        
        function mutation(obj)
            for i = 1:length(obj.genes)
                if rand() < 0.005
                    ang = randn;
                    vec = 0.3 * [cos(ang), sin(ang)];
                    obj.genes{i} = vec;
%                     ang = scale * 0.1 * randn;
%                     rotMat = [cos(ang), -sin(ang); sin(ang), cos(ang)];
%                     obj.genes{i} = (rotMat * obj.genes{i}')';
                end
            end
        end
        
    end
end