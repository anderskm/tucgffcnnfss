function [ map ] = loadLabelMappingsFromCSVfile( fileDir )
% Made very specific for reading a csv-file with context-labels.
%
% Author:       Peter Christiansen
% Affiliation:  Dept. of Engineering, Aarhus University
% Date:         4 Feb. 2016

table = readtable(fileDir);

% Specify mappings
mappings(1).AllLabels = 'ContextAllClasses';
mappings(1).AllNames = 'ClassName';
mappings(1).ReducedLabels = 'Context33';
mappings(1).ReducedNames = 'ClassName';

mappings(2).AllLabels = 'ContextAllClasses';
mappings(2).AllNames = 'ClassName';
mappings(2).ReducedLabels = 'Context59';
mappings(2).ReducedNames = 'ClassName';

mappings(3).AllLabels = 'ContextAllClasses';
mappings(3).AllNames = 'ClassName';
mappings(3).ReducedLabels = 'ContextAgro1';
mappings(3).ReducedNames = 'ContextAgro1Name';

mappings(4).AllLabels = 'ContextAllClasses';
mappings(4).AllNames = 'ClassName';
mappings(4).ReducedLabels = 'ContextAgro2';
mappings(4).ReducedNames = 'ContextAgro2Name';

for iMap = 1:length(mappings)
    strTmp = [mappings(iMap).AllLabels '-->' mappings(iMap).ReducedLabels];
    disp(['Reading mapping ' num2str(iMap) ':' strTmp])
    map(iMap).Type = strTmp;
    
    map(iMap).OldLabelIds = table2array(table(:,{mappings(iMap).AllLabels}));
    map(iMap).OldLabelNames = table2cell(table(:,{[mappings(iMap).AllNames ]}));
    map(iMap).NewLabelIds = table2array(table(:,{mappings(iMap).ReducedLabels}));
    map(iMap).NewLabelNames = table2cell(table(:,{mappings(iMap).ReducedNames}));
    [labelsUnique, ia ] = unique(table2array(table(:,{mappings(iMap).ReducedLabels})));
    map(iMap).NewLabelIdsUnique = labelsUnique;
    map(iMap).NewLabelNamesUnique = table2cell(table(ia,{mappings(iMap).ReducedNames}));
end

end

