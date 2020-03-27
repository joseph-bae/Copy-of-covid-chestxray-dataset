function LungMask = DrawLungMask(filenumber, gender)

COVIDPAImagePath='C:\Users\josep\Documents\GitHub\covid-chestxray-dataset\images\COVID-19\XRAY\PA\Clean';
MalePath=COVIDPAImagePath+"\Male";
FemalePath=COVIDPAImagePath+"\Female";
EQMalePath=MalePath+"\EqualizedMale";
EQFemalePath=FemalePath+"\EqualizedFemale";
MaleImages={};
FemaleImages={};
if lower(gender) == "m" || lower(gender) ==  "male"
    EQMaleFiles=dir(EQMalePath);
    MaleImageNames=strings;
    j=1;
    %check for empty files and add file names to a string array
    for i=1:length(EQMaleFiles)

        if EQMaleFiles(i).bytes ~= 0
            MaleImageNames(j)=convertCharsToStrings(EQMaleFiles(i).name);
            j=j+1;

        end

    end
   I=(imread(EQMalePath+"\"+MaleImageNames(filenumber)));

    
end

if lower(gender) == "f" || lower(gender)== "female"
    EQFemaleFiles=dir(EQFemalePath);
    FemaleImageNames=strings;
    j=1;
    %check for empty files and add file names to a string array
    for i=1:length(EQFemaleFiles)

        if EQFemaleFiles(i).bytes ~= 0
            FemaleImageNames(j)=convertCharsToStrings(EQFemaleFiles(i).name);
            j=j+1;

        end

    end
    I =(imread(EQFemalePath+"\"+FemaleImageNames(filenumber)));
  
end
figure
imshow(I)
roi = images.roi.Freehand;
draw(roi);
input("step1");
roi2 = images.roi.Freehand;
draw(roi2);

input("step2")
Mask1=createMask(roi);
Mask2=createMask(roi2);


LungMask=Mask1+Mask2;
RealMask=~LungMask;
if lower(gender) == "m" || lower(gender) ==  "male"
    imwrite(RealMask,MalePath+"\MaleMasks\MASK"+MaleImageNames(filenumber));
end
if lower(gender) == "f" || lower(gender) ==  "female"
    imwrite(RealMask,FemalePath+"\FemaleMasks\MASK"+FemaleImageNames(filenumber));
end

LungMask=~LungMask;



