Malesavedirectory='C:\Users\josep\Documents\GitHub\covid-chestxray-dataset\images\COVID-19\XRAY\PA\Clean\Male\MaleSavedFeatureExtract';
Femalesavedirectory='C:\Users\josep\Documents\GitHub\covid-chestxray-dataset\images\COVID-19\XRAY\PA\Clean\Female\FemaleSavedFeatureExtract';

Malefilenames=strings;
Femalefilenames=strings;
Malefilenames=GetImageNames(Malesavedirectory);
Femalefilenames=GetImageNames(Femalesavedirectory);
Fullmalestats=[];
Fullfemalestats=[];

for i=1:length(Malefilenames)
    
   featstatsstruct=load(Malesavedirectory+"\"+Malefilenames(i),'featstats');
   currentfeatstats=featstatsstruct.featstats;
   currentfeatstats=reshape(currentfeatstats.',1,[]);
   Fullmalestats=[Fullmalestats;currentfeatstats];   
end
for i=1:length(Femalefilenames)
    
   featstatsstruct=load(Femalesavedirectory+"\"+Femalefilenames(i),'featstats');
   currentfeatstats=featstatsstruct.featstats;
   currentfeatstats=reshape(currentfeatstats.',1,[]);
   Fullfemalestats=[Fullfemalestats;currentfeatstats];   
end

Fullstats=[Fullmalestats; Fullfemalestats];
