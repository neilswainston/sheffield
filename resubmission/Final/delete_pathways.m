function model = delete_pathways(model,list)
list = cellstr(list); %prevent error when using older matlab
model.mets = correct_metsNaming(model.mets); % older cobra acts strangely sometimes
%This is to delete the all irrelevant reactions
final_list   = unique(list);
model = removeRxns(model, final_list);
% model = removeRxns(model, final_list ,false,false);
