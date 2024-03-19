% Initialize accumulators
% set of    stimulus  
periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];
dff_per4_allstim = [];
dff_aper4_allstim = [];
dff_per3_allstim = [];
dff_aper3_allstim = [];

% Iterate over all cells and all stimuli
for i = 1:size(db,1) % for cell
    for j=1:16 % for stim 
        clear stim_dff;
        if ismember(j,periodic_stimset_4)
            stim_dff=cell2mat(db(i, j, :));
            dff_per4_allstim = [dff_per4_allstim; stim_dff];
        elseif ismember(j,aperiodic_stimset_4)
            stim_dff=cell2mat(db(i, j, :));
            dff_aper4_allstim = [dff_aper4_allstim; stim_dff];
        elseif ismember(j,periodic_stimset_3)
            stim_dff=cell2mat(db(i, j, :));
            dff_per3_allstim = [dff_per3_allstim; stim_dff];
        elseif ismember(j,aperiodic_stimset_3)
            stim_dff=cell2mat(db(i, j, :));
            dff_aper3_allstim = [dff_aper3_allstim; stim_dff];
        end
    end
end

% Calculate averages
avg_dff_per4_allstim = mean(dff_per4_allstim);
avg_dff_aper4_allstim = mean(dff_aper4_allstim);
avg_dff_per3_allstim = mean(dff_per3_allstim);
avg_dff_aper3_allstim = mean(dff_aper3_allstim);

% Plot averages
subplot(2,2,1)
title('per4');
plot(avg_dff_per4_allstim);
subplot(2,2,2)
title('aper4');
plot(avg_dff_aper4_allstim);
subplot(2,2,3)
title('per3');
plot(avg_dff_per3_allstim);
subplot(2,2,4)
title('aper3');
plot(avg_dff_aper3_allstim);

    