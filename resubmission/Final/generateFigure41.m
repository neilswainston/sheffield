function []= generateFigure41(model)


model_t                 = model;
obj1                    = 'BIO028';
biomass_index           = findRxnIDs(model_t, obj1);
obj2                    = 'BIO029';
mAb_index               = findRxnIDs(model_t, obj2);
% con_level               = -1;
reactionID              = 'EF0001';


X_glucose               = [];
Y_bio_flux              = [];
Y_mAb_flux              = [];

% for obj1
for i=1:40
    
    [sol_con_obj1, sol_con_obj2, sol_con_both] = constrainOnlyOne_and_test_for_sol_equality(model_t, reactionID, -i, obj1);
    
    X_glucose           = [X_glucose;i];
    Y_bio_flux          = [Y_bio_flux; sol_con_obj1.x(biomass_index)];
    Y_mAb_flux          = [Y_mAb_flux; sol_con_obj1.x(mAb_index)];
end
% for obj2 and both



Y_bio_flux2              = [];
Y_mAb_flux2              = [];
for i=1:40
    [sol_con_obj1, sol_con_obj2, sol_con_both] = constrainOnlyOne_and_test_for_sol_equality(model_t, reactionID, -i, obj1,obj2);
    Y_bio_flux2          = [Y_bio_flux2; sol_con_both.x(biomass_index)];
    Y_mAb_flux2          = [Y_mAb_flux2; sol_con_both.x(mAb_index)];
end





figure('units','normalized','outerposition',[0 0 1 1]);
first = subplot(2,1,1); % top subplot
hold on
plot(first, X_glucose, Y_bio_flux,  'r');
plot(first, X_glucose, Y_mAb_flux,  'b');
legend('biomass flux','mAb flux')
title(first,'correlation between glucose input and biomass/mAb flux when biomass is maximized')
xlabel(first,'glucose input range from 1 to 100')
xlim([0 50])
ylim([0 50])
hold off

second = subplot(2,1,2); % bottom subplot
hold on
plot(second, X_glucose, Y_bio_flux2,  'r');
plot(second, X_glucose, Y_mAb_flux2, 'b');
legend('biomass flux','mAb flux')
title(second,'correlation between glucose input and biomass/mAb flux when both are maximized')
xlabel(second,'glucose input range from 1 to 100')
xlim([0 50])
ylim([0 50])
hold off








