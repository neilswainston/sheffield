function [list_of_leaks_1st_test, causing_impossible_growth_when_max, causing_impossible_growth_when_min] = find_leaks_v1(model)

% knocks out all exchange reactions, maximized biomass and finds non-zero
% fluxes in the solution
exc_time_min                                            = tic;
model_t                                                 = model;
rxns_counter1                                           = size(model_t.rxns,1);
zero_flux                                               = 1e-6; %1e-9
[rxnIDsExchange,indexExhange]                           = return_exchangeIDs(model_t);
biomassID                                               = 'BIO028';
biomass_index                                           = findRxnIDs(model_t,biomassID);
mAbID                                                   = 'BIO029';
mAb_index                                               = findRxnIDs(model_t, mAbID);
list_of_leaks_1st_test                                  = [];
% list_of_leaks_2nd_test                                  = [];
causing_impossible_growth_when_max                      = [];
causing_impossible_growth_when_min                      = [];
% leakfluxes = [];%testing
testing                                                 = ismember(model_t.rxns, rxnIDsExchange);    %trying to confirm that the original list of exchange reaction still exists in this model sent to this sfunction
if sum(testing) == length(rxnIDsExchange)
    % 1st test - block input, go for growth
    model_t.lb([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
    model_t.ub([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
else
    rxnIDsExchange                                          = model_t.rxns(testing); % only block transport reactions that exist in the model (some may have been deleted)
    model_t.lb([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
    model_t.ub([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
end
model_t.c(biomass_index)                                    = 1;
sol_bio                                                     = optimizeCbModel(model_t);
model_t.c(biomass_index)                                    = 0;

if sum(abs(sol_bio.x)) ~= 0
    for i=1:rxns_counter1
        if ~(ismember(i,indexExhange)) %excludes knockedout exchange rxns
            if ((sol_bio.x(i) > zero_flux) || (sol_bio.x(i) < -1*zero_flux))
                list_of_leaks_1st_test          = [list_of_leaks_1st_test; model_t.rxns(i), sol_bio.x(i)];
            end
        end
    end
end
% model_t                                                 = model;


% % 2end test - block input, block output, go for growth
% model_t.lb([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
% model_t.ub([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
% model_t.lb([findRxnIDs(model_t, {biomassID,mAbID})])    = 0;
% model_t.ub([findRxnIDs(model_t, {biomassID,mAbID})])    = 0;
% 
% model_t.c(biomass_index)                = 1;
% sol_bio2                                = optimizeCbModel(model_t);
% 
% 
% if sum(abs(sol_bio2.x)) ~= 0
%     for i=1:rxns_counter1
%         if ~(ismember(i,indexExhange)) && (i~=biomass_index) && (i~=mAb_index)
%             if ((sol_bio2.x(i) > zero_flux) || (sol_bio2.x(i) < -1*zero_flux))
%                 list_of_leaks_2nd_test      = [list_of_leaks_2nd_test; model_t.rxns(i)];
%             end
%         end
%     end
% end
% model_t                                                 = model;

% 3rd test - block input, block output, maximize/minimize each, look for
% growth. Is there any reaction that can cause biomass to be positive when
% maximzed when input is blocked? 

% model_t.lb([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
% model_t.ub([findRxnIDs(model_t, rxnIDsExchange)])       = 0;
% model_t.lb([findRxnIDs(model_t, {biomassID,mAbID})])    = 0;
% model_t.ub([findRxnIDs(model_t, {biomassID,mAbID})])    = 0;
% counter = 1;
% for i=1:rxns_counter1
%     if ~(ismember(i,indexExhange))
%         model_t.c(i)                    = 1;
%         sol_bio3                        = optimizeCbModel(model_t);
%         model_t.c(i)                    = 0;
%         if ((sol_bio3.x(biomass_index) > zero_flux) || (sol_bio3.x(biomass_index) < -1*zero_flux))
%             causing_impossible_growth_when_max = [causing_impossible_growth_when_max; model_t.rxns(i), sol_bio3.x(i), 'biomass flux:', sol_bio3.x(biomass_index)];
% %             counter = counter + 1;
%         end
%     end
% end
% 
% % model_t = model;
% % counter = 1;
% for i=1:rxns_counter1
%     if ~(ismember(i,indexExhange))
%         model_t.c(i)                    = -1;
%         sol_bio4                        = optimizeCbModel(model_t);
%         model_t.c(i)                    = 0;
%         if ((sol_bio4.x(biomass_index) > zero_flux) || (sol_bio4.x(biomass_index) < -1*zero_flux))
%             causing_impossible_growth_when_min = [causing_impossible_growth_when_min; model_t.rxns(i), sol_bio4.x(i), 'biomass flux:', sol_bio4.x(biomass_index)];
% %             counter = counter + 1;
%         end
%         
%     end
% end

disp('number of leaks is:');
length(list_of_leaks_1st_test(:,1))

exc_time_min = toc(exc_time_min)/60










































