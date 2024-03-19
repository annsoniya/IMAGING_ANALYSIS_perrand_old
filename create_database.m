files = dir('*.mat');
db = table();

animalNumber = input('Enter the animal number: ');

for i = 1:length(files)
    data = load(files(i).name);
%     stim_fre=data.PP_PARAMS.AUD_IMG_STIM.STIMS.Fre;
%     stimcode=data.PP_PARAMS.AUD_IMG_STIM.STIMS.stimcode;
%     stim_att=data.PP_PARAMS.protocol.stim_protocol.db_atten ;
    if isfield(data, 'Cell_dff') && isfield(data, 'PP_PARAMS')
        for j = 1:size(data.Cell_dff, 1)
            row = table({files(i).name}, animalNumber, squeeze({data.Cell_dff(j, :, :)}), {data.PP_PARAMS.AUD_IMG_STIM.STIMS.Fre},{data.PP_PARAMS.AUD_IMG_STIM.STIMS.stimcode},{data.PP_PARAMS.protocol.stim_protocol.db_atten}, 'VariableNames', {'File', 'Animal_Number', 'Cell_dff', 'STIM_FRE', 'STIM_code', 'STIM_ATT'});
            db = [db; row];
        end
    end
end

%% for second folder on for next animals 

% db = load('existing_database.mat');

files = dir('*.mat');
animalNumber = input('Enter the animal number: ');

for i = 1:length(files)
    data = load(files(i).name);
%     stim_fre=data.PP_PARAMS.AUD_IMG_STIM.STIMS.Fre;
%     stimcode=data.PP_PARAMS.AUD_IMG_STIM.STIMS.stimcode;
%     stim_att=data.PP_PARAMS.protocol.stim_protocol.db_atten ;
    if isfield(data, 'Cell_dff') && isfield(data, 'PP_PARAMS')
        for j = 1:size(data.Cell_dff, 1)
            row = table({files(i).name}, animalNumber, squeeze({data.Cell_dff(j, :, :)}), {data.PP_PARAMS.AUD_IMG_STIM.STIMS.Fre},{data.PP_PARAMS.AUD_IMG_STIM.STIMS.stimcode},{data.PP_PARAMS.protocol.stim_protocol.db_atten}, 'VariableNames', {'File', 'Animal_Number', 'Cell_dff', 'STIM_FRE', 'STIM_code', 'STIM_ATT'});
            db = [db; row];
        end
    end
end
  