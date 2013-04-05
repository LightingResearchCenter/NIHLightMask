clear;
clc;

load('sourceData.mat','time','activity','CS','subject')

close all;

n = length(time);

for i1 = 1:n
    Title = ['NIH Sleep Mask Subject: ', cell2mat(subject{i1})];
    pseudoActogram(time{i1},activity{i1},CS{i1},Title);
    fileName = fullfile('pseudoActograms',['subject', cell2mat(subject{i1}),'.png']);
    print(gcf,'-dpng',fileName,'-r200');
    close;
end