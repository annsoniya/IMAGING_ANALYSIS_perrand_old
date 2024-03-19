% plot the data on moving average of rates for each periodicity specified
% plot the data on moving average of rates for each periodicity specified
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

all_data_per_3=mean(cat(1,data_per_3{:}),1);
all_data_per_4=mean(cat(1,data_per_4{:}),1);
all_data_aper_3=mean(cat(1,data_aper_3{:}),1);
all_data_aper_4=mean(cat(1,data_aper_4{:}),1);

%plot 
figure;
subplot(1,2,1);
plot(all_data_per_3(1,9:33));
hold on;
plot(all_data_aper_3(1,9:33));
title('Periodicity 3');
% cgange teh x axis marks to 9 to 33
%set(gca,'XTickLabel',{'9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33'});
xlabel('Frames-9:33');
ylabel('Mean firing rate');
legend('Periodic','Aperiodic');
subplot(1,2,2);
plot(all_data_per_4(1,9:33));
hold on;
plot(all_data_aper_4(1,9:33));
title('Periodicity 4');
%set(gca,'XTickLabel',{'9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33'});

xlabel('Frames-9:33');
ylabel('Mean firing rate');
legend('Periodic','Aperiodic');
%mark a line at teh 9th frame to show the onset of the stimulus
line([9, 9], ylim, 'Color', 'r', 'LineStyle', '--');
%mark a line at the 27th frame to show the offset of the stimulus


%plot the variance of the data
figure;
subplot(1,2,1);
plot(movvar(all_data_per_3,windowSize));
hold on;
plot(movvar(all_data_aper_3,windowSize));
title('Periodicity 3');
set(gca,'XTickLabel',{'9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33'});
xlabel('Frames');
ylabel('Variance');
legend('Periodic','Aperiodic');
subplot(1,2,2);
plot(movvar(all_data_per_4,windowSize));
hold on;
plot(movvar(all_data_aper_4,windowSize));
title('Periodicity 4');
set(gca,'XTickLabel',{'9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33'});
xlabel('Frames');
ylabel('Variance');
legend('Periodic','Aperiodic');
%mark a line at teh 9th frame to show the onset of the stimulus
line([9, 9], ylim, 'Color', 'r', 'LineStyle', '--');
%mark a line at the 27th frame to show the offset of the stimulus
line([27, 27], ylim, 'Color', 'r', 'LineStyle', '--');
%plot the variance of the data



