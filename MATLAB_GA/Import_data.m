%% Creating Dataset
load Camber_model
load TOE_Model

files=dir(("Dataset\Test_data\*.xlsx"));
X=[];
output=[];
bump_val=[200 -60];
for i=1:length(files)
    data=importdata(['Dataset\Test_data\' files(i).name]);
    all_geometry=data.data([13:18 21:22],1:3);
    all_result=data.data(83:96,1:5);  
    X_flat=reshape(all_geometry',size(all_geometry,1)*size(all_geometry,2),[])';
    X=[X;X_flat bump_val(2)];
    output=[output;all_result(end,2:end)];
end


