% what about mito? 

% function model = correct_metsNaming(model)

function list = correct_metsNaming(list)
correctedMetabolites_list =[];

% for i=1:size(model.mets,1)
%    tempChar                     = char(model.mets(i));
%    temp_split                   = strsplit(tempChar,'[Cytosol]');
%    correctedMetabolites_list	= [correctedMetabolites_list; temp_split(1,1)];
% end
% 
% model.mets = correctedMetabolites_list;




for i=1:size(list,1)
   tempChar                     = char(list(i));
   temp_split                   = strsplit(tempChar,'[Cytosol]');
   correctedMetabolites_list	= [correctedMetabolites_list; temp_split(1,1)];
end

list = correctedMetabolites_list;