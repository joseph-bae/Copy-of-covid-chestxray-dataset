%requires mapping table csv in folder "C:\Users\josep\Desktop\Research\Prasanna\COVID\MappingTable" and tracking sheet in
%same folder. Name files "MappingTable" and "TrackingSheet"
TablePath="C:\Users\josep\Desktop\Research\Prasanna\COVID\MappingTable";
MappingTable=readtable("C:\Users\josep\Desktop\Research\Prasanna\COVID\MappingTable\MappingTable.csv");
TrackingSheet=readtable("C:\Users\josep\Desktop\Research\Prasanna\COVID\MappingTable\TrackingSheet.csv");
NewMappingTable=MappingTable;
NumberOfPatients=size(MappingTable(:,'from_patient_id'));
COVIDStatusArray=strings(NumberOfPatients(1),1);
RepeatStringArray=strings();
StudyTypeArray=strings();
for i=1:(NumberOfPatients(1))
    
    [row,col]=find(table2array(TrackingSheet(:,'MRN'))==table2array(MappingTable(i,'from_patient_id')));
    
    COVIDStatus=strings();
    StudyType=strings();
    rowsize=size(row);
    for j=1:rowsize(1)
        
        CellCOVIDStatus=table2array(TrackingSheet(row(j),'COVID_RESULT'));
        COVIDStatus(j)=convertCharsToStrings(CellCOVIDStatus{1});
        CellStudyType=table2array(TrackingSheet(row(j),'StudyType'));
        StudyType(j)=convertCharsToStrings(CellStudyType{1});
        
    end

    if all(COVIDStatus==COVIDStatus(1))
       
       COVIDStatusArray(i)=COVIDStatus(1);
       RepeatStringArray(i,1)=NaN;   
    else
        COVIDStatusArray(i)='Status Changes';
        UniqueCOVIDStatus=unique(COVIDStatus,'stable');
        UniqueCOVIDStatusSize=size(UniqueCOVIDStatus);
        for k=1:UniqueCOVIDStatusSize(2)
            
            RepeatStringArray(i,k)=UniqueCOVIDStatus(k);
        
        end
        
    end

    StudyTypeSize=size(StudyType);
    UniqueStudyType=unique(StudyType,'stable');
    UniqueStudyType(strcmp(UniqueStudyType,""))=[];
    UniqueStudyTypeSize=size(UniqueStudyType);
    EditedUniqueStudyType=UniqueStudyType;
    for L=1:UniqueStudyTypeSize(2)
        counter=0;
        
        for m=1:StudyTypeSize(2)
            if StudyType(m)==UniqueStudyType(L)
                counter=counter+1;
            end
            
        end
        
        EditedUniqueStudyType(L)=string(counter)+ " " + UniqueStudyType(L);
    end
    EditedUniqueStudyTypeSize=size(EditedUniqueStudyType);
    for n=1:EditedUniqueStudyTypeSize(2)
        StudyTypeArray(i,n)=EditedUniqueStudyType(n);
    end
end

COVIDStatusTable=table(COVIDStatusArray,'VariableNames',"COVID_Status");
NewMappingTable=[MappingTable COVIDStatusTable];
NewMappingTable=movevars(NewMappingTable,'COVID_Status','After','to_patient_id');
NewMappingTable=NewMappingTable(:,[1,2,3,8,9]);
RepeatStringTable=table(RepeatStringArray,'VariableNames',"Repeat_Results");
NewMappingTable=[NewMappingTable RepeatStringTable];
StudyTypeTable=table(StudyTypeArray,'VariableNames',"Study_Types");
NewMappingTable=[NewMappingTable StudyTypeTable];
NewMappingTable=movevars(NewMappingTable,'Study_Types','After','COVID_Status');
%%writetable(NewMappingTable,"C:\Users\josep\Desktop\Research\Prasanna\COVID\Results\MappingTables\MappingTest4212020.csv");