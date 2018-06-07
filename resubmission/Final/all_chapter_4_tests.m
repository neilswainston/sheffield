function [model_t_total_results, no_blocked, no_leaks, no_tics] = all_chapter_4_tests(model)

run_time_in_min                                         = tic;
model_t                                                 = model;
obj1                                                    = 'BIO028';
biomass_index                                           = findRxnIDs(model_t,obj1);
obj2                                                    = 'BIO029';
mAb_index                                               = findRxnIDs(model_t, obj2);
con_level                                               = -1;
reactionID                                              = 'EF0001';
reaction_IDs                                            = model_t.rxns;
Reaction_Names                                          = model_t.rxnNames;

[sol_con_obj1, sol_con_obj2, sol_con_both] = constrainOnlyOne_and_test_for_sol_equality(model_t, reactionID, con_level, obj1,obj2);
flux_obj1 = sol_con_obj1.x;
flux_obj2 = sol_con_obj2.x;
flux_both = sol_con_both.x;


[dump, blockedrxnsList_ids]                 = findBlockedRxns(model_t);
no_blocked                                  = length(blockedrxnsList_ids);
is_it_blocked                               = ismember(model_t.rxns, blockedrxnsList_ids);
res                                         = string(zeros(size(is_it_blocked)));
res(is_it_blocked==1)                       = 'YES'; 
res(is_it_blocked==0)                       = 'NO'; 
is_it_blocked                               = res;

[list_of_leaks, dump, dump2]                = find_leaks_v1(model_t);               %Earlier version used v1. No. of leaks should be exactly the same but other two outputs might change
no_leaks                                    = length(list_of_leaks(:,1));
leak_flux                                   = list_of_leaks(:,2);
leak_flux                                   = cell2mat(leak_flux);
leak_indices                                = findRxnIDs(model_t,list_of_leaks(:,1)); 
res                                         = NaN(length(model_t.rxns),1);
counter                                     = 1;
for i = 1:length(model_t.rxns)
    if ismember(i,leak_indices)
        res(i) = leak_flux(counter);
        counter = counter +1;
    end  
end
leak_flux                                   = res;

is_it_leak                                  = ismember(model_t.rxns, list_of_leaks(:,1));
res                                         = string(zeros(size(is_it_leak)));
res(is_it_leak==1)                          = 'YES'; 
res(is_it_leak==0)                          = 'NO'; 
is_it_leak                                  = res;



[tic_ids]                                   = findsuspectedTICs(model_t);
tic_ids                                     = unique(tic_ids); 
no_tics                                     = length(tic_ids);
is_it_tic                                   = ismember(model_t.rxns, tic_ids);
res                                         = string(zeros(size(is_it_tic)));
res(is_it_tic==1)                           = 'YES'; 
res(is_it_tic==0)                           = 'NO'; 
is_it_tic                                   = res;


model_t_total_results = table(reaction_IDs ,Reaction_Names, flux_obj1 , flux_both, flux_obj2, is_it_blocked, is_it_leak, leak_flux, is_it_tic);

run_time_in_min                             = toc(run_time_in_min)/60








