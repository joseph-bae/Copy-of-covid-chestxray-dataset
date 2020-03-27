COVIDPAImagePath='C:\Users\josep\Documents\GitHub\covid-chestxray-dataset\images\COVID-19\XRAY\PA\Clean';
MalePath=COVIDPAImagePath+"\Male";
FemalePath=COVIDPAImagePath+"\Female";
RawMalePath=MalePath+"\RawImages";
RawFemalePath=FemalePath+"\RawImages";
MasksMalePath=MalePath+"\MaleMasks";
MasksFemalePath=FemalePath+"\FemaleMasks";


COVIDMaleFiles=dir(RawMalePath);
MasksMaleFiles=dir(MasksMalePath);
MaleImages={};
MasksMaleNames=strings;
COVIDMaleImageNames=strings;
j=1;
%check for empty files and add file names to a string array
for i=1:length(COVIDMaleFiles)
  
    if COVIDMaleFiles(i).bytes ~= 0
        COVIDMaleImageNames(j)=convertCharsToStrings(COVIDMaleFiles(i).name);
        MasksMaleNames(j)=convertCharsToStrings(MasksMaleFiles(i).name);
        j=j+1;
        
    end
    
end
COVIDMaleImages={};
MaskMaleImages={};
for i=1:length(COVIDMaleImageNames)
    
    COVIDMaleImages{i}=(imread(RawMalePath+"\"+COVIDMaleImageNames(i)));
    MaskMaleImages{i}=(imread(MasksMalePath+"\"+MasksMaleNames(i)));
    figure
    imshow((imread(RawMalePath+"\"+COVIDMaleImageNames(i))));
    showMaskAsOverlay(0.5,~MaskMaleImages{i},'g');
    saveas(gcf,MalePath+"\Overlays\"+MasksMaleNames(i)+".png")
end

COVIDFemaleFiles=dir(RawFemalePath);
FemaleImages={};
COVIDFemaleImageNames=strings;
MasksFemaleFiles=dir(MasksFemalePath);
MasksFemaleNames=strings;
j=1;
%check for empty files and add file names to a string array
for i=1:length(COVIDFemaleFiles)
  
    if COVIDFemaleFiles(i).bytes ~= 0
        COVIDFemaleImageNames(j)=convertCharsToStrings(COVIDFemaleFiles(i).name);
        MasksFemaleNames(j)=convertCharsToStrings(MasksFemaleFiles(i).name);
        j=j+1;
        
    end
    
end
COVIDFemaleImages={};
MaskFemaleImages={};
for i=1:length(COVIDFemaleImageNames)
    
    COVIDFemaleImages{i}=(imread(RawFemalePath+"\"+COVIDFemaleImageNames(i)));
    MaskFemaleImages{i}=(imread(MasksFemalePath+"\"+MasksFemaleNames(i)));
    figure
    imshow((imread(RawFemalePath+"\"+COVIDFemaleImageNames(i))));
    showMaskAsOverlay(0.5,~MaskFemaleImages{i},'g');
    saveas(gcf,FemalePath+"\Overlays\"+MasksFemaleNames(i)+".png")
    
end

