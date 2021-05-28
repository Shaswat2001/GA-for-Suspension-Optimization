function [mutation] = mutation(all_geometry,offspring,~)
    mutation = offspring;
    for k = 1:size(offspring,1)
     if rem(randi([0 4]),2) == 0
        j = randi([1 size(offspring,2)]);
        i = randi([1 size(offspring,3)]);
        xmin= min(all_geometry(:,j,i));
        xmax = max(all_geometry(:,j,i));
        mutation(k,j,i) = xmin+rand(1,1)*(xmax-xmin);
     end
    end
end