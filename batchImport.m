function batchImport
%BATCHIMPORT Import all processed Daysimeter files in a folder
%% Select folder and retrieve processed Daysimeter files
startDir = fullfile('\\root','projects','NIH Light Mask');
directory = uigetdir(startDir,'Select folder with processed Daysimeter files');
listing = dir(fullfile(directory,'*processed.txt'));

%% Import processed Daysimeter files
% Preallocate variables
n = length(listing);
time = cell(n,1);
lux = cell(n,1);
CLA = cell(n,1);
CS = cell(n,1);
activity = cell(n,1);

for i1 = 1:n
    filename = fullfile(directory,listing(i1).name);
    [time{i1},lux{i1},CLA{i1},CS{i1},activity{i1}] = ...
        importDaysimeter(filename);
end

%% Save imported data
save('sourceData.mat','time','lux','CLA','CS','activity');

end
