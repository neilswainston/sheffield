function sbmlv41_edited     = sbmlv41_modfications(sbmlv41_unedited, list)

sbmlv41_edited                  = sbmlv41_unedited;

redundant_TCA                   = {'R01324', 'R01324_mt', 'R00267', 'R00267_mt'};

sbmlv41_edited                  = removeRxns(sbmlv41_edited, redundant_TCA);
sbmlv41_edited                  = sbmlv23_modifications(sbmlv41_edited, list);