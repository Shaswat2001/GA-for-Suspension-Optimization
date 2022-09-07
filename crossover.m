function [offspring] = crossover(parent, no_offspring, ~)

    offspring = zeros(no_offspring, size(parent, 2), size(parent, 3));

    for i = 1:no_offspring
        parent1_index = mod(i, size(parent, 1)) + 1;
        parent2_index = mod((i+1), size(parent, 1)) + 1;
        n = rand(1, 1);
        offspring(i,:,:) = (n * parent(parent1_index,:,:)) + ((1-n) * parent(parent2_index,:,:));
    end

end