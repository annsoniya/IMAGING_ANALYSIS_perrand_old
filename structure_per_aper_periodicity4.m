% aim:- 1) find units sig to periodic only out of 1710 and assign other units to zero 
%2) find units sig to aper and assign other units to zero.
% 3) in teh order of high to low of the mean value plot the mean of all trials keeping all frames for all cell
%4) sort the cells according to mean from high to low
%) in the same cell index plot perodic data for all frames
% now plot teh mean values of each cell in teh increasing order of (cell index of high to low periodic )




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
%%%% periodicity =4 %%%%
%%%%%% structure of aperiodic based on teh periodic data%%%%%%
for i=1:size(data_per_4,1) %%** 4 stim*5 trials *40 frames
    per_4=[]; 
    per_4= cat(1,data_per_4{i,:});% 
    baseline_per_4=mean(per_4(:,4:8),2);
    %find mean of all trials across 9:33 frames
    mean_per_4=mean(per_4(:,9:33),2);
    
    %find sig of this cell using ttest2 with alpha value =0.05
    [~, p_value] = ttest2(baseline_per_4, mean_per_4, 'Alpha', 0.05);
    if p_value < 0.05
      value_per4(i)=mean(mean(per_4(:,9:33),2));
    else
     value_per4(i)=0;
    end
end
% Sort the values for periodicity 3 in descending order
[sorted_values, sorted_indices] = sort(value_per4, 'descend');

% Sort the data based on the sorted indices
sorted_data_per_4 = data_per_4(sorted_indices, :); % 1710*6 cell
sorted_data_aper_4 = data_aper_4(sorted_indices, :); % 1710*4 cell

% Calculate the mean of all trials in each of the sorted periodic cells
for y = 1:size(sorted_data_per_4, 1)
    mean_sorted_data_per_4(y, :) = mean(cat(1, sorted_data_per_4{y, :}));
end

% Calculate the mean of all trials in each of the sorted aperiodic cells
for y = 1:size(sorted_data_aper_4, 1)
    mean_sorted_data_aper_4(y, :) = mean(cat(1, sorted_data_aper_4{y, :}));
end

% Plot the periodic data
subplot(1, 2, 1)
imagesc(mean_sorted_data_per_4(:, 9:33));
colorbar;
caxis([-0.7 0.7]);
xlabel('frames 9:33')
ylabel('periodic')
title('periodic data- Periodicity 4 ');

% Plot the aperiodic data
subplot(1, 2, 2)
imagesc(mean_sorted_data_aper_4(:, 9:33))
colorbar;
caxis([-0.7 0.7]);
xlabel('frames 9:33')
ylabel('Aperiodic')
title('Aperiodic data- periodicity 4 ');

% Plot the mean value of aperiodic data for cells of high to low mean value of periodic data
figure
bar(mean(mean_sorted_data_aper_4(:, 9:33), 2));
plot(mean(mean_sorted_data_aper_4(:, 9:33), 2));
xlabel('cells of high to low mean value of periodic data')
ylabel('mean value of aperiodic data')
title('mean value of aperiodic data for cells of high to low mean value of periodic data')


%%%%%%%%%%%%%%%% this ssegment deals with dataset making insignificant cells to zero%%%%%
zero_indices = sorted_indices(sorted_values == 0);
% make the cells= value data of aperiodic to zero ,  which are insignificant for periodic 
for i = 1:length(zero_indices)
    for j = 1:size(data_aper_4, 2)
        data_aper_4{zero_indices(i), j} = 0;
    end
     for j = 1:size(data_per_4, 2)
        data_per_4{zero_indices(i), j} = 0;
    end
end

sorted_data_per_4 = data_per_4(sorted_indices, :);%1710*6 cell
sorted_data_aper_4 = data_aper_4(sorted_indices, :);%1710*4 cell


% ;%mean of all trials in each of those cells
for y=1:size(sorted_data_per_4,1)
    mean_sorted_data_per_4(y,:)=mean(cat(1,sorted_data_per_4{y,:}));
end
% ;%mean of all trials in each of those cells
for y=1:size(sorted_data_aper_4,1)
    mean_sorted_data_aper_4(y,:)=mean(cat(1,sorted_data_aper_4{y,:}));%every cell has a mean pf all trials 
end
subplot(1,2,1)
imagesc(mean_sorted_data_per_4(:,9:33));
colorbar;
caxis([-0.7 0.7]);
xlabel('frames 9:33')
ylabel('periodic')
title('periodic data');
subplot(1,2,2)

imagesc(mean_sorted_data_aper_4(:,9:33))
colorbar;
caxis([-0.7 0.7]);
xlabel('frames 9:33')
ylabel('Aperiodic')
title('Aperiodic data');
% plot x axis the cell order of high to low mean indexes of periodic cells  and y axis the mean value
% of aperiodic data for those cells 

figure
bar(mean(mean_sorted_data_aper_4(:,9:33),2));
plot(mean(mean_sorted_data_aper_4(:,9:33),2));
xlabel('cells of high to low mean value of periodic data')
ylabel('mean value of aperiodic data')
title('mean value of aperiodic data for cells of high to low mean value of periodic data')



%% similar code to find aperiodically significant cells

% step 1:- check for the units that are significant for the aperiodic stimulus 
for i=1:size(data_aper_4,1) %%** 6 stim*5 trials *40 frames
    aper_4=[]; 
    aper_4= cat(1,data_aper_4{i,:});% 
    baseline_aper_4=mean(aper_4(:,4:8),2);
    % find mean of all trials across 9:33 frames
    mean_aper_4=mean(aper_4(:,9:33),2);
    
    % find sig of this cell using ttest2 with alpha value = 0.05
    [~, p_value] = ttest2(baseline_aper_4, mean_aper_4, 'Alpha', 0.05);
    if p_value < 0.05
        value_aper4(i)=mean(mean(aper_4(:,9:33),2));
    else
        value_aper4(i)=0;
    end
end
% number of cells that are significantly different on considering aperiodic stim only
% numel(find(value_aper3(1,:)~=0)) ====   421

% sort periodic data based on mean values from highest to lowest

sorted_indices=[];
sorted_values=[];
sorted_data_per_4=[];   
sorted_data_aper_4=[];
mean_sorted_data_per_4=[];
mean_sorted_data_aper_4=[];
[sorted_values, sorted_indices] = sort(value_aper4, 'descend');
sorted_data_per_4 = data_per_4(sorted_indices, :);%1710*6 cell
sorted_data_aper_4 = data_aper_4(sorted_indices, :);%1710*4 cell
% ;%mean of all trials in each of those cells
for y=1:size(sorted_data_per_4,1)
    mean_sorted_data_per_4(y,:)=mean(cat(1,sorted_data_per_4{y,:}));
    mean_sorted_data_aper_4(y,:)=mean(cat(1,sorted_data_aper_4{y,:}));%every cell has a mean pf all trials
end
%subplot both the periodic and aperiodic data WITH LABELS
subplot(1,2,1)
imagesc(mean_sorted_data_per_4(:,9:33));
colorbar;
caxis([-0.7 0.7]);
xlabel('frames 9:33')
ylabel('periodic')
title('Periodic data');
subplot(1,2,2)

imagesc(mean_sorted_data_aper_4(:,9:33))
colorbar;
caxis([-0.7 0.7]);
xlabel('frames 9:33')
ylabel('Aperiodic')
title('Aperiodic data');
% plot x axis the cell order of high to low mean indexes of periodic cells  and y axis the mean value
% of aperiodic data for those cells 
figure
bar(mean(mean_sorted_data_per_4(:,9:33),2));
plot(mean(mean_sorted_data_per_4(:,9:33),2));
xlabel('cells of high to low mean value of Aperiodic data')
ylabel('mean value of Periodic data')
title('mean value of Periodic data for cells of high to low mean value of Aperiodic data')


%%%%%%%%%%%%%%%% this ssegment deals with dataset making insignificant cells to zero%%%%%
zero_indices = sorted_indices(sorted_values == 0);
% make the cells= value data of periodic to zero ,  which are insignificant for aperiodic
for i = 1:length(zero_indices)
    for j = 1:size(data_aper_4, 2)
        data_aper_4{zero_indices(i), j} = 0;
    end
     for j = 1:size(data_per_4, 2)
        data_per_4{zero_indices(i), j} = 0;
    end
end
sorted_data_per_4=[];
sorted_data_aper_4=[];
sorted_data_per_4 = data_per_4(sorted_indices, :);%1710*6 cell
sorted_data_aper_4 = data_aper_4(sorted_indices, :);%1710*4 cell


% ;%mean of all trials in each of those cells
for y=1:size(sorted_data_per_4,1)
    mean_sorted_data_per_4(y,:)=mean(cat(1,sorted_data_per_4{y,:}));
end
% ;%mean of all trials in each of those cells
for y=1:size(sorted_data_aper_4,1)
    mean_sorted_data_aper_4(y,:)=mean(cat(1,sorted_data_aper_4{y,:}));%every cell has a mean pf all trials 
end
subplot(1,2,1)
imagesc(mean_sorted_data_per_4(:,9:33));
colorbar;
caxis([-0.7 0.7]);
xlabel('frames 9:33')
ylabel('periodic')
title('periodic data');
subplot(1,2,2)

imagesc(mean_sorted_data_aper_4(:,9:33))
colorbar;
caxis([-0.7 0.7]);
xlabel('frames 9:33')
ylabel('Aperiodic')
title('Aperiodic data');
% plot x axis the cell order of high to low mean indexes of periodic cells  and y axis the mean value
% of aperiodic data for those cells 

figure
bar(mean(mean_sorted_data_per_4(:,9:33),2));
plot(mean(mean_sorted_data_per_4(:,9:33),2));
xlabel('cells of high to low mean value of periodic data')
ylabel('mean value of aperiodic data')
title('mean value of aperiodic data for cells of high to low mean value of periodic data')





 
