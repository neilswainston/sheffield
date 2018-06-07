function model = removingUnwantedReactions(model)

%this function remove all incorrect reactions except for the whole pathways

inCorrect_tRNAs = {'EF0032','R03651', 'R03651_mt',  'R03905_mt', 'R04212_mt', 'R03647','R03647_mt'};
model = removeRxns(model, inCorrect_tRNAs);

Glucose_containing = 'R05196';
model = removeRxns(model, Glucose_containing); % this will also remove C00293 which is 'Glucose' as it's only involved in this reaction
D_Glucose = 'C00031';   %this will remove D-Glucose. It already has been replaced in all reactions with alpha-D-Glucose
model = removeMetabolites(model,D_Glucose);
old_UDP = 'G10619';
model = removeMetabolites(model, old_UDP);

%removes reactions and metabolites that are in plants
% Dextrin R01791, R02108, R02109
% plant_reactions = {'R01791','R02108','R02109','','','',''};
% model = removeRxns(model, plant_reactions);


% glucose_probsRXNs = {'K00001', 'R03162'};
% model = removeRxns(model, glucose_probsRXNs);
