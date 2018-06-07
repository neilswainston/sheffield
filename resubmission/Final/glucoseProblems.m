function model = glucoseProblems(model)

glucose_probsRXNs = {'K00001', 'R03162'};
model = removeRxns(model, glucose_probsRXNs);