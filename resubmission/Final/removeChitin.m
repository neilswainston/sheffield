function model = removeChitin(model)

chitin_related  = {'R01206', 'R02334', 'R00022'};
model = removeRxns(model, chitin_related);