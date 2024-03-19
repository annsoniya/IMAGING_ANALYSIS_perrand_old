% get periodic dataset.
%each cell has n trials and each trial has40 frames. find mean of ll those trials and all frames 
% from 9:40 frames.
% plot teh histogram of all 1710 cells for periodic dataset.
%and aperiodic dataset.
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
for i=1:size(data_per_3,1)
    per_3=[];
    per_3= cat(1,data_per_3{i,:});% 
    %find mean of all trials across 9:33 frames
    per3(i)=mean(mean(per_3(:,9:33),2));
end 
% plot histogram and mark mean fourescence in x and no of cells in y axis
histogram(per3, 'BinWidth', 0.01);
xlabel('mean flourescence acroos 9:33 frames for all trials ');
ylabel('Frequency');
title('periodic stimulus,Periodicity=3');

% for aperioidc data of peiodicity 3
for i=1:size(data_aper_3,1)
    aper_3=[];
    aper_3= cat(1,data_aper_3{i,:});% 
    %find mean of all trials across 9:33 frames
    aper3(i)=mean(mean(aper_3(:,9:33),2));
end 
% plot histogram and mark mean fourescence in x and no of cells in y axis
histogram(aper3, 'BinWidth', 0.01);
%mark labels
xlabel('mean flourescence acroos 9:33 frames for all trials ');
ylabel('Frequency');
title('aperiodic stimulus,Periodicity=3');

% for periodic data of periodicity 4
for i=1:size(data_per_4,1)
    per_4=[];
    per_4= cat(1,data_per_4{i,:});% 
    %find mean of all trials across 9:40 frames
    per4(i)=mean(mean(per_4(:,9:33),2));
end 
% plot histogram and mark mean fluorescence in x and number of cells in y axis
histogram(per4, 'BinWidth', 0.01);
% mark labels
xlabel('mean fluorescence across 9:33 frames for all trials');
ylabel('Frequency');
title('Periodic stimulus, Periodicity=4');

for i=1:size(data_aper_4,1)
    aper_4=[];
    aper_4= cat(1,data_aper_4{i,:});% 
    %find mean of all trials across 9:40 frames
    aper4(i)=mean(mean(aper_4(:,9:33),2));
end 
% plot histogram and mark mean fluorescence in x and number of cells in y axis
histogram(aper4, 'BinWidth', 0.01);
% mark labels
xlabel('mean fluorescence across 9:33 frames for all trials');
ylabel('Frequency');
title('aperiodic stimulus, Periodicity=4');

