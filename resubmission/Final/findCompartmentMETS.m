
function [mito_listMETS, cyto_listMETS] = findCompartmentMETS(list_METS)


% find list items in the mitochondria 


mito_listMETS =[];
cyto_listMETS = [];



    for i=1:size(list_METS,1)
        t = strfind(list_METS(i), '_mt'); %look for mito identifier
        if ~isempty(cell2mat(t))
            mito_listMETS       = [mito_listMETS; list_METS(i)];
        else
            cyto_listMETS       = [cyto_listMETS; list_METS(i)];
        end
        
    end
