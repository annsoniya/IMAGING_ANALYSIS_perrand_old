%declare all vcariables
clear all;
close all;
clc;
data=load('thy1_perrand_awake_database.mat');
% figuring out the same roi cells from files using container map
rows = containers.Map(data.db);
for r=1:size(rows1,2)% rois 
    c=rows1{r};
    baselineFrames = zeros(length(c), 3);
    baselineFrames2 = zeros(length(c), 3);

    responseFrames = zeros(length(c),30);% use if neede 
    allframes = zeros(length(c), 6);
    for y=1:length(c)% all celsl in each roi
        cellData = squeeze(data.db.Cell_dff{c(y)});

        baselineFrames(y,:) = mean(cellData(:, 3:5));% mean of all trials 
        baselineFrames2(y,:) = mean(cellData(:, 6:8));
        
    end
    %plot average of all cells
    %combine baseline and response frames
    %allframes = [nanmean(baselineFrames),nanmean(baselineFrames2)];
    allframes = [(baselineFrames),(baselineFrames2)];

plot(1:size(allframes,2),allframes)
title([' ROI = ' num2str(r)] );
pause;
clf;

end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
baselineFrames = zeros(50, 3);
responseFrames = zeros(50, 3);
allframes = zeros(50, 3);
sem = zeros(1, 3);
%load data

for i = 250:300
    cellData = squeeze(data.db.Cell_dff{i});
    % cheack meadian of each cell
    baselineFrames(i,:) = mean(cellData(:, 3:5));
    responseFrames(i,:) =mean(cellData(:, 6:8));
end
%plot average of all cells
%combine baseline and response frames
allframes = [nanmean(baselineFrames), nanmean(responseFrames)];
% not taking average of all cells

allframes = [baselineFrames, responseFrames];
plot(1:size(allframes,2),allframes)

%calculate standard error of the mean
sem = nanstd(allframes)/sqrt(length(allframes));

subplot(3,3,1);
plot(allframes);
hold on;
%plot error bars
errorbar(1:length(allframes), allframes, sem, 'r');
title('Average dF/F of 500 cells- 3:8 frames ');
xlabel('Frame');
ylabel('dF/F');
legend('Baseline', 'Response');

