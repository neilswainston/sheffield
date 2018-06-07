function model = removeDNAreplication (model)
DNA_list     = {'R00375','R00376','R00377','R00378'};
model       = removeRxns(model,DNA_list); 