function model = constrainOnereaction(model,rxnID, con_val)

%this will constrain a reaction while maintaing the original directionality
%in the case of irreversible reactions

%ONLY USE WITH ORIGINAL MODEL, will give errors if lb>0
con_cal             = abs(con_val);
index               = findRxnIDs(model, rxnID);

if (model.lb(index) < 0)                            %if the reaction is reversible
    model.lb(index)             = -1*con_cal;
    model.ub(index)             = con_cal;
    
elseif (model.lb(index) == 0)
    
    model.ub(index)             = con_cal;
else
    error('this should not be printed unless there was an error');
end
