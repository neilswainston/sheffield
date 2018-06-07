

function [quntified_improvement_blocked, crude_indicator__blocked_org, crude_indicator__blocked_mod] = crude_blocked_improvement(original_model, modified_model)

% original_model = model1;
% modified_model = orgmodel;
% original_model        = model1;
% modified_model        = model2;

[blockedrxnsList_org, blockedrxnsList_ids_org] = findBlockedRxns(original_model);
[blockedrxnsList_mod, blockedrxnsList_ids_mod] = findBlockedRxns(modified_model);

%of the generated list, pick first reaction
%find all neighbouring reactions

% [neighborRxns,neighborGenes,mets] = findneighborRxns_original(orgmodel,tic_idsv2_org);

[neighborRxns_original,~,mets1] = findNeighborRxns(original_model,blockedrxnsList_ids_org);
[neighborRxns_modified,~,mets2] = findNeighborRxns(modified_model,blockedrxnsList_ids_mod);


neighborRxns_original = neighborRxns_original';
neighborRxns_modified = neighborRxns_modified';

for i=1:length(neighborRxns_original)
    temp1(i,:)   = [length(neighborRxns_original{i,1}),i];
end


[~,idx1] = sort(temp1(:,1), 'descend');
sorted_connectivity_org = temp1(idx1,:);


for i=1:length(neighborRxns_modified)
    temp2(i,:)   = [length(neighborRxns_modified{i,1}),i];
end
[~,idx2] = sort(temp2(:,1), 'descend');
sorted_connectivity_mod = temp2(idx2,:);

crude_indicator__blocked_org = sum(sorted_connectivity_org(:,1));
crude_indicator__blocked_mod = sum(sorted_connectivity_mod(:,1));


    
quntified_improvement_blocked = ((crude_indicator__blocked_mod/crude_indicator__blocked_org)-1)*100;  %less connectivity is better
   
    
    
    