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
windowSize =2;

% classify cells as periodic or aperiodic for periodicity 3 and 4 separately
% periodicity 4
% select all cells and all stim corresposnding to stimset3 and stimset4 
data_per_3=data(:,periodic_stimset_3);
data_per_4=data(:,periodic_stimset_4);
data_aper_3=data(:,aperiodic_stimset_3);
data_aper_4=data(:,aperiodic_stimset_4);

%comaprison for whole stim from 9th frame to 33rd frame
% logic for 33 frmaes = 1sec after offset of stimuli 
% for periodicity 4

for i=1:size(data_per_4,1)
    per_3_allstim_alliter_mean=mean(cat(1,data_per_3{i,:}));
    per_4_allstim_alliter_mean=mean(cat(1,data_per_4{i,:}));
    aper_3_allstim_alliter_mean=mean(cat(1,data_aper_3{i,:}));
    aper_4_allstim_alliter_mean=mean(cat(1,data_aper_4{i,:}));
    
    for j=1:size(data_per_4,2)
        temp=data_per_4{i,j};
        temp=temp(9:33);
        data_per_4{i,j}=temp;
    end
end 