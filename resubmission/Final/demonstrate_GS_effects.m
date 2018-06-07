function demonstrate_GS_effects(model)

model_t = model;

% reacioncounter          = size(model_t.rxns, 1);
% counter                 = 1;

                
% revFlag         = 'false';
% lowerBound      = 0;
% upperBound      = 1000;
% printRxnFormula(playmodel, 'BIO029')
% mAb_syn         = 'BIO029'; %mab ID
% addReaction(model_t,mAb_syn,metaboliteList_mAb_syn,stoichCoeffList_mAb_syn,revFlag,lowerBound,upperBound);
% addReaction(model_t,mAb_syn,metaboliteList_mAb_syn,stoichCoeffList_mAb_syn_EPS,revFlag,lowerBound,upperBound);

% ****************
% R00253    ATP + L-Glutamate + NH3 = ADP + Orthophosphate + L-Glutamine	
%           C00002 + C00025 + C00014 = C00008 + C00009 + C00064

GS_system                                                   = 'R00253'; % GS id
GS_system_index                                             = findRxnIDs(model_t, GS_system);
glucose_index                                               = findRxnIDs(model_t, 'EF0001');
glucose_constraint                                          = -1; %10
zero_flux                                                   = 1e-6;
gln_transport_index                                         = findRxnIDs(model_t, 'EF0009');
biomass_index                                               = findRxnIDs(model_t, 'BIO028');
mAb_index                                                   = findRxnIDs(model_t, 'BIO029');
K                                                           = 0.7;
relaxation                                                  = 0.75;%0.95;
model_reserve                                               = model_t;


%***************
model_t.lb(glucose_index)                = glucose_constraint; 
model_t.ub(glucose_index)                = glucose_constraint;
model_t.c(biomass_index)    = 1;   
model_t.c(mAb_index)        = 1; 
baseline_sol = optimizeCbModel(model_t);
model_t.c(biomass_index)    = 0;   
model_t.c(mAb_index)        = 0; 
%this will use baseline glutamine flux values
%************
model_t.lb([findRxnIDs(model_t, GS_system)])                = 0; %  can the cell survive withtou intracellular and without extracellular gln?
model_t.ub([findRxnIDs(model_t, GS_system)])                = 0;
model_t.lb(gln_transport_index)                             = 0; %  can the cell survive withtou intracellular and without extracellular gln?
model_t.ub(gln_transport_index)                             = 0;
model_t.c(biomass_index)                                    = 1;
temp_sol                                                    = optimizeCbModel(model_t);
model_t.c(biomass_index)                                    = 0;
if temp_sol.x(biomass_index) > zero_flux
    disp('error, model can grow without any glutamine!?'' continue anyway');
end 
%impose constraints
% [~, ~, ~, model_t] = imposeAA_data_relax(model_t);          % very relaxed constraints 
% model_t = imposeAA_data_relax_85(model_t);          % very relaxed constraints 
%********************************
% [~, ~, ~, model_t]                                          = imposeAA_data_relax(model_reserve);          % very relaxed constraints
model_t.lb(gln_transport_index)                             = 0; %  can the cell survive withtou intracellular and without extracellular gln?
model_t.ub(gln_transport_index)                             = 0;
model_t.lb(glucose_index)                                   = glucose_constraint; 
model_t.ub(glucose_index)                                   = glucose_constraint;

GS_system_ub                                                = K * model_t.ub(glucose_index);
GS_system_lb                                                = K * model_t.lb(glucose_index);
% model_t.lb([findRxnIDs(model_t, GS_system)])                = GS_system_ub; %this is too strict so it needs to be relaxed somewhat, start with 0.7
% model_t.ub([findRxnIDs(model_t, GS_system)])                = GS_system_lb;

model_t = changeRxnBounds(model_t,GS_system, GS_system_ub + relaxation*GS_system_ub,'u');
model_t = changeRxnBounds(model_t,GS_system, GS_system_lb - relaxation*abs(GS_system_lb),'l');

% flux through R00253 is now linked to that of glucsoe

sol_gln = [];
sol_mAb = [];
sol_bio = [];
x = 1;
y = 1;
z = 1;

for ohm =0.01:0.01:0.2
    model_t = changeRxnBounds(model_t,GS_system, ohm*(GS_system_ub + relaxation*baseline_sol.x(findRxnIDs(model_t, GS_system))),'u');
    model_t = changeRxnBounds(model_t,GS_system, ohm*(GS_system_lb - relaxation*baseline_sol.x(findRxnIDs(model_t, GS_system))),'l');
      
    model_t = changeRxnBounds(model_t,mAb_index, ohm*(GS_system_ub + relaxation*GS_system_ub),'u');
    model_t = changeRxnBounds(model_t,mAb_index, ohm*(GS_system_lb - relaxation*GS_system_lb),'l');
    
    model_t.c(biomass_index)                                    = 0.9;
    model_t.c(mAb_index)                                        = 0.1;
    temp_sol                                                    = optimizeCbModel(model_t);
    model_t.c(biomass_index)                                    = 0;
    model_t.c(mAb_index)                                        = 0;
    sol_gln = [sol_gln; temp_sol.x(GS_system_index) ];
    x = x+1;
    sol_mAb = [sol_mAb; temp_sol.x(mAb_index)];
    y = y+1;
    sol_bio = [sol_bio; temp_sol.x(biomass_index)];
    z = z+1;
end

figure(1);
hold on
plot(x, sol_gln, 'r+');
plot(y, sol_mAb, 'bo');
plot(z, sol_bio, 'g-');
hold off

% 
% rxnName  = 'R00253';
% ATP + L-Glutamate + NH3 = ADP + Orthophosphate + L-Glutamine
% 
% C00002 + C00025 + C00014 = C00008 + C00009 + C00064
% 
% 
% 
% revFlag = 'false'
% 
% 
% ****************************************
% epsi = 0.1;
% revFlag = 'false';
% lowerBound = 0;
% upperBound = 1000;
% playmodel= addReaction(model,rxnName,metaboliteList,stoichCoeffList,revFlag,lowerBound,upperBound);




