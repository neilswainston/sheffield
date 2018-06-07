function model = removeEF0037(model)


blocked_redundantNADHtransport = {'EF0037'};
model = removeRxns(model, blocked_redundantNADHtransport);