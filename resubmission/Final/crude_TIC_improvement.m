

function [quntified_improvement, crude_indicator_org, crude_indicator_mod] = crude_TIC_improvement(original_model, modified_model)

% original_model = model1;
% modified_model = orgmodel;
% original_model        = model1;
% modified_model        = model2;

%
[tic_id_model1] = findsuspectedTICs_v2(original_model);
[tic_id_model2] = findsuspectedTICs_v2(modified_model);

%of the generated list, pick first reaction
%find all neighbouring reactions

% [neighborRxns,neighborGenes,mets] = findneighborRxns_original(orgmodel,tic_idsv2_org);
[neighborRxns_original,~,mets1] = findNeighborRxns(original_model,tic_id_model1);
[neighborRxns_modified,~,mets2] = findNeighborRxns(modified_model,tic_id_model2);


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

crude_indicator_org = sum(sorted_connectivity_org(:,1));
crude_indicator_mod = sum(sorted_connectivity_mod(:,1));


    
    quntified_improvement = ((crude_indicator_mod/crude_indicator_org)-1)*100;  %less connectivity is better
   
    
    
    