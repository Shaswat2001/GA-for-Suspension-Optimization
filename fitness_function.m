function [fitness] = fitness_function(pop, val_cam, val_toe)

fitness = zeros(size(pop,1),1);

for i = 1:size(pop, 1)
    if ((val_cam(i, 1) >= -2 && val_cam(i, 1) <= 2) && (val_cam(i, 2) >= -2 && val_cam(i, 2) <= 2))
        camber_fitness = abs(val_cam(i, 2) - val_cam(i, 1))/8;
        fitness(i) = fitness(i) + camber_fitness;
        
    else
        fitness(i) = 99999;
    end
    
    if ((val_toe(i, 1) >= -1 && val_toe(i, 1) <= 1) && (val_toe(i, 2) >= -1 && val_toe(i, 2) <= 1))
        toe_fitness = abs(val_toe(i, 2) - val_toe(i, 1))/4;
        fitness(i) = fitness(i) + toe_fitness;
    else
        fitness(i) = 99999;
    end
    kingpin = (90 - atan((pop(i, 3, 3) - pop(i, 6, 3))/(pop(i, 3, 2) - pop(i, 6, 2))) * 180) / pi;
    castor = (90 - atan((pop(i, 3, 3) - pop(i, 6, 3))/(pop(i, 3, 1) - pop(i, 6, 1))) * 180) / pi;
    
    if (kingpin <= 4 && kingpin >= 9)
        fitness(i) = 99999;
    end
    
    if (castor <= 3 && castor >= 8)
        fitness(i) = 99999;
    end
    
end