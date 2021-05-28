function [val_camber,val_toe]= Prepare_Dataset(pop,Mattern_Camberl,Mattern_TOE)
    
    bump_val=[200 -60];
    X_flat=zeros(2*size(pop,1),size(pop,2)*size(pop,3));
    i=1;
    j=1;
    while j~=size(pop,1)+1
        X_dummy=pop(j,:,:);  
        X_dummy=reshape(X_dummy,size(X_dummy,2),size(X_dummy,3));
        X_flat(i,1:24)=reshape(X_dummy',size(X_dummy,1)*size(X_dummy,2),[])';
        X_flat(i+1,1:24)=X_flat(i,1:24);
        for idx=1:numel(bump_val)
            X_flat(i,25)=bump_val(idx);
            i=i+1;
        end
        j=j+1; 
    end
    val_camber=Mattern_Camberl.predictFcn(X_flat);
    %val_camber=reshape(val_camber',[],2);
    val_toe=Mattern_TOE.predictFcn(X_flat);
    %val_toe=reshape(val_toe',size(val_toe,1)/2,2);
    count=0;
    val_c_o=[];
    val_c_e=[];
    val_t_o=[];
    val_t_e=[];
    for idx=1:size(val_camber,1)
        if rem(idx,2)==0
            val_c_e=[val_c_e;val_camber(idx)];
            val_t_e=[val_t_e;val_toe(idx)];

        elseif rem(idx,2)==1
            val_c_o=[val_c_o;val_camber(idx)];
            val_t_o=[val_t_o;val_toe(idx)];
        end
    end
    val_camber=[val_c_o val_c_e];
    val_toe=[val_t_o val_t_e];
    
end