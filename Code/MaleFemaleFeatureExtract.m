close all;clear;clc;
class_options = {'raw','gray','gradient','haralick','gabor','laws','collage'}; %{'raw','gray','gradient','haralick','gabor','laws','collage'}; %(optional) feature classes to extract
ws_options = [3, 5, 7, 9, 11];%:2;11; %(optional) window sizes from which to extract
addpath(genpath('C:\Users\josep\Documents\GitHub\covid-chestxray-dataset'))
savepath;
COVIDPAImagePath='C:\Users\josep\Documents\GitHub\covid-chestxray-dataset\images\COVID-19\XRAY\PA\Clean';
MalePath=COVIDPAImagePath+"\Male";
FemalePath=COVIDPAImagePath+"\Female";
MaleRawPath=MalePath+"\RawImages";
MaleMaskPath=MalePath+"\MaleMasks";
FemaleMaskPath=FemalePath+"\FemaleMasks";
FemaleRawPath=FemalePath+"\RawImages";





%Get names of Male Files
Malefilenames=strings;
Malemasknames=strings;
Malefilenames=GetImageNames(MaleRawPath);
Malemasknames=GetImageNames(MaleMaskPath);
%Get names of Female Files
Femalefilenames=strings;
Femalemasknames=strings;
Femalefilenames=GetImageNames(FemaleRawPath);
Femalemasknames=GetImageNames(FemaleMaskPath);


Maleimages={};
Malemasks={};
%Get images and masks. Images are converted to a single channel because
%masks are in a single channel. Not sure if this is a problem
for i=1:length(Malefilenames)
    
    Maleimages{i}=im2double(imread(MaleRawPath+"\"+Malefilenames(i)));
    if numel(size(Maleimages{i}))>=3
        Maleimages{i}=(rgb2gray(Maleimages{i})); %only if 3 channels
    end
    Malemasks{i}=im2double(imread(MaleMaskPath+"\"+Malemasknames(i)));
   
end
Femaleimages={};
Femalemasks={};

for i=1:length(Femalefilenames)
    
    Femaleimages{i}=im2double(imread(FemaleRawPath+"\"+Femalefilenames(i)));
    if numel(size(Femaleimages{i}))>=3
        Femaleimages{i}=(rgb2gray(Femaleimages{i})); %only if 3 channels
    end
    
    Femalemasks{i}=im2double(imread(FemaleMaskPath+"\"+Femalemasknames(i)));
    
    
end
%Initializing cell arrays to store featureinfo outputs
Malefeatints={length(Maleimages)};
Malefeatnames={length(Maleimages)};
Malefeatstats={length(Maleimages)};
Malestatnames={length(Maleimages)};
Malemaxslices={length(Maleimages)};
Malefeatvol={length(Maleimages)};
Malesavedirectory='C:\Users\josep\Documents\GitHub\covid-chestxray-dataset\images\COVID-19\XRAY\PA\Clean\Male\MaleSavedFeatureExtract';
%Extract features
for i=1:length(Maleimages)

[Malefeatints{i}, Malefeatnames{i}, Malefeatstats{i}, Malestatnames{i}] = extract2DFeatureInfo(Maleimages{i},~Malemasks{i}, class_options, ws_options);

disp("Image " + num2str(i)+ " out of "+ num2str(length(Maleimages))+ " male images completed.")


%{
Malemaxslices{i}=findMaxSlice(Malemasks{i});

Malecurrentfeatints=Malefeatints{i};
%creating slices of feature images for display

fvol = createFeatVol(Dogcurrentfeatints{1},Dogmasks{i}); %only doing the first feature
sl = fvol(:,:,Dogmaxslices{i});
Dogfeatvol{i} = sl;
%}

end
%}
%Initializing cell arrays and extracting features. Same as in males. 
Femalefeatints={length(Femaleimages)};
Femalefeatnames={length(Femaleimages)};
Femalefeatstats={length(Femaleimages)};
Femalestatnames={length(Femaleimages)};
Femalemaxslices={length(Femaleimages)};
Femalefeatvol={length(Femaleimages)};
Femalesavedirectory='C:\Users\josep\Documents\GitHub\covid-chestxray-dataset\images\COVID-19\XRAY\PA\Clean\Female\FemaleSavedFeatureExtract';
for i=1:length(Femaleimages)

[Femalefeatints{i}, Femalefeatnames{i}, Femalefeatstats{i}, Femalestatnames{i}] = extract2DFeatureInfo(Femaleimages{i},~Femalemasks{i}, class_options, ws_options);





disp("Image " + num2str(i)+ " out of "+ num2str(length(Femaleimages))+ " female images completed.")


%{
Femalemaxslices{i}=findMaxSlice(Femalemasks{i});
Femalecurrentfeatints=Femalefeatints{i};
%creating slices of feature images for display

fvol = createFeatVol(Catcurrentfeatints{1},Catmasks{i}); %only doing the first feature
sl = fvol(:,:,Catmaxslices{i});
Catfeatvol{i} = sl;
%}
end
%save results into mat files
for i=1:length(Femaleimages)
    
    filename=char(Femalefilenames(i));
    filename=filename(1:end-4);
    filename=convertCharsToStrings(filename);
    img=Femaleimages{i};
    mask=~Femalemasks{i};
    featints=Femalefeatints{i};
    featnames=Femalefeatnames{i};
    featstats=Femalefeatstats{i};
    statnames=Femalestatnames{i};
    save(fullfile(Femalesavedirectory,[filename+'_feats.mat']),'img','mask','featints','featnames','featstats','statnames','-v7.3');
end
for i=1:length(Maleimages)

    filename=char(Malefilenames(i));
    filename=filename(1:end-4);
    filename=convertCharsToStrings(filename);
    img=Maleimages{i};
    mask=~Malemasks{i};
    featints=Malefeatints{i};
    featnames=Malefeatnames{i};
    featstats=Malefeatstats{i};
    statnames=Malestatnames{i};
    save(fullfile(Malesavedirectory,[filename+'_feats.mat']),'img','mask','featints','featnames','featstats','statnames','-v7.3');

    
end



%{
Males=zeros(length(Malefeatstats),1);

Females=ones(length(Femalefeatstats),1);

MalesandFemales=[Males;Females];
Malestatsarray=[];
RowMalefeatstats={length(Malefeatstats)};
for i=1:length(Malefeatstats)
    
    
    Currentmalefeatstats=Malefeatstats{i};
    RowMalefeatstats{i}=reshape(Currentmalefeatstats.',1,[]);
    Malestatsarray=[Malestatsarray; RowMalefeatstats{i}];
    
end
Femalestatsarray=[];
RowFemalefeatstats={length(Femalefeatstats)};
for i=1:length(Femalefeatstats)
    
    
    Currentfemalefeatstats=Femalefeatstats{i};
    RowFemalefeatstats{i}=reshape(Currentfemalefeatstats.',1,[]);
    Femalestatsarray=[Femalestatsarray; RowFemalefeatstats{i}];
    
end

Combinedstatsarray=[Malestatsarray; Femalestatsarray];
Labelledstatsarray=[Combinedstatsarray MalesandFemales]
%}