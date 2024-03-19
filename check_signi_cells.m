clear ;
significantCells_30frms = table();
data=load('thy1_perrand_awake_database.mat');
for i = 1:height(data.db)
    cellData = squeeze(data.db.Cell_dff{i});
    baselineFrames = mean(cellData(:, 4:8),2);
    responseFrames = mean(cellData(:, 9:30),2);
    
    [~, p] = ttest2(baselineFrames(:), responseFrames(:));2 
    
    if p < 0.05 % or whatever significance level you choose
        significantCells_30frms = [significantCells_30frms; data.db(i, :)];
    end
end
