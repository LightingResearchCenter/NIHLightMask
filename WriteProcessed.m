function WriteProcessed(InfoName,DataName)
%WRITEPROCESSED Write processed data to text

ProcessedData = ReadRaw(InfoName,DataName);
time = ProcessedData.time;
lux = ProcessedData.lux;
CLA = ProcessedData.CLA;
CS = ProcessedData.CS;
activity = ProcessedData.activity;

% convert time to string format
timeStr = datestr(time,'dd/mm/yyyy HH:MM:SS');

% create text file
txtName = [DataName(1:end-4) '_Processed.txt']; % name of text file
fid = fopen(txtName,'w'); % create text file and open for writing
% write header row to file
fprintf(fid,'%s\t%s\t%s\t%s\t%s\r\n','time','lux','CLA','CS','activity');
% write data to file
for i1 = 1:length(time)
    fprintf(fid,'%s\t%.2f\t%.2f\t%.2f\t%.2f\r\n',...
    timeStr(i1,:),lux(i1),CLA(i1),CS(i1),activity(i1));
end
fclose(fid);
end

