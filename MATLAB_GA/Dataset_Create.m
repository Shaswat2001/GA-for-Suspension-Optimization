function [all_geometry,all_result]= Dataset_Create()

    files=dir(("Dataset\Test_data\*.xlsx"));
    all_result=zeros(length(files),14,5);
    all_geometry=zeros(length(files),8,3);
    for i=1:length(files)
        data=importdata(['Dataset\Test_data\' files(i).name]);
        all_geometry(i,:,:)=data.data([13:18 21:22],1:3);
        all_result(i,:,:)=data.data(83:96,1:5);
    end
end