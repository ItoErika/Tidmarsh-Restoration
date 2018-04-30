% Some General Commands for plotting DTS Data

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
caxis([-5 15])
title('Tidmarsh West Soil 10 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_All_10cm.pdf');

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end

figure
imagesc(distance, datetimeshifted, rot90(tempC))
colorbar
datetick('y', 2, 'keeplimits')
caxis([-5 15])
title('Tidmarsh West Soil 20 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_All_20cm.pdf');

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end


figure
imagesc(distance, datetimeshifted, rot90(tempC))
colorbar
datetick('y', 2, 'keeplimits')
caxis([-5 15])
title('Tidmarsh West Soil 30 cm')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_All_30cm.pdf');


datetext=datestr(datetime)

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end


figure
imagesc(distance, datetimeshifted(147:268), rot90(tempC(:,147:268)))
colorbar
datetick('y', 2, 'keeplimits')
caxis([-5 15])
title('Tidmarsh West Soil 10 cm (2/22/18-2/26/18)')
ylabel('Date')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_Field_10cm.pdf');

#191:216

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end


figure
imagesc(distance, datetimeshifted(147:268), rot90(tempC(:,147:268)))
colorbar
datetick('y', 2, 'keeplimits')
caxis([-5 15])
title('Tidmarsh West Soil 20 cm (2/22/18-2/26/18)')
ylabel('Time')
xlabel('Distance (m)')
set(get(colorbar,'label'),'string','Temperature (deg C)');
set(gcf,'PaperOrientation','landscape');
set(gcf, 'Units', 'inches', 'PaperPosition', [0,0,11.5,7.5]);
print(gcf, '-dpdf', 'TW_DTS_Field_20cm.pdf');

% Shift datenum by 4 hours to convert from GMT?
datetimeshifted=[];
for i=1:numel(datetime)
datetimeshifted=[datetimeshifted;addtodate(datetime(i),-4,'hour')];
end


figure
imagesc(distance, datetimeshifted(147:268), rot90(tempC(:,147:268)))
colorbar
datetick('y', 13, 'keeplimits')
caxis([-5 15])
title('Tidmarsh West Soil 30 cm (2/24/18)')
ylabel('Time')
xlabel('Distance (m)')
set(get(cb,'label'),'string','Temperature (deg C)');



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
