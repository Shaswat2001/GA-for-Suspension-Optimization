function [parents]= Roulette_Wheel_Selection(population,no_parents,fitness)
    previous_prob=0;
    fitness=1./(fitness+1e-4);
    prob_sel=fitness./sum(fitness);
    parents=zeros(no_parents,size(population,2),size(population,3));
    prob=zeros(size(prob_sel));
    for idx=1:size(prob_sel,1)
        previous_prob=previous_prob+prob_sel(idx);
        prob(idx)=previous_prob;
    end
    
    for idx=1:no_parents
        n=rand();
        for j=1:size(prob,1)
            if n<prob(j)
                parents(idx,:,:)=population(j,:,:);
                break
            end
        end
        
    end
end
