function [tic_idsv2] = findsuspectedTICs_v2(model)


execution_time                                          = tic;
model_t                                                 = model;

[rxnIDsExchange,indexExhange]                           = return_exchangeIDs(model_t);
biomassID                                               = 'BIO028';
% biomass_index                                       = findRxnIDs(model_t, biomassID);
mAbID                                                   = 'BIO029';
% mAb_index                                       = findRxnIDs(model_t, mAb_index);
tic_max                                                 = [];
tic_min                                                 = [];
tic_idsv2                                                 = [];




testing                                                 = ismember(model_t.rxns, rxnIDsExchange);    %trying to confirm that the original list of exchange reaction still exists in this model sent to thi sfunction
if sum(testing) == length(rxnIDsExchange)
    model_t                                                 = removeRxns(model_t,rxnIDsExchange);
    model_t                                                 = removeRxns(model_t, mAbID);
    model_t                                                 = removeRxns(model_t, biomassID);
    
else
    rxnIDsExchange                                          = model_t.rxns(testing);
    model_t                                                 = removeRxns(model_t,rxnIDsExchange);
    model_t                                                 = removeRxns(model_t, mAbID);
    model_t                                                 = removeRxns(model_t, biomassID);
end


% no input to the network
% model_t.lb([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
% model_t.ub([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
% 
% %no outputs from the network
% model_t.lb([findRxnIDs(model_t, {biomassID,mAbID})])    = 0;
% model_t.ub([findRxnIDs(model_t, {biomassID,mAbID})])    = 0;
rxns_counter1                                           = size(model_t.rxns,1);

for i= 1: rxns_counter1
    model_t.c(i)                    = 1;
    sol_max                         = optimizeCbModel(model_t);
    model_t.c(i)                    = 0;
    if  sol_max.x(i) ~= 0 && ~isempty(sol_max.x(i))
        tic_max                     = [tic_max; i];
    end     
end
   
for j= 1: rxns_counter1
    model_t.c(j)                    = -1;
    sol_min                         = optimizeCbModel(model_t);
    model_t.c(j)                    = 0;         
    if  sol_min.x(j) ~= 0 && ~isempty(sol_min.x(j))
        tic_min                     = [tic_min; j];
    end            
end

%This code will test for TIC (zero when min and max)

if size(tic_max,1) >= size(tic_min,1)
    tic_pot         = ismember(tic_max, tic_min);
    disp('this is the number of possible TICs');
    sum(tic_pot)
    tic_pot         = find(tic_pot==1);
    tic_max         = tic_max(tic_pot); %elements of tic_min that exist in ticmax
    state_flip      = 1;
elseif size(tic_max,1) < size(tic_min,1)
    tic_pot         = ismember(tic_min, tic_max);
    disp('this is the number of reactions possibly involved in TICs');
    sum(tic_pot)
    tic_pot         = find(tic_pot==1);
    tic_min         = tic_min(tic_pot);
    state_flip      = 2;
else
    disp('this should never be showed')
end
% test_counter = 0;
if state_flip == 1
    tic_idsv2 = model_t.rxns(tic_max);
    
elseif state_flip == 2
    tic_idsv2 = model_t.rxns(tic_min);
else
    disp('this is the number of reactions possibly involved in TICs')
end

% if state_flip == 1
%     for i=1:rxns_counter1
%         if  sum(ismember(tic_max, i))
%             tic_idsv2         = [tic_idsv2; model_t.rxns(i)];
% %             test_counter = test_counter+1;
%         end 
%     end
% elseif state_flip == 2
%     for i=1:rxns_counter1
%         if  sum(ismember(tic_min, i))
%             tic_idsv2         = [tic_idsv2; model_t.rxns(i)];
% %             test_counter = test_counter+1;
%         end 
%     end
% else
%     disp('this should never be showed')
% end

   
execution_time_in_minutes = toc(execution_time)/60








