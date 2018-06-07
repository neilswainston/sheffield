
function [mito_listRXNS, cyto_listRXNS] = findCompartmentRXNS(list_RXNS)


% find list items in the mitochondria 


mito_listRXNS =[];
cyto_listRXNS = [];



    for i=1:size(list_RXNS,1)
        t = strfind(list_RXNS(i), '_mt'); %look for mito identifier
        if ~isempty(cell2mat(t))
            mito_listRXNS       = [mito_listRXNS; list_RXNS(i)];
        else
            cyto_listRXNS       = [cyto_listRXNS; list_RXNS(i)];
        end
        
    end
