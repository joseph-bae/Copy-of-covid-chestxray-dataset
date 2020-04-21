

males=table2array(prunedData(2:26,2:end-1));
females=table2array(prunedData(27:end,2:end-1));
featnames={};
Malefemalefeatnums={};
j=1;
SignificantFeats=table;
for i=1:660
    
    p=ranksum(males(:,i),females(:,i));
    if p<=.01
        p
        featname=convertCharsToStrings(prunedData.Properties.VariableNames{i+1});
        featnames{j}=featname;
        currentmalefemalefeat=[males(:,i); females(:,i)];
        CurrentSignificantFeats=table(currentmalefemalefeat,'VariableNames', featname);
        SignificantFeats=[SignificantFeats CurrentSignificantFeats];
        j=j+1;
    end
end
