% GOOGLE EARTH PLOTS of SOIL MOISTURE at TIDMARSH

Data0_5= xlsread('0-5_data.xlsx');
Data5_10= xlsread('5-10_data.xlsx');
Data10_20= xlsread('10-20_data.xlsx');
Data20_30= xlsread('20-30_data.xlsx');

LatLong05=Data0_5(:,2:3);
LatLong510=Data5_10(:,10:11);
LatLong1020=Data10_20(:,10:11);
LatLong2030=Data20_30(:,10:11);

load cmap.mat;

numpoints05=77;
numpoints510=10;
numpoints1020=11;
numpoints2030=10;

GES05=zeros(1,numpoints05);
GES510=zeros(1,numpoints510);
GES1020=zeros(1,numpoints1020);
GES2030=zeros(1,numpoints2030);

x=1;

% Dynamax TH2O Soil Moisture Measurements - effectively an integrated measurement 0-6 cm
%Probe_Data= xlsread('Probe_Data.xlsx');
% Extract 2nd column of Probe_Data
%Theta=Probe_Data(:,2)

% Extract ppm nitrate data
Nitrate05=Data0_5(:,4);
Nitrate510=Data5_10(:,2);
Nitrate1020=Data10_20(:,2);
Nitrate2030=Data20_30(:,2);

% Extract ppm P data
P05=Data0_5(:,5);
hi_lo_P05=1-(P05/19.775);
P510=Data5_10(:,3);
hi_lo_P510=1-(P510/19.775);
P1020=Data10_20(:,3);
hi_lo_P1020=1-(P1020/19.775);
P2030=Data20_30(:,3);
hi_lo_P2030=1-(P2030/19.775);

hi_lo_P2030=20-P2030;
 colormap('Hot')
crange=0:(20/63):20;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_P2030(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

crange=0:(1/63):1;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_P2030(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_2030_Map');
for x=1:numpoints2030;
    k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on
   
end
k.run


% Extract ppm Ca data
Ca05=Data0_5(:,6);
hi_lo_Ca05=1-(Ca05/184);
Ca510=Data5_10(:,4);
hi_lo_Ca510=1-(Ca510/184);
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=1-(Ca1020/184);
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=1-(Ca2030/184);
%%
crange=0:(1/63):1;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_Ca2030(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_2030_Map');
for x=1:numpoints2030;
    k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on
   
end
k.run
%%

% Extract ppm Fe data
Fe05=Data0_5(:,7);
hi_lo_Fe05=1-(Fe05/162);
Fe510=Data5_10(:,5);
hi_lo_Fe510=1-(Fe510/162);
Fe1020=Data10_20(:,5);
hi_lo_Fe1020=1-(Fe1020/162);
Fe2030=Data20_30(:,5);
hi_lo_Fe2030=1-(Fe2030/162);

%%
crange=0:(1/63):1;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_Fe2030(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_2030_Map');
for x=1:numpoints2030;
    k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on
   
end
k.run
%%

% Extract ppm K data
K05=Data0_5(:,8);
hi_lo_K05=1-(K05/179.5);
K510=Data5_10(:,6);
hi_lo_K510=1-(K510/179.5);
K1020=Data10_20(:,6);
hi_lo_K1020=1-(K1020/179.5);
K2030=Data20_30(:,6);
hi_lo_K2030=1-(K2030/179.5);

%%
crange=0:(1/63):1;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_K2030(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_2030_Map');
for x=1:numpoints2030;
    k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on
   
end
k.run
%%

% Extract ppm Mg data
Mg05=Data0_5(:,9);
hi_lo_Mg05=1-(Mg05/119.5);
Mg510=Data5_10(:,7);
hi_lo_Mg510=1-(Mg510/119.5);
Mg1020=Data10_20(:,7);
hi_lo_Mg1020=1-(Mg1020/119.5);
Mg2030=Data20_30(:,7);
hi_lo_Mg2030=1-(Mg2030/119.5);

%%
crange=0:(1/63):1;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_Mg2030(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Mg_2030_Map');
for x=1:numpoints2030;
    k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on
   
end
k.run
%%

% Extract ppm TKN data
TKN05=Data0_5(:,10);
hi_lo_TKN05=1-(TKN05/2670);
TKN510=Data5_10(:,8);
hi_lo_TKN510=1-(TKN510/2670);
TKN1020=Data10_20(:,8);
hi_lo_TKN1020=1-(TKN1020/2670);
TKN2030=Data20_30(:,8);
hi_lo_TKN2030=1-(TKN2030/2670);

%%
crange=0:(1/63):1;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_TKN2030(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('TKN_2030_Map');
for x=1:numpoints2030;
    k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on
   
end
k.run
%%




hi_lo_Theta=1-Theta;

crange=0:(1/63):1;
for x=1:numpoints
[d p] = min(abs(crange - hi_lo_Theta(x,1)));
colval(x,:)=floor(((cmap(p,:))*255));     
end

for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('SoilMoisture_0_6cm_GE_Map');
for x=1:numpoints;
    k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on
   
end
k.run
