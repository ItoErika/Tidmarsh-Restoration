% GOOGLE EARTH PLOTS of SOIL MOISTURE at TIDMARSH

LatLong= xlsread('LatLong.xlsx')

numpoints=113;
GES=zeros(1,numpoints);
x=1;

% Dynamax TH2O Soil Moisture Measurements - effectively an integrated measurement 0-6 cm
Probe_Data= xlsread('Probe_Data.xlsx');

% Extract 2nd column of Probe_Data
Theta=Probe_Data(:,2)

hi_lo_theta=1-Theta;

crange=0:(1/63):1;
for x=1:numpoints
[d p] = min(abs(crange - hi_lo_theta(x,1)));
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
k = kml('SoilMoisture_0_6cm_GE_Map');
for x=1:numpoints;
    k.point(LatLong(x,2),LatLong(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on
   
end
k.run
