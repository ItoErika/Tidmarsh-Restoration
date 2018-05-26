%%%%%%%%%%%%%%%%%%%%%%% All 10 cm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('TW_10cm.mat')

% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0);
% Find the middle point in the positive distance data
middist=length(posdist)/2;
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist));
% Subset the temperature data matrix to only include the selected distances
plottemp=tempC(1:length(plotdist),:);

% Shift datenum by 4 hours to convert from GMT
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end

% Plot figure
figure
imagesc(plotdist, datetimeshifted, flipud(rot90(plottemp)))
colorbar
datetick('y', 2, 'keeplimits')
caxis([-5 10])
title('Tidmarsh West Soil 10 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_10cm_Jan.pdf');

%%%%%%%%%%%%%%%%%%%%%%% All 20 cm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('TW_20cm.mat')
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end

figure
imagesc(plotdist, datetimeshifted, flipud(rot90(plottemp)))
colorbar
datetick('y', 2, 'keeplimits')
caxis([-5 10])
title('Tidmarsh West Soil 20 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_20cm_Jan.pdf');

%%%%%%%%%%%%%%%%%%%%%%% All 30 cm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('TW_30cm.mat')

% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end

figure
imagesc(plotdist, datetimeshifted, flipud(rot90(plottemp)))
colorbar
datetick('y', 2, 'keeplimits')
caxis([-5 10])
title('Tidmarsh West Soil 30 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_30cm_Jan.pdf');

%%%%%%%%%%%%%%%%%%%%%%% Air Temp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('TW_10cm.mat')

% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0);
% Find the middle point in the positive distance data
middist=length(posdist)/2;
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist));
% Subset the temperature data matrix to only include the selected distances
plottemp=tempC(1:length(plotdist),:);

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end

% Extract air temperature from the field trip dates
airtemp=plottemp(length(plottemp),:)
plot(datetimeshifted, airtemp, 'b-','linewidth',2)
datetick('x', 6, 'keeplimits')
hold on
% plot average air temperature
meanair=mean(airtemp)*(ones(size(airtemp)))
plot(datetimeshifted, meanair, 'k--', 'linewidth', 2)
ylim([-2, 7])
ylabel('Temperature (deg C)')
xlabel('Time')
title('Air Temperature')
legend('Temperature', 'Mean')
hold off
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.8,7.5]);
print(gcf, '-dpdf', 'TW_DTS_airtemp_Jan.pdf');

%%%%%%%%%%%%%%%%%%%%%%% Channel Temp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extract tempterature for the coil 10 cm under the streambed
load('TW_10cm.mat')
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp10=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted10=[];
for i=1:numel(datetime)
datetimeshifted10=[datetimeshifted10;addtodate(datetime(i),-4,'hour')];
end

% Get data for the coil 20 cm under the streambed
load('TW_20cm.mat')
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp20=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted20=[];
for i=1:numel(datetime)
datetimeshifted20=[datetimeshifted20;addtodate(datetime(i),-4,'hour')];
end

% Get data for the coil 30 cm under the streambed
load('TW_30cm.mat')
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp30=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT
datetimeshifted30=[];
for i=1:numel(datetime)
datetimeshifted30=[datetimeshifted30;addtodate(datetime(i),-4,'hour')];
end

channeltemp10=plottemp10(3200,:);
channeltemp20=plottemp20(3200,:);
channeltemp30=plottemp30(3200,:);

plot(datetimeshifted10, channeltemp10, 'r-','linewidth',2)
datetick('x', 6, 'keeplimits')
hold on
% plot 20 cm
plot(datetimeshifted20, channeltemp20, 'g-', 'linewidth', 2)
% plot 30 cm
plot(datetimeshifted30, channeltemp30, 'b-', 'linewidth', 2)
ylim([-2, 7])
ylabel('Temperature (deg C)')
xlabel('Time')
legend('10 cm','20 cm', '30 cm')
title('Channel Temperature')
hold off
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.8,7.5]);
print(gcf, '-dpdf', 'TW_DTS_channel_2.pdf');

%%%%%%%%%%%%%%%%%%%%%%% Hottest Temp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extract tempterature for the coil 10 cm under the streambed
load('TW_10cm.mat')
posdistlim10=find(distance>=0,1)
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist10T=distance(posdistlim10:(length(distance(distance<=0))+middist))

load('TW_20cm.mat')
posdistlim20=find(distance>=0,1)
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist20T=distance(posdistlim20:(length(distance(distance<=0))+middist))

load('TW_30cm.mat')
posdistlim30=find(distance>=0,1)
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist30T=distance(posdistlim30:(length(distance(distance<=0))+middist))

% 13-Jan-2018 14:53:59
hottesttemp10=plottemp10(posdistlim10:length(plottemp10),211);
% 13-Jan-2018 14:59:00
hottesttemp20=plottemp20(posdistlim20:length(plottemp20),211);
% 13-Jan-2018 15:04:01
hottesttemp30=plottemp30(posdistlim30:length(plottemp20),211);

plot(plotdist10T, hottesttemp10, 'r-','linewidth',1)
hold on
% plot 20 cm
plot(plotdist20T, hottesttemp20, 'g-','linewidth',1)
% plot 30 cm
plot(plotdist30T, hottesttemp30, 'b-','linewidth',1)
ylim([-1, 20])
xlim([0, 940])
ylabel('Temperature (deg C)')
xlabel('Distance')
legend('10 cm (2:53 PM)','20 cm (2:59 PM)', '30 cm (3:04 PM)')
title('Hottest Time of Day on 1/13')
hold off
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.8,5.5]);
print(gcf, '-dpdf', 'TW_DTS_hot_Jan_13.pdf');

% 13-Jan-2018 02:53:36
coldesttemp10=plottemp10(posdistlim10:length(plottemp10),199);
% 13-Jan-2018 02:58:37
coldesttemp20=plottemp20(posdistlim20:length(plottemp20),199);
% 13-Jan-2018 03:03:38
coldesttemp30=plottemp30(posdistlim30:length(plottemp30),199);

plot(plotdist10T, coldesttemp10, 'r-','linewidth',1)
hold on
% plot 20 cm
plot(plotdist20T, coldesttemp20, 'g-','linewidth',1)
% plot 30 cm
plot(plotdist30T, coldesttemp30, 'b-','linewidth',1)
ylim([-1, 20])
xlim([0, 940])
ylabel('Temperature (deg C)')
xlabel('Distance')
legend('10 cm (2:53 AM)','20 cm (2:58 AM)', '30 cm (3:03 AM)')
title('Coldest Time of Day on 1/13')
hold off
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.8,5.5]);
print(gcf, '-dpdf', 'TW_DTS_cold_Jan_13.pdf');





% Shift datenum by 4 hours to convert from GMT?
datetimeshifted10=[];
for i=1:numel(datetime)
datetimeshifted10=[datetimeshifted10;addtodate(datetime(i),-4,'hour')];
end

% Get data for the coil 20 cm under the streambed
load('TW_20cm.mat')
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp20=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted20=[];
for i=1:numel(datetime)
datetimeshifted20=[datetimeshifted20;addtodate(datetime(i),-4,'hour')];
end

% Get data for the coil 30 cm under the streambed
load('TW_30cm.mat')
% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp30=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT
datetimeshifted30=[];
for i=1:numel(datetime)
datetimeshifted30=[datetimeshifted30;addtodate(datetime(i),-4,'hour')];
end

channeltemp10=plottemp10(3200,:);
channeltemp20=plottemp20(3200,:);
channeltemp30=plottemp30(3200,:);

plot(datetimeshifted10, channeltemp10, 'b-','linewidth',2)
datetick('x', 6, 'keeplimits')
hold on
% plot 20 cm
plot(datetimeshifted20, channeltemp20, 'g-', 'linewidth', 2)
% plot 30 cm
plot(datetimeshifted30, channeltemp30, 'r-', 'linewidth', 2)
ylim([-2, 7])
ylabel('Temperature (deg C)')
xlabel('Time')
legend('10 cm','20 cm', '30 cm')
title('Channel Temperature')
hold off
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.8,7.5]);
print(gcf, '-dpdf', 'TW_DTS_channel_2.pdf');








 Some General Commands for plotting DTS Data

% This command will load the temperature file parsed from the individual data files
% It contains reference temperature loggers (two external and one internal)
% The matrix of temperatures, corresponding vectors of time and distance,
% raw Stokes and anti-Stokes data
% and a few calibration parameters

load DTS_Deployment_Name.mat

% Plot all temps at once with default colors:

plot (distance, TtmpC)

% Plotting all of the reference temperatures together, specifying line widths and colors
% translating "matlab" time into real timestamps once plotted
% the number 13 might be good for times and 6 good for dates but check this
% labeling axes
% setting axis limits explicitly 
% and generating a pdf of the plot.  Note that you should go into "print preferences"
% first and set size, scaling and color or not before you do this or it will default to
% a small, square plot.

plot (datetime, tref_int, 'k-','linewidth',2)
hold
plot (datetime, tref_2, 'r-','linewidth',2)
plot (datetime, tref_1, 'b-','linewidth',2)
datetick('x',13,'keeplimits')
title('Temperature Reference: Hot Bath, Cold Bath, Internal')
ylabel('Temperature (degrees C)')
legend('tref int','tref 2','tref 1')
ylim([0 50])
print plot1_tref.pdf -dpdf

% This command will make the colored time vs. distance plots
% First open a new figure window
% Call the plot command "imagesc" with the two axis vectors first (R,C) then matrix
% plot a color axis, then specify its range
% assorted labels etc...

max(tempC(:))
min(tempC(:))

load('TW_10cm.mat')

% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end

figure
imagesc(plotdist, datetimeshifted, rot90(plottemp))
colorbar
datetick('y', 2, 'keeplimits')
caxis([0 15])
title('Tidmarsh West Soil 10 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_All_10cm_half.pdf');

load('TW_20cm.mat')

% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end

figure
imagesc(plotdist, datetimeshifted, rot90(plottemp))
colorbar
datetick('y', 2, 'keeplimits')
caxis([0 15])
title('Tidmarsh West Soil 20 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_All_20cm_half.pdf');

load('TW_30cm.mat')

% Remove mirrored part of plot
% Remove negative distance values in DTS box in barn
posdist=distance(distance>0)
% Find the middle point in the positive distance data
middist=length(posdist)/2
% Subset distance data to only include half of mirrored data
% NOTE: remember to add the length of negative data to find the proper midpoint
plotdist=distance(1:(length(distance(distance<=0))+middist))
% Subset the temperature data matrix to only include the selected distances
plottemp=tempC(1:length(plotdist),:)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end

figure
imagesc(plotdist, datetimeshifted, rot90(plottemp))
colorbar
datetick('y', 2, 'keeplimits')
caxis([0 15])
title('Tidmarsh West Soil 30 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_All_30cm_half.pdf');

print DTS_Data_TMap.pdf -dpdf

NumTicks=15
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),NumTicks))

tick_locations = datenum(2009,10:1:54,1);
set(gca,'XTick',tick_locations)

print DTS_Data_TMap.pdf -dpdf

% Some syntax for plotting a specific distance...

distance([218 396 487])
plot(datetime,calTemp(218,:),'r-','linewidth',2)
datetick('x',13,'keeplimits')
hold
plot(datetime,calTemp(396,:),'g-','linewidth',2)
plot(datetime,calTemp(487,:),'k-','linewidth',2)
