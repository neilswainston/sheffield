function model = removeLumped_TCAs(model)

lumpedTCA_reactions = {'R01324', 'R01324_mt', 'R00267','R00267_mt'};
model = removeRxns(model,lumpedTCA_reactions);

