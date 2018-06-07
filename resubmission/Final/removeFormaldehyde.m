function model = removeFormaldehyde(model)

Formaldehyde_related_reactions = {'R00602', 'R00610', 'R00611_mt', 'R01565_mt', 'R07937', 'EF0032'};
model = removeRxns(model, Formaldehyde_related_reactions);