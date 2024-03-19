% aim:- find cells that are sig to per but not aperiodic with 
%bonferoni correction=6 for periodic 
%and 4 for aperiodic

%data read
clear all;
clc;
close all;
data=load('Sig_bon_cumu_Frms_38frms.mat');
data=table2cell(data.Sig_bon_cumu_Frms_38frms);
periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];
per_set=[1,2,3,4,5,6,7,8,9,10];
aper_set=[11,12,13,14,15,16];
% plan 
%split into stimwise  and periodicity wise
%find cumulatve for 3 frames=600ms
%apply ttest and find significant cases amon=g periodic an d aperiodic

%split into stimwise  and periodicity wise
data_per_3=data(:,periodic_stimset_3);
data_per_4=data(:,periodic_stimset_4);
data_aper_3=data(:,aperiodic_stimset_3);
data_aper_4=data(:,aperiodic_stimset_4);

%%%% periodicity 3%%%%%%%%%%%
bon_corr=6;
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



