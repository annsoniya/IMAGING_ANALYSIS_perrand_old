

periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3 = [13,14,15,16];
 db=load('sig_cell_stimwise.mat');
db=db.sig_cell_stimwise;

numCells = size(db, 1);
meanPeriodic = zeros(numCells, 1);
meanAperiodic = zeros(numCells, 1);

% Assume isPeriodic is a logical array that indicates whether each stim is periodic
for cells = 1:numCells
    cellData = db{cells, :};
    meanPeriodic(cells) = mean(cellData(periodic_stimset_3));
    meanAperiodic(cells) = mean(cellData(aperiodic_stimset_3));
    figure;
plot(1:numCells, meanPeriodic, 'b', 1:numCells, meanAperiodic, 'r');
legend('Periodic', 'Aperiodic');
xlabel('Cell');
ylabel('Mean value');
end

% Plot the mean values
figure;
plot(1:numCells, meanPeriodic, 'b', 1:numCells, meanAperiodic, 'r');
legend('Periodic', 'Aperiodic');
xlabel('Cell');
ylabel('Mean value');