% GOOGLE EARTH PLOTS of SEEPAGE METER DATA at TIDMARSH

% Load data
SM_Data= xlsread('SeepageMeters.xlsx');

% Extract lat long data
LatLong=SM_Data(:,1:2);

numpoints=5;

GES=zeros(1,numpoints);

x=1;

% Extract seepage data (cm^3/day)
% Assign Nmax
SMmax=4400;
% Add 2200 too account for negative data 
hilo_SM=SMmax-(SM_Data(:,5)+2200);

% Make plot
crange=0:(SMmax/63):SMmax;
for x=1:numpoints
[d p] = min(abs(crange - hilo_SM(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end
for x=1:numpoints
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Seepage_Meters');
for x=1:numpoints;
    k.point(LatLong(x,2),LatLong(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run

% Create colorbar for legend
clear colorbar
revcmap=flipud(cmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,13);
cb.TickLabels = num2cell(0:SMmax);
cb.TickLabels={'-1200','-1000','-800','-600','-400','-200','0','200','400','600','800','1000','1200'}
set(get(cb,'label'),'string','seepage (cm^3/day)');
