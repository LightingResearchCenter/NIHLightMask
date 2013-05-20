function BulkProcess
%BULKPROCESS Summary of this function goes here
%   Detailed explanation goes here
startPath = fullfile('\\root','projects','NIH Light Mask','daysimeter_data');
rawPath = uigetdir(fullfile(startPath,'raw_files'),...
    'Select folder containing raw files.');
processedPath = uigetdir(fullfile(startPath,'processed_files'),...
    'Select folder to save output to.');
dirData = dir(fullfile(rawPath,'*log_info*'));
headerFiles = {dirData.name}';
dataFiles = regexprep(headerFiles,'log_info','data_log');
saveFiles = regexprep(headerFiles,'log_info','processed');

n = length(headerFiles);

for i1 = 1:n
    WriteProcessed(fullfile(rawPath,headerFiles{i1}),...
        fullfile(rawPath,dataFiles{i1}),...
        fullfile(processedPath,saveFiles{i1}));
end

end

