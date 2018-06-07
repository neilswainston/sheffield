function [sol_con_obj1, sol_con_obj2, sol_con_both] = constrainAA_gluc_and_test_for_sol_equality(model, loose_mediumAA, gluc_level, obj1, obj2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is exactly the same function as
% constrainOnlyOne_and_test_for_sol_equality but it will further constrain
% AA fluxes with glucsoe rather than only glucose. It is assumed here that
% reactionID will be that for glucose but the same test can be applied to
% any reaction in the network. Here loose_mediumAA determine to what level
% the AA fluxes will be constrained
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% loose_mediumAA = -210*1.75;
% gluc_level = -1;
model_c_aa                              = createLooseMedium(model, gluc_level, loose_mediumAA);
% model_c_aa                              = correct_metsNaming(model_c_aa);
if ~exist('obj1','var')&& (nargin == 3)
        %if no objective is defined then by default biomass is considered
        %to the objective function
        biomass_id          = 'BIO028';
        biomass_index       = findRxnIDs(model_c_aa, biomass_id);
        obj1_index          = biomass_index;       
else
        obj1_index          = findRxnIDs(model_c_aa, obj1);
end

if ~exist('obj2','var') && (nargin == 3 || nargin == 4)
        obj2                = '';
        obj2_index          = obj2;
        %will have no influence if not explicitly defined
else
        obj2_index          = findRxnIDs(model_c_aa, obj2);
end

%obj1 solution
model_c_aa.c(obj1_index)                                            = 1;
sol_con_obj1                                                        = optimizeCbModel(model_c_aa);
model_c_aa.c(obj1_index)                                            = 0;

% obj1 and obj2 solution
if exist('obj2','var') && (nargin == 5)
        model_c_aa.c(obj2_index)                                    = 1;
        sol_con_obj2                                                = optimizeCbModel(model_c_aa);
        model_c_aa.c(obj2_index)                                    = 0;            % reset model.c
        model_c_aa.c(obj1_index)                                    = 1;
        model_c_aa.c(obj2_index)                                    = 1;                
        sol_con_both                                                = optimizeCbModel(model_c_aa);
        model_c_aa.c(obj1_index)                                    = 0;                                             
        model_c_aa.c(obj2_index)                                    = 0;
              
else
        sol_con_obj2                                                = '';
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
            disp('maximizing obj2 and maximizing both yields exactly the same flux solution under current constraints')
        end
        if isequal(sol_con_both.x,sol_con_obj1.x)
            disp('maximizing obj1 and maximizing both yields exactly the same flux solution under current constraints')
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



