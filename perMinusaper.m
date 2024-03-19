% find per - aper data of 1710 cells taking randomly same nof of trials in each dataset 
clear all;
clc
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

%% for periodiicty 3%%%%%%%%%%%%%
for i=1:size(data_per_3,1)
    per_3=[]; 
    per_3= cat(1,data_per_3{i,:});% 
    baseline_per_3=mean(per_3(:,4:8),2);
    aper_3=[];
    aper_3= cat(1,data_aper_3{i,:});%
    baseline_aper_3=mean(aper_3(:,4:8),2);
    %match baseline
   baseline__matched = baseline_per_3(randperm(size(baseline_per_3, 1), size(baseline_aper_3, 1)), :);
    % randomly choose rows from per_3 so as to match with aper_3
    per_3_matched = per_3(randperm(size(per_3, 1), size(aper_3, 1)), :);
    per_3_matched_minus_aper_3 = per_3_matched - aper_3;
    mean_diff(1,i)=mean(mean(per_3_matched_minus_aper_3(:,9:33),2));
    norm_selectivity=(per_3_matched - aper_3)./(per_3_matched + aper_3);
    norm_baseline__matched = (baseline__matched - baseline_aper_3)./ (baseline__matched + baseline_aper_3);
    %ttest
    norm_mean_diff(1,i)=mean(mean(norm_selectivity(:,9:33),2));
    [h,p,ci,stats] = ttest2(baseline__matched,mean(per_3_matched_minus_aper_3(:,9:33),2));
    %save the results
    ttest_results_per_3(i,1)=h; %h=1 means significant  
    ttest_results_per_3(i,2)=p;
% ttest for normmalised 
    [h,p,ci,stats] = ttest(mean(norm_selectivity(:,9:33),2),norm_baseline__matched);
    ttest_results_per_3(i,3)=h; %h=1 means significant for normalised 
    ttest_results_per_3(i,4)=p; 
    % continue with the rest of your cod
end
subplot(1,2,1) 
 plot(mean_diff);
 xlabel('cell no');
 ylabel('Periodic-Aperiodic response difference');
 subplot(1,2,2) 
 plot(norm_mean_diff);
 xlabel('cell no');
 ylabel('Normalised Periodic-Aperiodic response difference');
 %main title
    suptitle('Periodic-Aperiodic response difference for periodicity 3 ');

% sum(ttest_results_per_3(:,3))ans =45
% sum(ttest_results_per_3(:,3))ans =45

% sum(ttest_results_per_3(:,1))ans =124



%%%%%%%%%%% periodicity 4%%%%%%%%%%%%%

for i=1:size(data_per_4,1)
    per_4=[]; 
    norm_selectivity=[];
    per_4_matched_minus_aper_4=[];
    norm_baseline__matched=[];
    per_4_matched=[];
    per_4= cat(1,data_per_4{i,:});% 
    baseline_per_4=mean(per_4(:,4:8),2);
    aper_4=[];
    aper_4= cat(1,data_aper_4{i,:});%
    baseline_aper_4=mean(aper_4(:,4:8),2);
    %match baseline
    baseline__matched=[];
   baseline__matched = baseline_per_4(randperm(size(baseline_per_4, 1), size(baseline_aper_4, 1)), :);
    % randomly choose rows from per_4 so as to match with aper_4
    per_4_matched = per_4(randperm(size(per_4, 1), size(aper_4, 1)), :);
    per_4_matched_minus_aper_4 = per_4_matched - aper_4;
    mean_diff(1,i)=mean(mean(per_4_matched_minus_aper_4(:,9:33),2));
    norm_selectivity=(per_4_matched - aper_4)./(per_4_matched + aper_4);
    
    norm_baseline__matched = (baseline__matched - baseline_aper_4)./ (baseline__matched + baseline_aper_4);
    
    norm_mean_diff(1,i)=mean(mean(norm_selectivity(:,9:33),2));
    %ttest
    [h,p,ci,stats] = ttest2(baseline__matched,mean(per_4_matched_minus_aper_4(:,9:33),2));
    %save the results
    ttest_results_per_4(i,1)=h; %h=1 means significant  
    ttest_results_per_4(i,2)=p;
% ttest for normmalised
    [h,p,ci,stats] = ttest(mean(norm_selectivity(:,9:33),2),norm_baseline__matched);
    ttest_results_per_4(i,3)=h; %h=1 means significant for normalised 
    ttest_results_per_4(i,4)=p; 
    % continue with the rest of your cod
end

subplot(1,2,1) 
 plot(mean_diff);
 xlabel('cell no');
 ylabel('Periodic-Aperiodic response difference');
 subplot(1,2,2) 
 plot(norm_mean_diff);
 xlabel('cell no');
 ylabel('Normalised Periodic-Aperiodic response difference');
 %main title
    suptitle('Periodic-Aperiodic response difference for periodicity 4 ');

