% read sig matrix
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
% in thsi adatset each row has n number of stim, each having 5*40data
% we need to consider data from 9:33 only for five iterations average 
% call the 3 framesa nd cumulative ones as segments 
% 9,10,11(seg1)
% 9,10,11 ,12,13,14(seg2)
% like wise upto 33
%club all stim data intoa  n*40 matrix 
for i=1:size(data_per_3,1)
     % yy= cat(1,data_per_3{1,:});  
     per_3=[];
     per_3= cat(1,data_per_3{i,:});% takes all stim and formsa an array of no of (stim*5)*40 frames
     %for whole stim analysis find mean of all stim from 9:33
    for n = 0:9 % For each segment size (3, 6, 9, ..., 30)
            segmentSize = 3 * (n + 1); % Calculate the segment size
             cumuMean_per3{i,n+1} = mean(per_3(:, 9:9+segmentSize-1),2);
    %n=1 in wholestimmean=  9:11
    % n=9 gives 9:29
    end
end
for i=1:size(data_per_4,1)
     % yy= cat(1,data_per_3{1,:});  
     per_4=[];
     per_4= cat(1,data_per_4{i,:});% takes all stim and formsa an array of no of (stim*5)*40 frames
     %for whole stim analysis find mean of all stim from 9:33
    for n = 0:9 % For each segment size (3, 6, 9, ..., 30)
            segmentSize = 3 * (n + 1); % Calculate the segment size
             cumuMean_per4{i,n+1} = mean(per_4(:, 9:9+segmentSize-1),2);
    %n=1 in wholestimmean=  9:11
    % n=9 gives 9:29
    end
end
for i=1:size(data_aper_3,1)
     % yy= cat(1,data_per_3{1,:});  
     aper_3=[];
     aper_3= cat(1,data_aper_3{i,:});% takes all stim and formsa an array of no of (stim*5)*40 frames
     %for whole stim analysis find mean of all stim from 9:33
    for n = 0:9 % For each segment size (3, 6, 9, ..., 30)
            segmentSize = 3 * (n + 1); % Calculate the segment size
             cumuMean_aper3{i,n+1} = mean(aper_3(:, 9:9+segmentSize-1),2);
    %n=1 in wholestimmean=  9:11
    % n=9 gives 9:29
    end
end
for i=1:size(data_aper_4,1)
     % yy= cat(1,data_per_3{1,:});  
     aper_4=[];
     aper_4= cat(1,data_aper_4{i,:});% takes all stim and formsa an array of no of (stim*5)*40 frames
     %for whole stim analysis find mean of all stim from 9:33
    for n = 0:9 % For each segment size (3, 6, 9, ..., 30)
            segmentSize = 3 * (n + 1); % Calculate the segment size
             cumuMean_aper4{i,n+1} = mean(aper_4(:, 9:9+segmentSize-1),2);
    %n=1 in wholestimmean=  9:11
    % n=9 gives 9:29
    end
end
%apply ttest and find significant cases amon=g periodic an d aperiodic for every ell 
% for every cell
% for every segment size

% define a threshold for p value
alpha=0.05/10;
% for every cell 
for i=1:size(data_per_3,1)
    for n = 1:10
        [h_per3(i,n),p_per3(i,n)]=ttest2(cumuMean_per3{i,n},cumuMean_aper3{i,n},alpha);
    end
end
for i=1:size(data_per_4,1)
    for n = 1:10
        [h_per4(i,n),p_per4(i,n)]=ttest2(cumuMean_per4{i,n},cumuMean_aper4{i,n},alpha);
    end
end
%find the significant cells for each segment size
% find teh sum of segments for each cell for all segment sizes
for i=1:size(data_per_3,1)
    sig_per3(i)=sum(h_per3(i,:));
end
for i=1:size(data_per_4,1)
    sig_per4(i)=sum(h_per4(i,:));
end
%find the significant cells for any segment its not significant;y different
%for all segments
sig_per3_any=sig_per3>0;
%num of cells sig diff for per and aper for periodicity 3=
cell_per_Aper_3=sum(sig_per3_any);
sig_per4_any=sig_per4>0;

cell_per_Aper_4=sum(sig_per4_any);

% find teh cells significantly different for periodicity 3 and 4
for i=1:size(data_per_3,1)
    if sig_per3_any(i)==1 && sig_per4_any(i)==1
        sig_per3_4(i)=1;
    else
        sig_per3_4(i)=0;
    end
end
%numebr of cells common for 3 and 4
cells_gene=sum(sig_per3_4);


%% 
%if any cell is significantly different for more that one segment 
    sig_per3_any_moreseg=sig_per3>1;
%num of cells sig diff for per and aper for periodicity 3=
cell_per_Aper_3moreseg=sum(sig_per3_any_moreseg);
sig_per4_any_moreseg=sig_per4>1;

cell_per_Aper_4moreseg=sum(sig_per4_any_moreseg);
