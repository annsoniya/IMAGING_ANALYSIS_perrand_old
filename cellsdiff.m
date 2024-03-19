
function []=cellsdiff(dataset_per,dataset_aper)


function[]=datanalaysis(dataset_per)


for i=1:size(data_per_3,1) %%** 6 stim*5 trials *40 frmaes
    per_3=[]; 
    per_3= cat(1,data_per_3{i,:});% 
    baseline_per_3=mean(per_3(:,4:8),2);
    %find mean of all trials across 9:33 frames
    mean_per_3=mean(per_3(:,9:33),2);
    
    %find sig of this cell using ttest2 with alpha value =0.05
    [h, p_value] = ttest2(baseline_per_3, mean_per_3, 'Alpha', 0.05);
     %   [h, p_value] = ttest2(baseline_per_3, mean_per_3, 'Alpha', 0.05/bon_corr);

    if h==1
      value_per3(i)=mean(mean(per_3(:,9:33),2));
    else
     value_per3(i)=0;
    end
end
 %% no fo cells that are significantly different on considerign periodic stim only =
 %  numel(find(value_per3(1,:)~=0))  ==== 473
 
% sort periodic data based on mean values from highest to lowest
[sorted_values, sorted_indices] = sort(value_per3, 'descend');
zero_indices_per3 = sorted_indices(sorted_values == 0);
non_zero_indices_per3=sorted_indices(sorted_values ~= 0);

%%%%% sig from aperiodic data %%%%%%%%%%%%%%%%%

% step 1:- check for the units that are significant for the aperiodic stimulus 
bon_corr=4;
for i=1:size(data_aper_3,1) %%** 6 stim*5 trials *40 frames
    aper_3=[]; 
    aper_3= cat(1,data_aper_3{i,:});% 
    baseline_aper_3=mean(aper_3(:,4:8),2);
    % find mean of all trials across 9:33 frames
    mean_aper_3=mean(aper_3(:,9:33),2);
    
    % find sig of this cell using ttest2 with alpha value = 0.05
   %[h, p_value] = ttest2(baseline_aper_3, mean_aper_3, 'Alpha', 0.05/bon_corr);
       [h, p_value] = ttest2(baseline_aper_3, mean_aper_3, 'Alpha', 0.05);

    if h==1
        value_aper3(i)=mean(mean(aper_3(:,9:33),2));
    else
        value_aper3(i)=0;
    end
end
% number of cells that are significantly different on considering aperiodic stim only
% numel(find(value_aper3(1,:)~=0)) ====   421

% sort periodic data based on mean values from highest to lowest

sorted_indices=[];
sorted_values=[];
[sorted_values, sorted_indices] = sort(value_aper3, 'descend');
zero_indices_aper3 = sorted_indices(sorted_values == 0);
% find non zero indices
non_zero_indices_aper3 = sorted_indices(sorted_values ~= 0);

%%% find f any periodic cells are sig to aperiodic
% find the common indices between zero_indices_per3 and non_zero_indices_aper3
perInsig_aperSig = intersect(zero_indices_per3, non_zero_indices_aper3);
% find cells sig in periodic ,but not sig in aper
PerSig_AperInSig = intersect(non_zero_indices_per3,zero_indices_aper3);

% number ofd cells in each case
nofperInsig_aperSig= numel(perInsig_aperSig);
nofPerSig_AperInSig= numel(PerSig_AperInSig);



%%%%%%%%%%%%%%%%%%%%%%%% periodicity ==4 %%%%%%%%%%%%%%%%%%%%%%%%%%
