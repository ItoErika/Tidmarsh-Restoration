%%%%%%%%%%%%%%%%%%%%%%% FIELD TRIP DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Field 10 cm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

figure
imagesc(plotdist, datetimeshifted(315:456), rot90(plottemp(:,315:456)))
colorbar
datetick('y', 2, 'keeplimits')
caxis([0 15])
title('Tidmarsh West Soil 10 cm (3/1/18-3/6/18)')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_Field_10cm_half.pdf');

%%%%%%%%%%%%%%%%%%%%%%% Field 20 cm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
imagesc(plotdist, datetimeshifted(315:456), rot90(plottemp(:,315:456)))
colorbar
datetick('y', 2, 'keeplimits')
caxis([0 15])
title('Tidmarsh West Soil 20 cm (3/1/18-3/6/18)')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_Field_20cm_half.pdf');

%%%%%%%%%%%%%%%%%%%%%%% Field 30 cm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
imagesc(plotdist, datetimeshifted(315:456), rot90(plottemp(:,315:456)))
colorbar
datetick('y', 2, 'keeplimits')
caxis([0 15])
title('Tidmarsh West Soil 30 cm (3/1/18-3/6/18)')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_Field_30cm_half.pdf');

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

%196:221
% Extract air temperature from the field trip dates
airtemp=plottemp(length(plottemp),:)
plot(datetimeshifted(363:408), airtemp(363:408), 'b-','linewidth',2)
datetick('x', 13, 'keeplimits')
% plot average air temperature
meanair=mean(airtemp(363:408))*(ones(size(363:408)))
plot(datetimeshifted(363:408), meanair, 'k--', 'linewidth', 2)
ylim([4, 6.5])
ylabel('Temperature (deg C)')
xlabel('Time')
title('Field Trip Air Temperature (3/3/18-3/4/18)')
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_airtemp.pdf');

%%%%%%%%%%%%%%%%%%%%%%% GW Temp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%196:221
% Extract groundwater temperature from the field trip date
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

gwtemp=plottemp(3200,:)
plot(datetimeshifted(363:408), gwtemp(363:408), 'b-','linewidth',2)
hold
datetick('x', 13, 'keeplimits')
% plot average gw temperature
meangw=mean(gwtemp(363:408))*(ones(size(363:408)));
plot(datetimeshifted(363:408), meangw, 'k--', 'linewidth', 2)
ylabel('Temperature (deg C)')
xlabel('Time')
ylim([6, 8.5])
title('Field Trip Ground Water Temperature (3/3/18-3/4/18)')
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_gwtemp_D.pdf');



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
