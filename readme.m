%read me 

changes made in the significant cell selection -  introduced bonferroni correction of 16 

create_sig_with_5sets_frms created db with moving average of 5 frames and stored it in 
matrix = SigWith5Frms

> then performed bleaching correction on the dff values 
%% stim details 
% categorising teh segments into periodic and random stimulus line outputa
periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];

%% 

cells_after_bleach_crrtn is teh database with all cells after bleaching correction/ sig not done in this database.
sig_cell_stimwise_40frms is teh final database after bleaching correction arranged according to stimulus

