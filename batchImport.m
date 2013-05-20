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
subject = zeros(n,1);

% Initialize experiment start and end dates
sDate = zeros(n,1);
eDate = zeros(n,1);
sDate(1) = datenum(2013,3,26);
eDate(1) = datenum(2013,4,1);
sDate(2) = datenum(2013,3,26);
eDate(2) = datenum(2013,4,1);
sDate(3) = datenum(2013,4,2);
eDate(3) = datenum(2013,4,9);
% sDate(4) = datenum(2013,4,2);
% eDate(4) = datenum(2013,4,9);

for i1 = 1:n
    filename = fullfile(directory,listing(i1).name);
    [time1,lux1,CLA1,CS1,activity1] = importDaysimeter(filename);
    % Find subject number
    expression = 'subject(\d*).*';
    tokens = regexpi(listing(i1).name,expression,'tokens');
    subject(i1) = str2double(tokens{1});
    % Trim data to experiment period
    idx = (time1 >= sDate(subject(i1))) & (time1 < eDate(subject(i1)));
    time{i1} = time1(idx);
    lux{i1} = lux1(idx);
    CLA{i1} = CLA1(idx);
    CS{i1} = CS1(idx);
    activity{i1} = activity1(idx);
end

%% Save imported data
save('sourceData.mat','time','lux','CLA','CS','activity','subject');

end
