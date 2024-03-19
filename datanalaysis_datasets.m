function []= datanalysis_datasets(dataset)

    for i=1:size(dataset,1) %%** 6 stim*5 trials *40 frmaes
        aa=[]; 
        aa= cat(1,dataset{i,:});% 
        baseline=mean(aa(:,4:8),2);
        %find mean of all trials across 9:33 frames
        mean_aa=mean(aa(:,9:33),2);
        
        %find sig of this cell using ttest2 with alpha value =0.05
        [h, p_value] = ttest2(baseline, mean, 'Alpha', 0.05);
         %   [h, p_value] = ttest2(baseline_per_3, mean_per_3, 'Alpha', 0.05/bon_corr);
    
        if h==1
          value(i)=mean(mean(aa(:,9:33),2));
        else
         value_aper3(i)=0;
        end
    end
    [sorted_values, sorted_indices] = sort(value, 'descend');
zero_indices = sorted_indices(sorted_values == 0);
non_zero_indices=sorted_indices(sorted_values ~= 0);
