%for bleachng correction in imaging analysis.
% concept :- fit an expoenential curve to teh dfff for all frames and substarct it from teh actual data
clear all;
clc;
cell=load('SigWith5Frms.mat');
cellstimcode=cell.SigWith5Frms(:,5);% get the dff column only from the database

celldata=cell.SigWith5Frms(:,3);
% define a cell array to store the corrected data
%cells_after_bleach_crrtn=cell(size(cell.SigWith5Frms,1),2);
% define a matrix to store the corrected data
for jj=1:size(celldata,1) % for all cells  
    allcdff=squeeze(celldata.Cell_dff{jj});
    %imagesc(squeeze(mean(allcdff)));
    % do correction for all iters seperately  
    for ii=1:size(allcdff,1)      % for all iterations seperately 
        pp=polyfit(1:10,(log(1+allcdff(ii,1:10))),1);
        blcorr=exp(pp(1)*[1:40]+pp(2))-1;
        allcdff(ii,:)=allcdff(ii,:)-blcorr;       
    end
    % save the corrected data for each cell all iters in the cell
    cells_after_bleach_crrtn{jj,1}=allcdff;
    cells_after_bleach_crrtn{jj,2}=cellstimcode.STIM_code{jj};
    % plot the corrected data for each cell all iters
end
% plot the corrected data for each cell all iters

% for jj=1:size(celldata,1)
%     figure(jj);
%     imagesc(squeeze(mean(cells_after_bleach_crrtn{jj})));
%     %plot the mean of all iters
%     figure(jj+size(celldata,1));
%     plot(squeeze(mean(cells_after_bleach_crrtn{jj})));
%
% end

