function model = removeXylitol(model)


Xylitol = {'R01639', 'R01904', 'R01431'};
model = removeRxns(model, Xylitol);