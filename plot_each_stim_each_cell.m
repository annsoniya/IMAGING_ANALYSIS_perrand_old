% Calculate the average over all iterations for each cell and stimulus
db=load('D:\ann_analysis\IMAGING_ANALYSIS\IMAGING_ANALYSIS\sig_cell_stimwise.mat')

db=db.sig_cell_stimwise;

% Iterate over all cells
for i = 1:size(db,1)
    % Iterate over all stimuli
    for j = 1:size(db,2)
        % Calculate the average value for this cell and stimulus
        stim_dff=cell2mat(db(i, j, :));
        
        avg_sig(1,:)= mean(stim_dff);
        %plot the average value for this cell and stimulus as subplots for all 16 stimuli
        subplot(4,4,j);

        % draw a line at the time of stimulus onset @ 9th frame with teh y limit as taht of the average signal
        line([9 9], [min(avg_sig(1,:)) max(avg_sig(1,:))], 'Color', 'r');

        hold on;
        plot(avg_sig(1,:));
                title(['Stimulus ' num2str(j)]);

    end
    suptitle(['Cell ' num2str(i)]);

    pause;
    clf;
end
