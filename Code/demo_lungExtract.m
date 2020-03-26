clear; clc; close all;

%% Loading images

raw_x_ray='trial4.jpg';
I=imread(raw_x_ray);
I=rgb2gray(I); %only if 3 channels
figure(1);
imshow(I);
colormap(gray);
title('Grayscale X-Ray');
I=wiener2(I, [5 5]);
figure(2);
subplot(2,2,1);
imshow(I);
subplot(2,2,2);
imhist(I, 256);
%%
a_thresh = I >= 150; % change threshold as needed
[labelImage, numberOfBlobs] = bwlabel(a_thresh);
props = regionprops(a_thresh,'all');
sortedSolidity = sort([props.Solidity], 'descend');
SB = sortedSolidity(1);
if SB == 1 % SB only accept solidity == 1 filter out bones
    binaryImage = imbinarize(I);
    subplot(2,2,3)
    imshow(binaryImage); colormap(gray);
    SE = strel('square',3);
    morphologicalGradient = imsubtract(imdilate(binaryImage, SE),imerode(binaryImage, SE));
    mask = imbinarize(morphologicalGradient,0.03);
    SE = strel('square',2);
    mask = imclose(mask, SE);
    mask = imfill(mask,'holes');
    mask = bwareafilt(mask,2); % control number of area show
    notMask = ~mask;
    mask = mask | bwpropfilt(notMask,'Area',[-Inf, 5000 - eps(5000)]);
    showMaskAsOverlay(0.5,mask,'g'); 
    BW2 = imfill(binaryImage,'holes');
    new_image = BW2 ;
    new_image(~mask) = 0; % invert background and holes
    B=bwboundaries(new_image); % can only accept 2 dimensions
    subplot(2,2,4)
    imshow(new_image);
    hold on
    visboundaries(B);
    
end