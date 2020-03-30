function ImageNames = GetImageNames(directory)

ImageFiles=dir(directory);
ImageFileNames=strings;
j=1;
for i=1:length(ImageFiles)  
  
    if ImageFiles(i).bytes ~= 0
        ImageFileNames(j)=convertCharsToStrings(ImageFiles(i).name);
        
        j=j+1;
        
    end
    
end
ImageNames=ImageFileNames;