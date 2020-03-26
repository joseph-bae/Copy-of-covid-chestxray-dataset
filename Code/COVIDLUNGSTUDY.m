close all;clear;clc;
class_options = {'raw','gray','gradient','haralick','gabor','laws','collage'}; %{'raw','gray','gradient','haralick','gabor','laws','collage'}; %(optional) feature classes to extract
ws_options = 3;%:2;11; %(optional) window sizes from which to extract
addpath(genpath('C:\Users\josep\Documents\GitHub\covid-chestxray-dataset'))
COVIDPAImagePath='C:\Users\josep\Documents\GitHub\covid-chestxray-dataset\images\COVID-19\XRAY\PA\Clean';
MalePath=COVIDPAImagePath+"\Male";
FemalePath=COVIDPAImagePath+"\Female";
COVIDMaleFiles=dir(MalePath);
COVIDFemaleFiles=dir(FemalePath);

COVIDMaleImageNames=strings;
j=1;
%check for empty files and add file names to a string array
for i=1:length(COVIDMaleFiles)
  
    if COVIDMaleFiles(i).bytes ~= 0
        COVIDMaleImageNames(j)=convertCharsToStrings(COVIDMaleFiles(i).name);
        j=j+1;
        
    end
    
end
COVIDMaleImages={};

for i=1:length(COVIDMaleImageNames)
    
    COVIDMaleImages{i}=im2double(imread(MalePath+"\"+COVIDMaleImageNames(i)));
    
end

COVIDFemaleImageNames=strings;
j=1;
%check for empty files and add file names to a string array
for i=1:length(COVIDFemaleFiles)
  
    if COVIDFemaleFiles(i).bytes ~= 0
        COVIDFemaleImageNames(j)=convertCharsToStrings(COVIDFemaleFiles(i).name);
        j=j+1;
        
    end
    
end
COVIDFemaleImages={};

for i=1:length(COVIDFemaleImageNames)
    
    COVIDFemaleImages{i}=im2double(imread(FemalePath+"\"+COVIDFemaleImageNames(i)));
    
end




for i=1:5

    I=rgb2gray(COVIDMaleImages{i}); %only if 3 channels
    
    %%
    a_thresh = I >= .5; % change threshold as needed
    [labelImage, numberOfBlobs] = bwlabel(a_thresh);
    props = regionprops(a_thresh,'all');
    sortedSolidity = sort([props.Solidity], 'descend');
    SB = sortedSolidity(1);
    if SB == 1 % SB only accept solidity == 1 filter out bones
        binaryImage = imbinarize(I);
        SE = strel('square',3);
        morphologicalGradient = imsubtract(imdilate(binaryImage, SE),imerode(binaryImage, SE));
        mask = imbinarize(morphologicalGradient,0.03);
        SE = strel('square',2);
        mask = imclose(mask, SE);
        mask = imfill(mask,'holes');
        mask = bwareafilt(mask,2); % control number of area show
        notMask = ~mask;
        mask = mask | bwpropfilt(notMask,'Area',[-Inf, 5000 - eps(5000)]);
        figure
        imshow(I);
        showMaskAsOverlay(0.5,mask,'g'); 
        %{
        BW2 = imfill(binaryImage,'holes');
        new_image = BW2 ;
        new_image(~mask) = 0; % invert background and holes
        B=bwboundaries(new_image); % can only accept 2 dimensions
        subplot(2,2,4)
        imshow(new_image);
        hold on
        visboundaries(B);
%}
    end



end
