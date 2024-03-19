%plot_per_aper
periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];
db=load('D:\ann_analysis\IMAGING_ANALYSIS\IMAGING_ANALYSIS\sig_cells_30frms.mat')

db=db.significantCells_30frms;
%declare variables
 dff_per4_allstim=[];
dff_aper4_allstim=[];
dff_per3_allstim=[];
dff_aper3_allstim=[];


%% Iterate over all cells and all stimuli and add a field to the db and average the responses for all periodic and aperiodic stimulus 
for i = 1:size(db,1)% for cell
%  dff_per4_allstim=[];
% dff_aper4_allstim=[];
% dff_per3_allstim=[];
% dff_aper3_allstim=[];
for j=1:16 % for stim 
     clear stim_dff;
        if ismember(j,periodic_stimset_4)
            stim_dff=cell2mat(db(i, j, :));
            dff_per4_allstim = [dff_per4_allstim;stim_dff];
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
    % plotting per and aper responses for each cell for each periodicity 
    subplot(2,2,1)
    % add titles 
    plot(mean(dff_per4_allstim))
        title('per4');

    subplot(2,2,2)
    plot(mean(dff_aper4_allstim))
        title('aper4');

    subplot(2,2,3);
    plot(mean(dff_per3_allstim))
        title('per3');

    subplot(2,2,4)
    plot(mean(dff_aper3_allstim))
        title('aper3');

    %pause;
    
end

