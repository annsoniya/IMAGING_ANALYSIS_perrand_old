%function for cumulative analysis of the data
function [cum_data_per,cum_data_aper]= find_cumulativeMean(data_per,data_aper,startBin,endBins)


for rowIndex = 1:size(data_per, 1)
    per= cat(1,data_per{rowIndex,:});
    aper= cat(1,data_aper{rowIndex,:});
    for i = 1:length(endBins)
        % Calculate the current range to process
        if i ==1
            % div fac is the avg of all trials from 9 to 32
        currentRange = startBin:endBins(i);
        div_fac_per = nanmean(nanmean(per(:, currentRange),2));
        div_fac_aper = nanmean(nanmean(aper(:, currentRange),2));
        end
        currentRange = startBin:endBins(i);
        cum_data_per{rowIndex,i} = nanmean(per(:, currentRange),2);
        cum_data_aper{rowIndex,i} = nanmean(aper(:, currentRange),2);
        normalizationPer = cum_data_per{rowIndex, i} ./ div_fac_per ;
        normalizationAper = cum_data_aper{rowIndex, i} ./ div_fac_aper;
        cum_data_per{rowIndex, i} = normalizationPer;
        cum_data_aper{rowIndex, i} = normalizationAper;
%         normalizationPer(isnan(normalizationPer)) = 0;
%         normalizationAper(isnan(normalizationAper)) = 0;
%         %do same for inf
%         
%         normalizationPer(isinf(normalizationPer)) = 0;
%         normalizationAper(isinf(normalizationAper)) = 0;
%         
        
    
        %         if i==1
        %             cum_data_per{rowIndex,1} = cum_data_per{rowIndex,1}./cum_data_per{rowIndex,1};
        %             cum_data_aper{rowIndex,1} = cum_data_aper{rowIndex,1}./cum_data_aper{rowIndex,1};
        %
        %         else
        %             cum_data_per{rowIndex,i} = cum_data_per{rowIndex,i}./cum_data_per{rowIndex,1};
        %             cum_data_aper{rowIndex,i} = cum_data_aper{rowIndex,i}./cum_data_aper{rowIndex,1};
        %
        %         end
    end   
end
end
