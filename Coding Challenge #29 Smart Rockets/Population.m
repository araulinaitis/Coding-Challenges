classdef Population < handle
    properties
        rockets
        size
        matingPool
        popMaxFit
        popAvgFit
        bestRocket
    end
    
    methods
        function obj = Population(size)
            obj.size = size;
            obj.rockets = Rocket.empty;
            for i = 1:size
                obj.rockets(i) = Rocket();
            end
        end
        
        function update(obj)
            for i = 1:obj.size
                obj.rockets(i).update
            end
        end
        
        function kill(obj)
            for i = 1:obj.size
                obj.rockets(i).kill
            end
        end
        
        function evaluate(obj)
            maxFit = -inf;
            avgFit = 0;
            for i = 1:obj.size
                thisFit = obj.rockets(i).calcFitness;
                % obj.rockets(i).color;
                avgFit = avgFit + thisFit;
                if thisFit > maxFit
                    maxFit = thisFit;
                    obj.bestRocket = obj.rockets(i);
                end
            end
            obj.popMaxFit = maxFit;
            obj.popAvgFit = avgFit / obj.size;
            
            
            for i = 1:obj.size
                obj.rockets(i).fitness = obj.rockets(i).fitness / maxFit;
            end
            
            obj.matingPool = [];
            
            for i = 1:obj.size
                n = ceil(obj.rockets(i).fitness * 100);
                for j = 1:n
                    obj.matingPool = [obj.matingPool, obj.rockets(i)];
                end
            end
            
        end
        
        function selection(obj)
            newRockets = Rocket.empty;
            if isempty(obj.matingPool)
                for i = 1:obj.size
                    newRockets(i) = Rocket; %random rockets if all were 0
                end
            else
                for i = 1:obj.size
                    idx1 = randi([1, length(obj.matingPool)]);
                    parent1 = obj.matingPool(idx1).dna;
                    
                    parent1Idx = obj.matingPool(idx1).idx;
                    
                    idx2 = randi([1, length(obj.matingPool)]);
                    parent2Idx = obj.matingPool(idx2).idx;
                    
                    while parent2Idx == parent1Idx
                        idx2 = randi([1, length(obj.matingPool)]);
                        parent2Idx = obj.matingPool(idx2).idx;
                    end
                    parent2 = obj.matingPool(idx2).dna;
                    
                    child = parent1.crossover(parent2);
                    child.mutation;
                    newRockets(i) = Rocket(child);
                end
            end
            
            obj.kill
            
            obj.rockets = newRockets;
        end
        
        function out = allComplete(obj)
            out = 1;
            for i = 1:obj.size
                if ~obj.rockets(i).completed
                    out = 0;
                    break
                end
            end
        end
        
        function out = getBest(obj)
            out = obj.bestRocket;
        end
        
        function out = allStopped(obj)
            out = 1;
            for i = 1:obj.size
                if ~obj.rockets(i).completed
                    out = 0;
                    break
                end
            end
        end
        
    end
end
















