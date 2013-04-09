clear;
clc;

load('sourceData.mat','time','activity','CS','subject')

close all;

n = length(time);

for i1 = 1:n
    Title = ['NIH Sleep Mask Subject: ', num2str(subject(i1))];
    pseudoActogram(time{i1},activity{i1},CS{i1},Title);
    fileName = fullfile('pseudoActograms',['subject', num2str(subject(i1))]);
    print(gcf,'-dpng',[fileName,'.png'],'-r200');
    print(gcf,'-dpdf',[fileName,'.pdf'],'-r200');
    close;
end