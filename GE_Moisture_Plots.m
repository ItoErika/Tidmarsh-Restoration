% GOOGLE EARTH PLOTS of SOIL MOISTURE at TIDMARSH

load Soil_Moisture_LatLong.txt
LatLong=Soil_Moisture_LatLong;

load moisture_data.mat
numpoints=33;
GES=zeros(1,numpoints);
x=1;

% Soil Moisture 0 to 100%; From 0 to 6 cm depth "A"

grav_hi_lo=1-grav_0_6;

crange=0:(1/63):1;
for x=1:numpoints
[d p] = min(abs(crange - grav_hi_lo(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

% Soil Moisture 0 to 100%; From 6 to 12 cm depth "B"

grav_hi_lo_deep=1-grav_6_12;

crange=0:(1/63):1;
for x=1:numpoints
[d p] = min(abs(crange - grav_hi_lo_deep(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

% Soil Moisture 0 to 100%; From 0 to 6 cm depth "Theta Probe"

grav_hi_lo_theta=100-theta;

crange=0:(100/63):100;
for x=1:numpoints
[d p] = min(abs(crange - grav_hi_lo_theta(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end


x=1;
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
