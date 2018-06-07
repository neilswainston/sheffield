function [sol_con_obj1, sol_con_obj2, sol_con_both] = constrainOnlyOne_and_test_for_sol_equality(model, reactionID, con_level, obj1,obj2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reactionID is the id of the reaction that will be constrained, for
% example 'EF0001' for glucose transport
% con_level the level to which this reaction will be constraint (ub=lb)
% obj1 id of the reaction that will be maximized, for example 'BIO028'
% obj2 optional in case reactions were to be maximized
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reactionID = 'EF0001';
% con_level  =   -1;
% obj1 = 'BIO028';
% obj2 = 'BIO029';


model_c = model;
%  model_c                                = correct_metsNaming(model_c);
%  if nargin == 3
 if ~exist('obj1','var')&& (nargin == 3)
        %if no objective is defined then by default biomass is considered
        %to the objective function
        biomass_id          = 'BIO028';
        biomass_index       = findRxnIDs(model_c, biomass_id);
        obj1_index          = biomass_index;       
 else
        obj1_index          = findRxnIDs(model_c, obj1);
 end
 if ~exist('obj2','var') && (nargin == 3 || nargin == 4)
        obj2                = '';
        obj2_index          = obj2;
        %will have no influence if not explicitly defined
 else
        obj2_index          = findRxnIDs(model_c, obj2);
 end
    
glucose_index                               = findRxnIDs(model, reactionID);    % constrain glucose input
model_c.ub(glucose_index)                   = con_level;
model_c.lb(glucose_index)                   = con_level;

%obj1 solution
model_c.c(obj1_index)                                           = 1;
sol_con_obj1                                                    = optimizeCbModel(model_c);
model_c.c(obj1_index)                                           = 0;

% obj1 and obj2 solution
if exist('obj2','var') && (nargin == 5)
        model_c.c(obj2_index)                                       = 1;
        sol_con_obj2                                                = optimizeCbModel(model_c);
        model_c.c(obj2_index)                                       = 0;            % reset model.c
        model_c.c(obj1_index)                                       = 1;
        model_c.c(obj2_index)                                       = 1;                
        sol_con_both                                                = optimizeCbModel(model_c);
        model_c.c(obj1_index)                                       = 0;
        model_c.c(obj2_index)                                       = 0;              
else
        sol_con_obj2                                                = ''; %only obj1 wax given
        sol_con_both                                                = '';
end


if nargin == 5
     if (sol_con_both.x(obj1_index)> 0 && sol_con_both.c(obj2_index)> 0)
           disp('maximizing both yields positive flux in both under current constraints') 
        end
    
     if  (~isempty(sol_con_obj1.x) && (~isempty(sol_con_obj2.x)))
       
        if isequal(sol_con_obj1.x,sol_con_obj2.x)
            disp('maximizing either of those reactions independently yields exactly the same flux solution');
            if isequal(sol_con_obj1.x, sol_con_both.x)
                disp('also maximizing both of those reactions together yields exactly the same flux solution as when they''re maximized separately');
            end
        end
        if isequal(sol_con_both.x,sol_con_obj2.x) 
            disp('maximizing obj2 and maximizing both concurrently yields exactly the same flux solution under current constraints')
        end
        if isequal(sol_con_both.x,sol_con_obj1.x)
            disp('maximizing obj1 and maximizing both concurrently yields exactly the same flux solution under current constraints')
        end
    end
    if  isempty(sol_con_obj1.x)
        disp('FBA is unable to find a solution given obj1 and constraints')
    end
    if  isempty(sol_con_obj2.x)
        disp('FBA is unable to find a solution given obj2 and constraints')
    end
    if (isempty(sol_con_obj1.x) && (isempty(sol_con_obj2.x)))
        disp('FBA is unable to find a solution given obj1 and obj2 and constraints')
    end
end

if nargin == 3 || nargin ==4
    if  isempty(sol_con_obj1.x)
        disp('FBA is unable to find a solution given obj1 and constraints')
    end
end




