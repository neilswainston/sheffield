function [blockedrxnsList, blockedrxnsList_ids] = findBlockedRxns(model)
% blocked reactions are defined as those unable to carry flux when either
% maximized or minimized. Therefore total number of optimisations will be
% 2xN where N is the number of the reactions in the network
% the code is very simialr to that used to find suspected TICs but with a
% constrained model rather than one with exchange reactions blocked

start_time = tic;
model_b                                     = model;

blockedrxnsList                             = [];
zero_flux                                   = 10e-6; %10e-9;
pos_blockedmax                              = [];
pos_blockedmin                              = [];
blockedrxnsList_ids                         = [];
counter                                     = 1;
rxns_counter                                = size(model_b.rxns,1);

 
for i= 1: rxns_counter
    model_b.c(i)                    = 1;
    sol_max                         = optimizeCbModel(model_b);
    model_b.c(i)                    = 0;
    if  ((sol_max.x(i) <= zero_flux) && (sol_max.x(i) >= -1*zero_flux))
       
          pos_blockedmax(counter)   = [i];
          counter = counter +1;
    end     
end
pos_blockedmax                      = pos_blockedmax';
counter = 1;
model_b                             = model;

for j= 1: rxns_counter
    model_b.c(j)                    = -1;
    sol_min                         = optimizeCbModel(model_b);
    model_b.c(j)                    = 0;         
    if  ((sol_min.x(j) <= zero_flux) && (sol_min.x(j) >= -1*zero_flux))
        
          pos_blockedmin(counter)   = [j];
          counter = counter +1;
    end            
   
end
pos_blockedmin = pos_blockedmin';

if size(pos_blockedmax,1) >= size(pos_blockedmin,1)
    blockedrxnsList             = ismember(pos_blockedmax, pos_blockedmin);
    disp('this is the number of potential blocked reactions');
    sum(blockedrxnsList)
    blockedrxnsList             = find(blockedrxnsList==1);
    pos_blockedmax              = pos_blockedmax(blockedrxnsList);
    state_flip                  = 1;
elseif size(pos_blockedmax,1) < size(pos_blockedmin,1)
    blockedrxnsList             = ismember(pos_blockedmin, pos_blockedmax);
    disp('this is the number of potential blocked reactions');
    sum(blockedrxnsList)
    blockedrxnsList             = find(blockedrxnsList==1);
    pos_blockedmin              = pos_blockedmin(blockedrxnsList);
    state_flip                  = 2;
else
    disp('this should never be showed')
end

if state_flip == 1
    for i=1:rxns_counter
        if  sum(ismember(pos_blockedmax, i))
            blockedrxnsList_ids         = [blockedrxnsList_ids; model_b.rxns(i)];
        end 
    end
    blockedrxnsList                     = pos_blockedmax;
elseif state_flip == 2
    for i=1:rxns_counter
        if  sum(ismember(pos_blockedmin, i))
            blockedrxnsList_ids         = [blockedrxnsList_ids; model_b.rxns(i)];
        end 
    end
    blockedrxnsList                     = pos_blockedmin;
else
    disp('this should never be showed')
end

run_time_in_seconds = toc(start_time)



