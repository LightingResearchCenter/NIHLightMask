function pseudoActogram(time,AI,CS,Title)
%PSEUDOACTOGRAM Creates actogram like plots that also have CS plotted

%% Preprocess data
% Create time index relative to midnight before start of data
TI = time - floor(time(1));

runTime = ceil(TI(end));

% Divide data into days independent of sampling rate
idx = cell(runTime,1);
TI1 = cell(runTime,1);
AI1 = cell(runTime,1);
CS1 = cell(runTime,1);
subTitle = cell(runTime,1);
for i1 = 1:runTime
    idx{i1} = TI >= (i1 - 1) & TI < i1;
    TI1{i1} = (TI(idx{i1}) - (i1 - 1))*24; % New time index in hours
    AI1{i1} = AI(idx{i1});
    CS1{i1} = CS(idx{i1});
    subTitle{i1} = datestr(floor(min(time(idx{i1}))),'mm/dd/yy');
end

%% Create figure
paperPosition = [0 0 8.5 11];
figure1 = figure;
set(figure1,'PaperUnits','inches',...
    'PaperType','usletter',...
    'PaperOrientation','portrait',...
    'PaperPositionMode','manual',...
    'PaperPosition',paperPosition,...
    'Units','inches',...
    'Position',paperPosition);

% Create figure title
textbox1 = annotation('textbox',[.5 .5/8.5 0.1 0.1],'String',Title);
set(textbox1,'FitBoxToText','on','EdgeColor','none');
position1 = get(textbox1,'Position');
width = position1(3);
height = position1(4);
x = .5 - .5*width;
y = (paperPosition(4) - .25)/paperPosition(4) - height;
position1 = [x y width height];
set(textbox1,'Position',position1);

%% Create subplots
% Initialize subplot location variables
x = .5/paperPosition(3);
y1 = (paperPosition(4)-.5)/paperPosition(4);
width = (paperPosition(3)-1)/paperPosition(3);
height = ((paperPosition(4)-1)/runTime - .125)/paperPosition(4);
delta = ((paperPosition(4)-1)/runTime)/paperPosition(4);
% Generate subplots
for i2 = 1:runTime-1
    y = y1 - delta*i2;
    position = [x y width height];
    subActogram(TI1{i2},AI1{i2},CS1{i2},position,subTitle{i2},0);
    set(gca,'XTickLabel','');
end
% Generate last subplot
y = y1 - delta*runTime;
position = [x y width height];
subActogram(TI1{runTime},AI1{runTime},CS1{runTime},position,subTitle{runTime},1);

end

function subActogram(TI,AI,CS,position,label,legendToggle)
figure1 = gcf;
% Create axes
axes1 = axes;
set(axes1,'Parent',figure1,...
    'XLim',[0 24],...
    'XTick',0:2:24,...
    'YLim',[0 1],...
    'YTick',0:1,...
    'YTickLabel','',...
    'TickDir','out',...
    'OuterPosition',position,...
    'ActivePositionProperty','outerposition');
hold(axes1,'all');
% Plot AI
sAI = smooth(AI);
area1 = area(axes1,TI,sAI,'LineStyle','none');
set(area1,...
    'FaceColor',[0.2 0.2 0.2],'EdgeColor','none',...
    'DisplayName','AI');

% Plot CS
plot1 = plot(axes1,TI,CS);
set(plot1,...
    'Color',[0.6 0.6 0.6],'LineWidth',1,...
    'DisplayName','CS');

ylabel(label);
if legendToggle == 1
    legend1 = legend([area1, plot1]);
    set(legend1,'Orientation','vertical','Location','Best');
end
end

