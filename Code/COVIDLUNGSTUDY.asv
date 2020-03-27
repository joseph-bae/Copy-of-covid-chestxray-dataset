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
    
    COVIDMaleImages{i}=(imread(MalePath+"\"+COVIDMaleImageNames(i)));
    
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
    
    COVIDFemaleImages{i}=(imread(FemalePath+"\"+COVIDFemaleImageNames(i)));
    
end




for i=6:6
    I=COVIDMaleImages{i};
    if numel(size(COVIDMaleImages{i}))>=3
        I=(rgb2gray(I)); %only if 3 channels
    end
    I=histeq(I);
    
    
    %{
    mask=EulerMinMax(I,255);
    mask=~mask;
    mask = bwareafilt(mask,2);
    
    
    figure
    imshow(I, []);
    showMaskAsOverlay(0.5,mask,'g');
    blocations = bwboundaries(mask,'noholes');
    for ind = 1:numel(blocations)
        % Convert to x,y order.
        pos = blocations{ind};
    pos = fliplr(pos);
        % Create a freehand ROI.
        drawfreehand('Position', pos);
    end
    %}
    %{
    a_thresh = I >=150;   %.6*max(COVIDMaleImages{i},[],'all'); % change threshold as needed;
    [labelImage, numberOfBlobs] = bwlabel(a_thresh);
    props = regionprops(a_thresh,'all');
    sortedSolidity = sort([props.Solidity], 'descend');
    SB = sortedSolidity(1);
    if SB == 1 % SB only accept solidity == 1 filter out bones
        binaryImage = imbinarize(I); 
        SE = strel('square',3);
        morphologicalGradient = imsubtract(imdilate(binaryImage, SE),imerode(binaryImage, SE));
        mask = imbinarize(morphologicalGradient,0.03);
        SE = strel('disk',20);
        mask = imclose(mask, SE);
        mask = imfill(mask,'holes');
        mask = bwareafilt(mask,2); % control number of area show
        notMask = ~mask;
        mask = mask | bwpropfilt(notMask,'Area',[-Inf, 5000 - eps(5000)]);
        blocations = bwboundaries(mask,'noholes');
        figure
        imshow(I, []);
        showMaskAsOverlay(0.5,mask,'g');
        %{
        for ind = 1:numel(blocations)
            % Convert to x,y order.
            pos = blocations{ind};
        pos = fliplr(pos);
            % Create a freehand ROI.
            drawfreehand('Position', pos);
        end
        %}
    end
        
%}
    
end
