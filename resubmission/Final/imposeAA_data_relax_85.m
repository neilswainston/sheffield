
function model85 = imposeAA_data_relax_85(model)


model85 = model;


% NH3 flux was included in the provided data

error85                 = 0.85;
NH3_DATA                = -363.12;
NH3_fluxIN              = 'EF0012';
NH3_fluxIN              = findRxnIDs(model, NH3_fluxIN);
model85.ub(NH3_fluxIN)    = error85*NH3_DATA + NH3_DATA;
model85.lb(NH3_fluxIN)    = NH3_DATA - error85*NH3_DATA;



error85                 = 0.85;
ALA_DATA                = -39.429;
ALA_fluxIN              = 'EF0006';
ALA_fluxIN              = findRxnIDs(model,ALA_fluxIN);
model85.ub(ALA_fluxIN)    = ALA_DATA + error85*ALA_DATA;
model85.lb(ALA_fluxIN)    = ALA_DATA - error85*ALA_DATA;




error85                 = 0.85;
ASP_DATA                = 14.04;
ASP_fluxIN              = 'EF0007';
ASP_fluxIN              = findRxnIDs(model,ASP_fluxIN);
model85.ub(ASP_fluxIN)    = ASP_DATA + error85*ASP_DATA;
model85.lb(ASP_fluxIN)    = ASP_DATA - error85*ASP_DATA;





error85                 = 0.85;
ASN_DATA                = 679.31;
ASN_fluxIN              = 'EF0008';
ASN_fluxIN              = findRxnIDs(model,ASN_fluxIN);
model85.ub(ASN_fluxIN)    = ASN_DATA + error85*ASN_DATA; 
model85.lb(ASN_fluxIN)    = ASN_DATA - error85*ASN_DATA; 






error85                 = 0.85;
GLN_DATA                = -100.17;
GLN_fluxIN              = 'EF0009';
GLN_fluxIN              = findRxnIDs(model,GLN_fluxIN);
model85.ub(GLN_fluxIN)    = GLN_DATA + error85*GLN_DATA;
model85.lb(GLN_fluxIN)    = GLN_DATA - error85*GLN_DATA;





error85                 = 0.85;
GLU_DATA                = 73.40;
GLU_fluxIN              = 'EF0010';
GLU_fluxIN              = findRxnIDs(model,GLU_fluxIN);
model85.ub(GLU_fluxIN)    = GLU_DATA + error85*GLU_DATA;
model85.lb(GLU_fluxIN)    = GLU_DATA - error85*GLU_DATA;





error85                 = 0.85;
SER_DATA                = 491.95;
SER_fluxIN              = 'EF0011';
SER_fluxIN              = findRxnIDs(model,SER_fluxIN);
model85.ub(SER_fluxIN)    = SER_DATA + error85*SER_DATA;
model85.lb(SER_fluxIN)    = SER_DATA - error85*SER_DATA;







error85                 = 0.85;
GLY_DATA                = -210.72;
GLY_fluxIN              = 'EF0013';
GLY_fluxIN              = findRxnIDs(model,GLY_fluxIN);
model85.ub(GLY_fluxIN)    = GLY_DATA + error85*GLY_DATA;
model85.lb(GLY_fluxIN)    = GLY_DATA - error85*GLY_DATA;





error85                 = 0.85;
PRO_DATA                = 73.91;
PRO_fluxIN              = 'EF0016';
PRO_fluxIN              = findRxnIDs(model,PRO_fluxIN);
model85.ub(PRO_fluxIN)    = PRO_DATA + error85*PRO_DATA;
model85.lb(PRO_fluxIN)    = PRO_DATA - error85*PRO_DATA;






error85                 = 0.85;
VAL_DATA                = 126.09;
VAL_fluxIN              = 'EF0017';
VAL_fluxIN              = findRxnIDs(model,VAL_fluxIN);
model85.ub(VAL_fluxIN)    = VAL_DATA + error85*VAL_DATA;  
model85.lb(VAL_fluxIN)    = VAL_DATA - error85*VAL_DATA; 






error85                 = 0.85;
ISL_DATA                = 106.09;
ISL_fluxIN              = 'EF0018';
ISL_fluxIN              = findRxnIDs(model,ISL_fluxIN);
model85.ub(ISL_fluxIN)    = ISL_DATA + error85*ISL_DATA;
model85.lb(ISL_fluxIN)    = ISL_DATA - error85*ISL_DATA;  





error85                 = 0.85;
LEU_DATA                = 180.76;
LEU_fluxIN              = 'EF0019';
LEU_fluxIN              = findRxnIDs(model,LEU_fluxIN);
model85.ub(LEU_fluxIN)    = LEU_DATA + error85*LEU_DATA;
model85.lb(LEU_fluxIN)    = LEU_DATA - error85*LEU_DATA;






error85                 = 0.85;
ARG_DATA                = 89.74;
ARG_fluxIN              = 'EF0020';
ARG_fluxIN              = findRxnIDs(model,ARG_fluxIN);
model85.ub(ARG_fluxIN)    = ARG_DATA + error85*ARG_DATA;
model85.lb(ARG_fluxIN)    = ARG_DATA - error85*ARG_DATA;







error85                 = 0.85;
THE_DATA                = 75.02;   
THE_fluxIN              = 'EF0021';
THE_fluxIN              = findRxnIDs(model,THE_fluxIN);
model85.ub(THE_fluxIN)    = THE_DATA + error85*THE_DATA; 
model85.lb(THE_fluxIN)    = THE_DATA - error85*THE_DATA;




error85                 = 0.85;
LYS_DATA                = 130.92;
LYS_fluxIN              = 'EF0022';
LYS_fluxIN              = findRxnIDs(model,LYS_fluxIN);
model85.ub(LYS_fluxIN)    = LYS_DATA + error85*LYS_DATA;
model85.lb(LYS_fluxIN)    = LYS_DATA - error85*LYS_DATA;


% CYS DATA NOT AVAILABLE. NO TRANSPORTER FOR CYS2 IN NETWORK
% CYS_DATA                = ;
% CYS_fluxIN              = 'EF0023';
% CYS_fluxIN              = findRxnIDs(model,CYS_fluxIN);
% model.ub(CYS_fluxIN)    = CYS_DATA; %Cysteine
% model.lb(CYS_fluxIN)    = CYS_DATA;






error85                 = 0.85;
MET_DATA                = 33.80;
MET_fluxIN              = 'EF0024';
MET_fluxIN              = findRxnIDs(model,MET_fluxIN);
model85.ub(MET_fluxIN)    = MET_DATA + error85*MET_DATA;
model85.lb(MET_fluxIN)    = MET_DATA - error85*MET_DATA;






error85                 = 0.85;
PHE_DATA                = 52.13;
PHE_fluxIN              = 'EF0025';
PHE_fluxIN              = findRxnIDs(model,PHE_fluxIN);
model85.ub(PHE_fluxIN)    = PHE_DATA + error85*PHE_DATA;
model85.lb(PHE_fluxIN)    = PHE_DATA - error85*PHE_DATA;






error85                 = 0.85;
TYR_DATA                = 63.88;
TYR_fluxIN              = 'EF0026';
TYR_fluxIN              = findRxnIDs(model,TYR_fluxIN);
model85.ub(TYR_fluxIN)    = TYR_DATA + error85*TYR_DATA; 
model85.lb(TYR_fluxIN)    = TYR_DATA - error85*TYR_DATA;



error85                 = 0.85;
TRP_DATA                = 21.79;
TRP_fluxIN              = 'EF0027';
TRP_fluxIN              = findRxnIDs(model,TRP_fluxIN);
model85.ub(TRP_fluxIN)    = TRP_DATA + error85*TRP_DATA;
model85.lb(TRP_fluxIN)    = TRP_DATA - error85*TRP_DATA;




error85                 = 0.85;
HIS_DATA                = 43.87;
HIS_fluxIN              = 'EF0028';
HIS_fluxIN              = findRxnIDs(model,HIS_fluxIN);
model85.ub(HIS_fluxIN)    = HIS_DATA + error85*HIS_DATA;
model85.lb(HIS_fluxIN)    = HIS_DATA - error85*HIS_DATA;



