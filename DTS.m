% Some General Commands for plotting DTS Data

% This command will load the temperature file parsed from the individual data files
% It contains reference temperature loggers (two external and one internal)
% The matrix of temperatures, corresponding vectors of time and distance,
% raw Stokes and anti-Stokes data
% and a few calibration parameters

load DTS_Deployment_Name.mat

% Here is a sample command for plotting one line (x-y plot)

plot (datetime, tref_int)

% If you want to plot all of the temperatures at once, with default colors...

plot (distance, TempC)

% Plotting all of the reference temperatures together, specifying line widths and
colors
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

figure
imagesc(datetime,distance,TempC)
colorbar
datetick('x',13,'keeplimits')
caxis([-5 40])
title('DTS Data Collected at Field Site in Stream')
ylabel('Distance (m)')
xlabel('Time on March 31, 2011')
y2label('Temperature (degC)')
clabel('Temperature (degC)')

print DTS_Data_TMap.pdf -dpdf

% Some syntax for plotting a specific distance...

distance([218 396 487])
plot(datetime,calTemp(218,:),'r-','linewidth',2)
datetick('x',13,'keeplimits')
hold
plot(datetime,calTemp(396,:),'g-','linewidth',2)
plot(datetime,calTemp(487,:),'k-','linewidth',2)
