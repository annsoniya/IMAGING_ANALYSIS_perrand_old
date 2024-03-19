% load main database and pass it into db variable
clear ;
SigWith5Frms = table();
%load cells after bleacing coprrection 
cellData=load('cells_after_bleach_crrtn.mat');
%introduce bonferroni correction factor 
bonferroni=0.05/16;
hValues = []; % Initialize an empty array to store h values
significantCells = []; % Initialize an empty array to store significant cells

for i = 1:height(cellData.cells_after_bleach_crrtn)
    cellData1 = cellData.cells_after_bleach_crrtn{i};
    baselineFrames = mean(cellData1(:, 4:8),2);
    isSignificant = false; % Initialize flag for significant cell
    % for sliding window of 5 frames 
    for j = 9:1:40
        if j+4 <= size(cellData1, 2) % Ensure we don't exceed the matrix dimensions
            responseFrames = mean(cellData1(:, j:j+4),2);
            % Perform t-test
            h = ttest2(baselineFrames(:), responseFrames(:), 'Alpha', bonferroni);
    
            if h == 1 % If the cell is significant
                isSignificant = true;
                break; % No need to check further sets for this cell
            end
        end
    end
    
    if isSignificant
        significantCells = [significantCells; i]; % Save index of significant cell
    end
end

% Create a new table containing only the significant cells
SigWith5Frms = cellData.cells_after_bleach_crrtn(significantCells, :);
