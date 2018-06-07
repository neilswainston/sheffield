function [model] = createLooseMedium(model, gluc_level, loose_mediumAA)
% This function will create a medium with a preset level of glucose and
% constrain aa flux to 210 ie loose_mediumAA              = -210*1.75;
% gluc_level = -1;


glucose_id                                  = 'EF0001';       
glucose_index                               = findRxnIDs(model, glucose_id);              % glucose transport
model.ub(glucose_index)                     = gluc_level;
model.lb(glucose_index)                     = gluc_level;


THR_id                      = 'EF0021';
THR_index                   = findRxnIDs(model, THR_id);                  % Threonine transport
model                       = constrainOnereaction(model,THR_id, loose_mediumAA);
    
CYS_id                      = 'EF0023';
CYS_index                   = findRxnIDs(model, CYS_id);                  % Cysteine transport
model                       = constrainOnereaction(model,CYS_id, loose_mediumAA);

MET_id                      = 'EF0024';
MET_index                   = findRxnIDs(model, MET_id);                  % Methionine transport
model                       = constrainOnereaction(model,MET_id, loose_mediumAA);

LYS_id                      = 'EF0022';
LYS_index                   = findRxnIDs(model, LYS_id);                  % Lysine transport
model                       = constrainOnereaction(model,LYS_id, loose_mediumAA);

ILE_id                      = 'EF0018';
ILE_index                   = findRxnIDs(model, ILE_id);                  % Isoleucine transport
model                       = constrainOnereaction(model,ILE_id, loose_mediumAA);

VAL_id                      = 'EF0017';
VAL_index                   = findRxnIDs(model, VAL_id);                  % Valine transport
model                       = constrainOnereaction(model,VAL_id, loose_mediumAA);

PHE_id                      = 'EF0025';
PHE_index                   = findRxnIDs(model, PHE_id);                  % Phenylalanine transport
model                       = constrainOnereaction(model,PHE_id, loose_mediumAA);

TRP_id                      = 'EF0027';
TRP_index                   = findRxnIDs(model, TRP_id);                  % Tryptophan transport
model                       = constrainOnereaction(model,TRP_id, loose_mediumAA);

HIS_id                      = 'EF0028';
HIS_index                   = findRxnIDs(model, HIS_id);                  % Histidine transport
model                       = constrainOnereaction(model,HIS_id, loose_mediumAA);

LEU_id                      = 'EF0019';
LEU_index                   = findRxnIDs(model, LEU_id);                  % Leucine transport
model                       = constrainOnereaction(model,LEU_id, loose_mediumAA);

GLN_id                      = 'EF0009';
GLN_index                   = findRxnIDs(model, GLN_id);                  % Glutamine transport
model                       = constrainOnereaction(model,GLN_id, loose_mediumAA);

ASP_id                      = 'EF0007';
ASP_index                   = findRxnIDs(model, ASP_id);                  % Aspartate transport
model                       = constrainOnereaction(model,ASP_id, loose_mediumAA);

ASN_id                      = 'EF0008';
ASN_index                   = findRxnIDs(model, ASN_id);                  % Asparagine transport
model                       = constrainOnereaction(model,ASN_id, loose_mediumAA);

ARG_id                      = 'EF0020';
ARG_index                   = findRxnIDs(model, ARG_id);                  % Arginine transport
model                       = constrainOnereaction(model,ARG_id, loose_mediumAA);

TYR_id                      = 'EF0026';
TYR_index                   = findRxnIDs(model, TYR_id);                  % Tyrosine transport
model                       = constrainOnereaction(model,TYR_id, loose_mediumAA);

ALA_id                      = 'EF0006';
ALA_index                   = findRxnIDs(model, ALA_id);                  % Alanine transport
model                       = constrainOnereaction(model,ALA_id, loose_mediumAA);

SER_id                      = 'EF0011';
SER_index                   = findRxnIDs(model, SER_id);                  % Serine transport
model                       = constrainOnereaction(model,SER_id, loose_mediumAA);

GLU_id                      = 'EF0010';
GLU_index                   = findRxnIDs(model, GLU_id);                  % Glutamate transport
model                       = constrainOnereaction(model,GLU_id, loose_mediumAA);

PRO_id                      = 'EF0016';
PRO_index                   = findRxnIDs(model, PRO_id);                  % Proline transport
model                       = constrainOnereaction(model,PRO_id, loose_mediumAA);

GLY_id                      = 'EF0013';
GLY_index                   = findRxnIDs(model, GLY_id);                  % Glycine transport
model                       = constrainOnereaction(model,GLY_id, loose_mediumAA);







