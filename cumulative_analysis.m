%execute data_classification file first 

% find cumulative segemnts in teh order of 300 added to 501 lie 501-800, 501-1100, 501-1400, 501-1700, 501-2000, 501-2300, 501-2600, 501-2900, 501-3200, 501-3500, 501-3800, 501-4100, 501-4400
startBin = 9;
endBins = 11:3:32; % Creates an array [800, 1100, ..., 4400]

data_per=data_per_3;
data_aper=data_aper_3

%% 
data_per=data_per_3_2f2f1;
data_aper=data_aper_3_2f2f1;

data_per=data_per_3_2f1f2;
data_aper=data_aper_3_2f1f2;
%% 1200,2400,3600 periodicity =3
startBin = 500;
endBins = 1200:1200:3600; %


%% periodicity 4 
startBin = 500;
endBins = 900:400:4100; % 

%% 1200 2400 3600 periodicity =4
startBin = 500;
endBins = 1200:1200:3600; %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
data_per=data_per_4;
data_aper=data_aper_4;

%% declare all the variable in proper sizes
cum_data_per=cell(size(data_per,1),length(endBins));% 
cum_data_aper=cell(size(data_aper,1),length(endBins));%

p_t_both=zeros(size(data_per,1),length(endBins));%
h_t_both=zeros(size(data_per,1),length(endBins));%

p_t_rt=zeros(size(data_per,1),length(endBins));%        
h_t_rt=zeros(size(data_per,1),length(endBins));%

p_t_lt=zeros(size(data_per,1),length(endBins));%
h_t_lt=zeros(size(data_per,1),length(endBins));%

% chnage these accroding to teh requirement 

[cum_data_per,cum_data_aper] = find_cumulativeMean(data_per,data_aper,startBin,endBins);
%SIgnificance test for cumulative segments 
for i=1:size(cum_data_per,1)
    for j=1:size(cum_data_per,2)
        %[p(i,j),h(i,j)] = ranksum(cum_data_per{i,j},cum_data_aper{i,j});%
        % t test    

        %[h, p, ci, stats] = ttest2(data1, data2, 'Vartype', 'unequal', 'Tail', 'both', 'omitnan');
% exclude NaN values from the data
x=cum_data_per{i,j};
y=cum_data_aper{i,j};
x=x(find(~isnan(x)));
y=y(find(~isnan(y)));
        [h_t_both(i,j),p_t_both(i,j)] = ttest2(x,y,'Tail', 'both', 'Vartype', 'unequal');
        [h_t_rt(i,j),p_t_rt(i,j)] = ttest2(x,y,'Tail','right','Alpha',0.05,'Vartype','unequal');
        %left
        [h_t_lt(i,j),p_t_lt(i,j)] = ttest2(x,y,'Tail','left','Alpha',0.05,'Vartype','unequal');
             
%%% 
%ranksum block with x and y
%      [p_rs(i,j),h_rs(i,j)] = ranksum(x,y);
%      %righttailed
%         [p_rs_rt(i,j),h_rs_rt(i,j)] = ranksum(x,y,'tail','right');
%         %lefttailed
%         [p_rs_lt(i,j),h_rs_lt(i,j)] = ranksum(x,y,'tail','left');


%         [h_t(i,j),p_t(i,j)] = ttest2(cum_data_per{i,j},cum_data_aper{i,j},'Tail', 'both', 'Vartype', 'unequal');
%         [h_t_rt(i,j),p_t_rt(i,j)] = ttest2(cum_data_per{i,j},cum_data_aper{i,j},'Tail','right','Alpha',0.05,'Vartype','unequal');
%              %   [h_t_rt(i,j),p_t_rt(i,j)] = ttest2(cum_data_per{i,j},cum_data_aper{i,j},'Tail','right','Alpha',0.05);
% 
%         % right tail means right>left= per>aper ,but with unequal variances 
%         [h_t_lt(i,j),p_t_lt(i,j)] = ttest2(cum_data_per{i,j},cum_data_aper{i,j},'Tail','left','Alpha',0.05,'Vartype','unequal');
    end
end
%% 
% %  Calculate the average mean value for each segment across all neurons(iirespective of significant or not)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%declare the variables
periodicData=cell(size(cum_data_per,1),size(cum_data_per,2));
AperiodicData=cell(size(cum_data_aper,1),size(cum_data_aper,2)) ;
periodicData=cum_data_per;
AperiodicData=cum_data_aper;
dataPeriodic=zeros(size(periodicData,1),size(periodicData,2));
dataAperiodic=zeros(size(AperiodicData,1),size(AperiodicData,2));
for units= 1:size(periodicData ,1)
    for col=1:size(periodicData ,2)
        x=mean(cell2mat(periodicData(units,col)),1);
        y=mean(cell2mat(AperiodicData(units,col)),1);
        dataPeriodic(units,col)=x;% each cell has only one value
        dataAperiodic(units,col)=y;
    end
 end
% load teh data to be analysed (every time chnage the file name)

 plotAverageMeanOfSegments_allneurons(dataPeriodic, dataAperiodic);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=0;
numSegments_h1=[];
max_h1=0;
indicesOfNeurons=[];

%      h=h_t_both;% load h values from the significance test
%     h=h_t_rt;
  h=h_t_lt;
numSegments_h1 = sum(h(:, 1:size(h, 2)), 'omitnan');
% Sum across the first dimension (rows) to get the sum for each column
columnSums = sum(h, 1, 'omitnan');

%%%%% Find the number of units with h values = 1
rowsWithOne = any(h == 1, 2);
indicesOfNeurons = find(rowsWithOne);
numberOfNeurons = numel(indicesOfNeurons);
% Display the results
disp('Indices of Neurons with at least one column = 1:');
disp(indicesOfNeurons);
disp(['Total Number of such Neurons: ', num2str(numberOfNeurons)]);
tot_nof_segments= sum(numSegments_h1);
disp(['Total Number of such segments: ', num2str(tot_nof_segments)]);
% Display the result
disp('Sum of 1s for each column:');
disp(columnSums);
%plot_hvalues(h(indicesOfNeurons,:));

%% to plot significntly different neuron rates
%declare periodicData and AperiodicData
% load teh data to be analysed (every time chnage the file name)
periodicData=cell(length(indicesOfNeurons),size(cum_data_per,2));
AperiodicData=cell(length(indicesOfNeurons),size(cum_data_aper,2));
periodicData=cum_data_per(indicesOfNeurons,:);
AperiodicData=cum_data_aper(indicesOfNeurons,:);
% load teh data to be analysed (every time chnage the file name)
dataPeriodic=zeros(length(indicesOfNeurons),size(cum_data_per,2));
dataAperiodic=zeros(length(indicesOfNeurons),size(cum_data_aper,2));
% load teh data to be analysed (every time chnage the file name)
% data formatting of cells into average of all trials in each cells as nd as a matrix
for units= 1:size(periodicData ,1)
    for col=1:size(periodicData ,2)
        x=mean(cell2mat(periodicData(units,col)),1);
        y=mean(cell2mat(AperiodicData(units,col)),1);
        dataPeriodic(units,col)=x;% each cell has only one value
        dataAperiodic(units,col)=y;
    end
 end
  plotAverageMeanOfSegments_allneurons(dataPeriodic, dataAperiodic);

%% 
%%plotAverageMeanOfSegments_allneurons(periodicData, AperiodicData);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

periodicity = 3;
tag = 'allstim';
type = 'diff';
cum_analysis = saveToStructure(periodicity, tag, type);
