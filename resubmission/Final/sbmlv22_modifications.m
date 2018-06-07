function sbmlv22_edited = sbmlv22_modifications(sbmlv22_unedited)
sbmlv22_edited          = sbmlv22_unedited;
inCorrect_tRNAs         = {'R03651', 'R03651_mt',  'R03905_mt', 'R04212_mt', 'R03647','R03647_mt'};
sbmlv22_edited          = removeFormaldehyde(sbmlv22_edited);
sbmlv22_edited          = removeEF0037(sbmlv22_edited); %problematic NADH
sbmlv22_edited          = removeRNAreactions(sbmlv22_edited);
sbmlv22_edited          = removeDNAreplication (sbmlv22_edited);
sbmlv22_edited          = removeRxns(sbmlv22_edited, inCorrect_tRNAs);

