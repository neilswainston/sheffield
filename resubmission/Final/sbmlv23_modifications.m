function sbmlv23_edited = sbmlv23_modifications(sbmlv23_unedited, list)

sbmlv23_edited          = sbmlv23_unedited;
sbmlv23_edited.mets  = correct_metsNaming(sbmlv23_edited.mets);  
%first modfications done to sbmlv22
sbmlv23_edited          = sbmlv22_modifications(sbmlv23_unedited);
%**********************************************************

table49                 = {'R01791','R02108','R02109','R00028','R01718','R01719','R02110',...
                            'K00001','R03162','R03634','R00802','R01103','R00010',...
                            'R05196','R00292','BIO019','R01101','R01329',...
                            'R05549', 'R05926', 'R05952', 'R05925', 'R05926', 'R05927',...
                            'R05928', 'R05929', 'R05930', 'R05932', 'R05935', 'R05936'}; %inclusive of glucose problems and generic G00XXX mets
table49                 = unique(table49);
Glucose_containing      = 'R05196';
D_Glucose               = 'C00031';   %this will remove D-Glucose. It already has been replaced in all reactions with alpha-D-Glucose
old_UDP                 = 'G10619';
sbmlv23_edited          = removeChitin(sbmlv23_edited);
% sbmlv23_edited          = removeRNAreactions(sbmlv23_edited);
sbmlv23_edited          = removingUnwantedReactions(sbmlv23_edited); % Delete biologically incorrect rxns
sbmlv23_edited          = removeRxns(sbmlv23_edited, table49);
sbmlv23_edited          = removeRxns(sbmlv23_edited, Glucose_containing); % this will also remove C00293 which is 'Glucose' as it's only involved in this reaction
sbmlv23_edited          = removeMetabolites(sbmlv23_edited,D_Glucose);
sbmlv23_edited          = removeMetabolites(sbmlv23_edited, old_UDP);
sbmlv23_edited          = delete_pathways(sbmlv23_edited,list);

