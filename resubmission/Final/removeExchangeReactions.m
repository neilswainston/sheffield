function model = removeExchangeReactions(model)
% NADH transport = EF0036
% Ethanlaime Transport = EF0035 DO NOT DELETE
% Formaldehyde transporter = EF0032
% Formate transpoter = EF0030

% UnwantedExchange = {'EF0036'};
UnwantedExchange = {'EF0032','EF0036'};
% UnwantedExchange = {'EF0030','EF0032'};                 % not deleting Ethanlamine
% UnwantedExchange = {'EF0032'};                          % only Formaldehyde
% UnwantedExchange = {'EF0032'};                          % only Formate
model = removeRxns(model, UnwantedExchange);
% model = removeRxns(model, UnwantedExchange,false,false);

% % % delete reactions associated with EF0032
Formaldehyde_related_reactions = {'R00602', 'R00610', 'R00611_mt', 'R01565_mt', 'R07937'};
model = removeRxns(model, Formaldehyde_related_reactions);
% model = removeRxns(model, Formaldehyde_related_reactions,false,false);

% % delete reactions associated with EF0035 update: DO NOT DELETE, MAKES A
% % AN IMPORTANT COMPOUND IN BIOMASS
% Ethanlaime_related_reactions = {'R01468','R02051','R06870','R07376','R07385',...
%                                 'R07388','R02038','R02464','R06516','R07380'};
% model = removeRxns(model, Ethanlaime_related_reactions);
                           
% model = removeRxns(model, Ethanlaime_related_reactions,false,false);
% % 
% % % delete reactions associoated with EF0030
% Formate_related_reactions = {'R00526','R00943','R00943_mt','R00988','R01959','R04911',...
%                                 'R05046','R05640','R05731','R06940'};
% model = removeRxns(model, Formate_related_reactions);
% model = removeRxns(model, Formate_related_reactions,false,false);
% % 


