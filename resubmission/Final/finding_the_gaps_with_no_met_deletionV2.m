

function [zero_rxn_zero_mAb, zero_rxn_zero_glucose,zero_rxn_zero_biomass_zero_mAb_zero_glucose,zero_rxn_zero_biomass_zero_mAb ,zero_rxn_zero_biomass,posRXN_posGlucose,posRXN_posBiomass_posmAb_posGlucose,rxns_making_biomass_pos_pos_rxns, rxns_making_biomass_pos_neg_rxns, rxns_making_biomass_pos_zero_rxns,no_of_pos_rxns, no_of_pos_rxns_non_ub,flux_not_equal_ub_when_maximied,flux_not_equal_ub_when_maximied_neg,reaction_list_pos, reaction_list_neg, reaction_list_zero]= finding_the_gaps_with_no_met_deletionV2(model)

tic
startOfrange                        = 1;
endOfrangeMets                      = size(model.mets,1);
endOfrangeRXNS                      = size(model.rxns,1);
% flux_positive_list                  = [];
% flux_negative_list                  = [];
% flux_zero_list                      = [];
reaction_list_pos                   = [];
reaction_list_neg                   = [];
reaction_list_zero                  = [];
flux_not_equal_ub_when_maximied     = [];
flux_not_equal_ub_when_maximied_neg = [];    
exact_biomass_flux_occurence        = 0;
rxns_making_biomass_pos_pos_rxns    = [];
rxns_making_biomass_pos_neg_rxns    = [];
rxns_making_biomass_pos_zero_rxns   = [];
posRXN_posBiomass_posmAb_posGlucose = [];
biomass                             =   findRxnIDs(model,'BIO028');
mAbIN                               =   findRxnIDs(model,'BIO029');
glucoseIN                           =   findRxnIDs(model,'EF0001');
temp_model                          = model;
posRXN_posGlucose                   = [];
zero_rxn_zero_biomass_zero_mAb_zero_glucose     = [];
zero_rxn_zero_biomass_zero_mAb                  = [];
zero_rxn_zero_biomass                           = [];
zero_rxn_zero_mAb                               = [];
zero_rxn_zero_glucose                           = [];

for j = startOfrange:endOfrangeRXNS % cycle objective between reactions 
            temp_model.c(j)             = 1;
            sol_when_jth_rxn_optimized  = optimizeCbModel(temp_model); 
            
            if sol_when_jth_rxn_optimized.x(j) > 0 
                reaction_list_pos                           = [reaction_list_pos; j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(j)];                
                if sol_when_jth_rxn_optimized.x(j)~= temp_model.ub(j)
                    flux_not_equal_ub_when_maximied         = [flux_not_equal_ub_when_maximied;  j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(j)];
                end                
                if sol_when_jth_rxn_optimized.x(biomass) > 0
                    rxns_making_biomass_pos_pos_rxns        = [rxns_making_biomass_pos_pos_rxns; j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(j),sol_when_jth_rxn_optimized.x(biomass)];
                end
                if (sol_when_jth_rxn_optimized.x(biomass) > 0 && sol_when_jth_rxn_optimized.x(glucoseIN) > 0 && sol_when_jth_rxn_optimized.x(mAbIN) > 0)
                    posRXN_posBiomass_posmAb_posGlucose  = [posRXN_posBiomass_posmAb_posGlucose; j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(j),sol_when_jth_rxn_optimized.x(biomass), sol_when_jth_rxn_optimized.x(mAbIN),sol_when_jth_rxn_optimized.x(glucoseIN)];
                end
                if sol_when_jth_rxn_optimized.x(glucoseIN )> 0
                    posRXN_posGlucose                       = [posRXN_posGlucose; j, temp_model.rxnNames(j),temp_model.rxns(j),sol_when_jth_rxn_optimized.x(j)];
%               
                end
                                
%                 if ceil(sol_when_jth_rxn_optimized.x(biomass))== 127
%                     exact_biomass_flux_occurence = exact_biomass_flux_occurence + 1;
%                 end              
%                 
            elseif sol_when_jth_rxn_optimized.x(j)<0
                
                reaction_list_neg       = [reaction_list_neg; j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(j) ];
                
                if sol_when_jth_rxn_optimized.x(j)~= temp_model.ub(j)
                    flux_not_equal_ub_when_maximied_neg= [flux_not_equal_ub_when_maximied_neg; j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(j)];
                end
                
                if sol_when_jth_rxn_optimized.x(biomass) > 0
                    rxns_making_biomass_pos_neg_rxns = [rxns_making_biomass_pos_neg_rxns; j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(biomass)];
                end
                
            elseif sol_when_jth_rxn_optimized.x(j) == 0
                
                reaction_list_zero      = [reaction_list_zero; j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(j)];
                
                if sol_when_jth_rxn_optimized.x(biomass) > 0
                    rxns_making_biomass_pos_zero_rxns = [rxns_making_biomass_pos_zero_rxns; j, temp_model.rxnNames(j), temp_model.rxns(j), sol_when_jth_rxn_optimized.x(biomass)];
                end
                
                if sol_when_jth_rxn_optimized.x(biomass) == 0
                    zero_rxn_zero_biomass = [zero_rxn_zero_biomass; j, temp_model.rxnNames(j), temp_model.rxns(j)];
                end
                
                if sol_when_jth_rxn_optimized.x(mAbIN) == 0
                    zero_rxn_zero_mAb = [zero_rxn_zero_mAb; j, temp_model.rxnNames(j), temp_model.rxns(j)];
                end
                
                if sol_when_jth_rxn_optimized.x(glucoseIN) == 0
                    zero_rxn_zero_glucose = [zero_rxn_zero_glucose; j, temp_model.rxnNames(j), temp_model.rxns(j)];
                end
                
                if sol_when_jth_rxn_optimized.x(biomass)== 0 && sol_when_jth_rxn_optimized.x(mAbIN) == 0
                    zero_rxn_zero_biomass_zero_mAb = [zero_rxn_zero_biomass_zero_mAb; j, temp_model.rxnNames(j), temp_model.rxns(j)];
                end
                
                if sol_when_jth_rxn_optimized.x(biomass)== 0 
                    if sol_when_jth_rxn_optimized.x(mAbIN)==0 
                        if sol_when_jth_rxn_optimized.x(glucoseIN) == 0
                zero_rxn_zero_biomass_zero_mAb_zero_glucose = [zero_rxn_zero_biomass_zero_mAb_zero_glucose; j, temp_model.rxnNames(j), temp_model.rxns(j)];
                        end
                    end 
                end
            end
            temp_model.c(j)=0;
end

no_of_pos_rxns          = length(reaction_list_pos(:,1));
% no_of_neg_rxns          = length(reaction_list_neg(:,1));
no_of_pos_rxns_non_ub   = length(flux_not_equal_ub_when_maximied(:,1));
% no_of_neg_rxns_non_ub   = length(flux_not_equal_ub_when_maximied_neg(:,1));

if ~isempty(rxns_making_biomass_pos_pos_rxns) % if there exist any positive biomass flux in any condition then plot it
    avgbiomass              = mean(cell2mat(rxns_making_biomass_pos_pos_rxns(:,5)));
    figure(50); 
    % this will display the number of reactions that when maximized displayed a positive biomass flux value in the solution (y axis)
    % and the biomass observed biomass flux value (x axis)
    % h1 = histogram(cell2mat(rxns_making_biomass_pos_pos_rxns(:,4)));
    subplot(1,2,1);
    sorted = cell2mat(rxns_making_biomass_pos_pos_rxns(:,5)); sorted =sort(sorted);
    h1 = bar(sorted);
    title('A');
    xlim([0 115]); ylim([0 135]);grid on;
    subplot(1,2,2);
    h2 = histogram(cell2mat(rxns_making_biomass_pos_pos_rxns(:,5)));
    title('B');
    h2.NumBins = length(rxns_making_biomass_pos_pos_rxns);
    xlim([0 135]); ylim([0 70]);grid on;  
end                               
% figure(51);
% subplot(1,2,1); 
% h3 = bar([no_of_pos_rxns no_of_pos_rxns_non_ub]);
% % hold on
% % h4 = bar(no_of_pos_rxns_non_ub);
% % title('number of reactions that reached ub against those that didn''t');
% xlim([0 3]); 
% grid on;
% Labels = {'A', 'B'};
% set(gca, 'XTick', 1:2, 'XTickLabel', Labels);
% % ylim([0 80]);
% grid on;
% subplot(1,2,2);
% h5 = bar([no_of_neg_rxns no_of_neg_rxns_non_ub]);
% % h6 = bar(no_of_neg_rxns_non_ub);
% yupperlimit = no_of_neg_rxns + 1;
% % title('number of neg reactions that reached ub against those that didn''t');
% xlim([0 3]); ylim([0 yupperlimit])
% % ylim([0 80]);
% grid on;
% Labels = {'A', 'B'};
% set(gca, 'XTick', 1:2, 'XTickLabel', Labels);
% %%%%%%%%%%%%%%%%%%%
% figure(52);
% subplot(1,2,1); 
% h3 = pie([no_of_pos_rxns no_of_pos_rxns_non_ub]);
% % title('number of reactions that reached ub against those that didn''t');
% grid on;
% subplot(1,2,2);
% h5 = pie([no_of_neg_rxns no_of_neg_rxns_non_ub]);
% % title('number of neg reactions that reached ub against those that didn''t');
% grid on;execution_time = toc
% % exact_biomass_flux_occurence
% % figure(53);
% %  
% % h3 = bar([no_of_pos_rxns no_of_pos_rxns_non_ub]);
% % % hold on
% % % h4 = bar(no_of_pos_rxns_non_ub);
% % % title('number of reactions that reached ub against those that didn''t');
% % xlim([0 3]); 
% % grid on;
% % Labels = {'A', 'B'};
% % set(gca, 'XTick', 1:2, 'XTickLabel', Labels);
% % % ylim([0 80]);
% % figure(54);
% % grid on;
% % h5 = bar([no_of_neg_rxns no_of_neg_rxns_non_ub]);
% % % h6 = bar(no_of_neg_rxns_non_ub);
% % yupperlimit = no_of_neg_rxns + 1;
% % % title('number of neg reactions that reached ub against those that didn''t');
% % xlim([0 3]); ylim([0 yupperlimit])
% % % ylim([0 80]);
% % grid on;
% % Labels = {'A', 'B'};
% % set(gca, 'XTick', 1:2, 'XTickLabel', Labels);
% %     
