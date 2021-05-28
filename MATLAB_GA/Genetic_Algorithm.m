load Camber_model
load TOE_Model

no_generation=10;
no_parents=7;
mutation_rate=0.15;
[all_geometry,all_result]=Dataset_Create();
pop=all_geometry;
pop_size=10;
no_offspring=pop_size-no_parents;
for idx=1:no_generation
    
    [val_camber,val_toe]=Prepare_Dataset(pop,Mattern_Camberl,Mattern_TOE); 
    fitness=fitness_function(pop,val_camber,val_toe);
    parent=Roulette_Wheel_Selection(pop,no_parents,fitness);
    offspring=crossover(parent,no_offspring);
    mutate=mutation(all_geometry,offspring);
    pop=[pop;mutate];
end

[M,I]=min(fitness);
val_camber(I,:)
val_toe(I,:)
pop(I,:,:)