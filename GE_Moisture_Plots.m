% GOOGLE EARTH PLOTS of SOIL MOISTURE at TIDMARSH

% Load data
Data5= xlsread('0-5_Data.xlsx');
Data10= xlsread('5-10_Data.xlsx');
Data20= xlsread('10-20_Data.xlsx');
Data30= xlsread('20-30_Data.xlsx');

% Extract lat long data
LatLong5=Data5(:,4:5);
LatLong10=Data10(:,4:5);
LatLong20=Data20(:,4:5);
LatLong30=Data30(:,4:5);

numpoints5=72;
numpoints10=11;
numpoints20=11;
numpoints30=11;

GES05=zeros(1,numpoints5);
GES510=zeros(1,numpoints10);
GES1020=zeros(1,numpoints20);
GES2030=zeros(1,numpoints30);

x=1;

% Dynamax TH2O Soil Moisture Measurements - effectively an integrated measurement 0-6 cm
%Probe_Data= xlsread('Probe_Data.xlsx');
% Extract 2nd column of Probe_Data
%Theta=Probe_Data(:,2)

% Extract ppm nitrate data
% Assign Nmax
Nmax=1;
hilo_N5=Nmax-Data5(:,8);
hilo_N10=Nmax-Data10(:,8);
hilo_N20=Nmax-Data20(:,8);
hilo_N30=Nmax-Data30(:,8);
hilo_N5_sub=Nmax-Data10(:,16);

% Assign cmap for Nitrate
Ncmap=cmap_dkgreen_white;
%0-5
crange=0:(Nmax/63):Nmax;
for x=1:numpoints5
[d p] = min(abs(crange - hilo_N5(x,1)));
colval(x,:)=floor(((Ncmap(p,:))*255));     
end
for x=1:numpoints5
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('N_0-5_Map');
for x=1:numpoints5;
    k.point(LatLong5(x,2),LatLong5(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10
crange=0:(Nmax/63):Nmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_N10(x,1)));
colval(x,:)=floor(((Ncmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('N_5-10_Map');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10 0-5
crange=0:(Nmax/63):Nmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_N10_5(x,1)));
colval(x,:)=floor(((Ncmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('N_5-10_Map_2');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%10-20
crange=0:(Nmax/63):Nmax;
for x=1:numpoints20
[d p] = min(abs(crange - hilo_N20(x,1)));
colval(x,:)=floor(((Ncmap(p,:))*255));     
end
for x=1:numpoints20
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('N_10-20_Map');
for x=1:numpoints20;
    k.point(LatLong20(x,2),LatLong20(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%20-30
crange=0:(Nmax/63):Nmax;
for x=1:numpoints30
[d p] = min(abs(crange - hilo_N30(x,1)));
colval(x,:)=floor(((Ncmap(p,:))*255));     
end
for x=1:numpoints30
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('N_20-30_Map');
for x=1:numpoints30;
    k.point(LatLong30(x,2),LatLong30(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(Ncmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:Nmax);
cb.TickLabels={'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','>/=1'}
set(get(cb,'label'),'string','ppm Nitrate (N)');

% Extract ppm orthophosphate data
% Assign Pmax
Pmax=10
hilo_P5=Pmax-Data5(:,9);
hilo_P10=Pmax-Data10(:,9);
hilo_P20=Pmax-Data20(:,9);
hilo_P30=Pmax-Data30(:,9);
hilo_P5_sub=Pmax-Data10(:,17);

% Assign cmap for P
cmapP=cmap_burgundy_white;
%0-5
crange=0:(Pmax/63):Pmax;
for x=1:numpoints5
[d p] = min(abs(crange - hilo_P5(x,1)));
colval(x,:)=floor(((Pcmap(p,:))*255));     
end
for x=1:numpoints5
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_0-5_Map');
for x=1:numpoints5;
    k.point(LatLong5(x,2),LatLong5(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10
crange=0:(Pmax/63):Pmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_P10(x,1)));
colval(x,:)=floor(((Pcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_5-10_Map');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%10-20
crange=0:(Pmax/63):Pmax;
for x=1:numpoints20
[d p] = min(abs(crange - hilo_P20(x,1)));
colval(x,:)=floor(((Pcmap(p,:))*255));     
end
for x=1:numpoints20
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_10-20_Map');
for x=1:numpoints20;
    k.point(LatLong20(x,2),LatLong20(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%20-30
crange=0:(Pmax/63):Pmax;
for x=1:numpoints30
[d p] = min(abs(crange - hilo_P30(x,1)));
colval(x,:)=floor(((Pcmap(p,:))*255));     
end
for x=1:numpoints30
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_20-30_Map');
for x=1:numpoints30;
    k.point(LatLong30(x,2),LatLong30(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% 0-5 subset
crange=0:(Pmax/63):Pmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_P5_sub(x,1)));
colval(x,:)=floor(((Pcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_0-5_Map_subset');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(Pcmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:Pmax);
cb.TickLabels={'0','1','2','3','4','5','6','7','8','9','>/=10'}
set(get(cb,'label'),'string','ppm orthophosphate (P)');

% Extract ppm Calcium data
% Assign Camax
Camax=100
hilo_Ca5=Camax-Data5(:,10);
hilo_Ca10=Camax-Data10(:,10);
hilo_Ca20=Camax-Data20(:,10);
hilo_Ca30=Camax-Data30(:,10);
hilo_Ca5_sub=Camax-Data10(:,18);

% Assign cmap for Ca
Cacmap=cmap_slateblue;
%0-5
crange=0:(Camax/63):Camax;
for x=1:numpoints5
[d p] = min(abs(crange - hilo_Ca5(x,1)));
colval(x,:)=floor(((Cacmap(p,:))*255));     
end
for x=1:numpoints5
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_0-5_Map');
for x=1:numpoints5;
    k.point(LatLong5(x,2),LatLong5(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10
crange=0:(Camax/63):Camax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_Ca10(x,1)));
colval(x,:)=floor(((Cacmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_5-10_Map');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%10-20
crange=0:(Camax/63):Camax;
for x=1:numpoints20
[d p] = min(abs(crange - hilo_Ca20(x,1)));
colval(x,:)=floor(((Cacmap(p,:))*255));     
end
for x=1:numpoints20
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_10-20_Map');
for x=1:numpoints20;
    k.point(LatLong20(x,2),LatLong20(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%20-30
crange=0:(Camax/63):Camax;
for x=1:numpoints30
[d p] = min(abs(crange - hilo_Ca30(x,1)));
colval(x,:)=floor(((Cacmap(p,:))*255));     
end
for x=1:numpoints30
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_20-30_Map');
for x=1:numpoints30;
    k.point(LatLong30(x,2),LatLong30(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% 0-5 subset
crange=0:(Camax/63):Camax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_Ca5_sub(x,1)));
colval(x,:)=floor(((Cacmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_0-5_Map_subset');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(Cacmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:Camax);
cb.TickLabels={'0','10','20','30','40','50','60','70','80','90','>/=100'}
set(get(cb,'label'),'string','ppm Ca');


% Extract ppm Iron data
% Assign Femax
Femax=80
hilo_Fe5=Femax-Data5(:,11);
hilo_Fe10=Femax-Data10(:,11);
hilo_Fe20=Femax-Data20(:,11);
hilo_Fe30=Femax-Data30(:,11);
hilo_Fe5_sub=Femax-Data10(:,19);

% Assign cmap for Fe
Fecmap=cmap_orange_white;
%0-5
crange=0:(Femax/63):Femax;
for x=1:numpoints5
[d p] = min(abs(crange - hilo_Fe5(x,1)));
colval(x,:)=floor(((Fecmap(p,:))*255));     
end
for x=1:numpoints5
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_0-5_Map');
for x=1:numpoints5;
    k.point(LatLong5(x,2),LatLong5(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10
crange=0:(Femax/63):Femax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_Fe10(x,1)));
colval(x,:)=floor(((Fecmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_5-10_Map');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%10-20
crange=0:(Femax/63):Femax;
for x=1:numpoints20
[d p] = min(abs(crange - hilo_Fe20(x,1)));
colval(x,:)=floor(((Fecmap(p,:))*255));     
end
for x=1:numpoints20
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_10-20_Map');
for x=1:numpoints20;
    k.point(LatLong20(x,2),LatLong20(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%20-30
crange=0:(Femax/63):Femax;
for x=1:numpoints30
[d p] = min(abs(crange - hilo_Fe30(x,1)));
colval(x,:)=floor(((Fecmap(p,:))*255));     
end
for x=1:numpoints30
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_20-30_Map');
for x=1:numpoints30;
    k.point(LatLong30(x,2),LatLong30(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% 0-5 subset
crange=0:(Femax/63):Femax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_Fe5_sub(x,1)));
colval(x,:)=floor(((Fecmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_0-5_Map_subset');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(Fecmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,9);
cb.TickLabels = num2cell(0:Femax);
cb.TickLabels={'0','10','20','30','40','50','60','70','>/=80'}
set(get(cb,'label'),'string','ppm Fe');

% Extract ppm Potassium data
% Assign Kmax
Kmax=100
hilo_K5=Kmax-Data5(:,12);
hilo_K10=Kmax-Data10(:,12);
hilo_K20=Kmax-Data20(:,12);
hilo_K30=Kmax-Data30(:,12);
hilo_K5_sub=Kmax-Data10(:,20);

% Assign cmap for K
Kcmap=cmap_salmon_white;
%0-5
crange=0:(Kmax/63):Kmax;
for x=1:numpoints5
[d p] = min(abs(crange - hilo_K5(x,1)));
colval(x,:)=floor(((Kcmap(p,:))*255));     
end
for x=1:numpoints5
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_0-5_Map');
for x=1:numpoints5;
    k.point(LatLong5(x,2),LatLong5(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10
crange=0:(Kmax/63):Kmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_K10(x,1)));
colval(x,:)=floor(((Kcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_5-10_Map');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%10-20
crange=0:(Kmax/63):Kmax;
for x=1:numpoints20
[d p] = min(abs(crange - hilo_K20(x,1)));
colval(x,:)=floor(((Kcmap(p,:))*255));     
end
for x=1:numpoints20
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_10-20_Map');
for x=1:numpoints20;
    k.point(LatLong20(x,2),LatLong20(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%20-30
crange=0:(Kmax/63):Kmax;
for x=1:numpoints30
[d p] = min(abs(crange - hilo_K30(x,1)));
colval(x,:)=floor(((Kcmap(p,:))*255));     
end
for x=1:numpoints30
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_20-30_Map');
for x=1:numpoints30;
    k.point(LatLong30(x,2),LatLong30(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% 0-5 subset
crange=0:(Kmax/63):Kmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_K5_sub(x,1)));
colval(x,:)=floor(((Kcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_0-5_Map_subset');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(Kcmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:Kmax);
cb.TickLabels={'0','10','20','30','40','50','60','70','80','90','>/=100'}
set(get(cb,'label'),'string','ppm K');

% Extract ppm Magnesium data
% Assign Mgmax
Mgmax=50
hilo_Mg5=Mgmax-Data5(:,13);
hilo_Mg10=Mgmax-Data10(:,13);
hilo_Mg20=Mgmax-Data20(:,13);
hilo_Mg30=Mgmax-Data30(:,13);
hilo_Mg5_sub=Mgmax-Data10(:,21);

% Assign cmap for Mg
Mgcmap=colormap(cmap_pink);
%0-5
crange=0:(Mgmax/63):Mgmax;
for x=1:numpoints5
[d p] = min(abs(crange - hilo_Mg5(x,1)));
colval(x,:)=floor(((Mgcmap(p,:))*255));     
end
for x=1:numpoints5
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Mg_0-5_Map');
for x=1:numpoints5;
    k.point(LatLong5(x,2),LatLong5(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10
crange=0:(Mgmax/63):Mgmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_Mg10(x,1)));
colval(x,:)=floor(((Mgcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Mg_5-10_Map');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%10-20
crange=0:(Mgmax/63):Mgmax;
for x=1:numpoints20
[d p] = min(abs(crange - hilo_Mg20(x,1)));
colval(x,:)=floor(((Mgcmap(p,:))*255));     
end
for x=1:numpoints20
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Mg_10-20_Map');
for x=1:numpoints20;
    k.point(LatLong20(x,2),LatLong20(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%20-30
crange=0:(Mgmax/63):Mgmax;
for x=1:numpoints30
[d p] = min(abs(crange - hilo_Mg30(x,1)));
colval(x,:)=floor(((Mgcmap(p,:))*255));     
end
for x=1:numpoints30
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Mg_20-30_Map');
for x=1:numpoints30;
    k.point(LatLong30(x,2),LatLong30(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% 0-5 subset
crange=0:(Mgmax/63):Mgmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_Mg5_sub(x,1)));
colval(x,:)=floor(((Mgcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Mg_0-5_Map_subset');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(Mgcmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:Mgmax);
cb.TickLabels={'0','5','10','15','20','25','30','35','50','45','>/=50'}
set(get(cb,'label'),'string','ppm Mg');


% Extract ppm Total Kjeldahl nitrogen data
% Assign TKNmax
TKNmax=1500;
hilo_TKN5=TKNmax-Data5(:,14);
hilo_TKN10=TKNmax-Data10(:,14);
hilo_TKN20=TKNmax-Data20(:,14);
hilo_TKN30=TKNmax-Data30(:,14);
hilo_TKN5_sub=TKNmax-Data10(:,22);
% Assign cmap for Total Kjeldahl nitrogen
TKNcmap=cmap_dkgreen_white;

%0-5
crange=0:(TKNmax/63):TKNmax;
for x=1:numpoints5
[d p] = min(abs(crange - hilo_TKN5(x,1)));
colval(x,:)=floor(((TKNcmap(p,:))*255));     
end
for x=1:numpoints5
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('TKN_0-5_Map');
for x=1:numpoints5;
    k.point(LatLong5(x,2),LatLong5(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10
crange=0:(TKNmax/63):TKNmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_TKN10(x,1)));
colval(x,:)=floor(((TKNcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('TKN_5-10_Map');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%10-20
crange=0:(TKNmax/63):TKNmax;
for x=1:numpoints20
[d p] = min(abs(crange - hilo_TKN20(x,1)));
colval(x,:)=floor(((TKNcmap(p,:))*255));     
end
for x=1:numpoints20
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('TKN_10-20_Map');
for x=1:numpoints20;
    k.point(LatLong20(x,2),LatLong20(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%20-30
crange=0:(TKNmax/63):TKNmax;
for x=1:numpoints30
[d p] = min(abs(crange - hilo_TKN30(x,1)));
colval(x,:)=floor(((TKNcmap(p,:))*255));     
end
for x=1:numpoints30
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('TKN_20-30_Map');
for x=1:numpoints30;
    k.point(LatLong30(x,2),LatLong30(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% 0-5 subset
crange=0:(TKNmax/63):TKNmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_TKN5_sub(x,1)));
colval(x,:)=floor(((TKNcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('TKN_0-5_Map_subset');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(TKNcmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:TKNmax);
cb.TickLabels={'0','150','300','450','600','750','900','1050','1200','1450','>/=1500'}
set(get(cb,'label'),'string','ppm Total Kjeldahl nitrogen (TKN)');

% Extract ppm Total nitrogen data
% Assign total N max
Ntmax=1500;
hilo_Nt5=Ntmax-Data5(:,15);
hilo_Nt10=Ntmax-Data10(:,15);
hilo_Nt20=Ntmax-Data20(:,15);
hilo_Nt30=Ntmax-Data30(:,15);
hilo_Nt5_sub=Ntmax-Data10(:,23);
% Assign cmap for Total nitrogen
Ntcmap=cmap_dkgreen_white;

%0-5
crange=0:(Ntmax/63):Ntmax;
for x=1:numpoints5
[d p] = min(abs(crange - hilo_Nt5(x,1)));
colval(x,:)=floor(((Ntcmap(p,:))*255));     
end
for x=1:numpoints5
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Nt_0-5_Map');
for x=1:numpoints5;
    k.point(LatLong5(x,2),LatLong5(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%5-10
crange=0:(Ntmax/63):Ntmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_Nt10(x,1)));
colval(x,:)=floor(((Ntcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Nt_5-10_Map');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%10-20
crange=0:(Ntmax/63):Ntmax;
for x=1:numpoints20
[d p] = min(abs(crange - hilo_Nt20(x,1)));
colval(x,:)=floor(((Ntcmap(p,:))*255));     
end
for x=1:numpoints20
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Nt_10-20_Map');
for x=1:numpoints20;
    k.point(LatLong20(x,2),LatLong20(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
%20-30
crange=0:(Ntmax/63):Ntmax;
for x=1:numpoints30
[d p] = min(abs(crange - hilo_Nt30(x,1)));
colval(x,:)=floor(((Ntcmap(p,:))*255));     
end
for x=1:numpoints30
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Nt_20-30_Map');
for x=1:numpoints30;
    k.point(LatLong30(x,2),LatLong30(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% 0-5 subset
crange=0:(Ntmax/63):Ntmax;
for x=1:numpoints10
[d p] = min(abs(crange - hilo_Nt5_sub(x,1)));
colval(x,:)=floor(((Ntcmap(p,:))*255));     
end
for x=1:numpoints10
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Nt_0-5_Map_subset');
for x=1:numpoints10;
    k.point(LatLong10(x,2),LatLong10(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(Ntcmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:Ntmax);
cb.TickLabels={'0','150','300','450','600','750','900','1050','1200','1450','>/=1500'}
set(get(cb,'label'),'string','ppm Total N');

% Plot probe and gravimetric moisture data 
% Load data
m_Data= xlsread('moisture_Data.xlsx');
LatLongm=m_Data(:,1:2);
numpoints=72;
% Assign moisture max
moisturemax=1
hilo_probe_m=moisturemax-m_Data(:,4)

% Assign colormap for moisture
mcmap=cmap;

% probe plot
crange=0:(moisturemax/63):moisturemax;
for x=1:numpoints
[d p] = min(abs(crange - hilo_probe_m(x,1)));
colval(x,:)=floor(((mcmap(p,:))*255));     
end
for x=1:numpoints
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('probe_moisture_Map');
for x=1:numpoints;
    k.point(LatLongm(x,2),LatLongm(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(mcmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:moisturemax);
cb.TickLabels={'0','10','20','30','40','50','60','70','80','90','100',}
set(get(cb,'label'),'string','Probe Moisture %');

% extract gravimetric moisture data
hilo_m5=moisturemax-m_Data(:,17);
hilo_m10=moisturemax-m_Data(:,18);
hilo_m20=moisturemax-m_Data(:,19);
hilo_m30=moisturemax-m_Data(:,20);

%0-5 grav moisture plot
crange=0:(moisturemax/63):moisturemax;
for x=1:numpoints
[d p] = min(abs(crange - hilo_m5(x,1)));
colval(x,:)=floor(((mcmap(p,:))*255));     
end
for x=1:numpoints
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('0-5_grav_m_Map');
for x=1:numpoints;
    k.point(LatLongm(x,2),LatLongm(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run

%5-10 grav moisture plot
crange=0:(moisturemax/63):moisturemax;
for x=1:numpoints
[d p] = min(abs(crange - hilo_m10(x,1)));
colval(x,:)=floor(((mcmap(p,:))*255));     
end
for x=1:numpoints
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('5-10_grav_m_Map');
for x=1:numpoints;
    k.point(LatLongm(x,2),LatLongm(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run

%10-20 grav moisture plot
crange=0:(moisturemax/63):moisturemax;
for x=1:numpoints
[d p] = min(abs(crange - hilo_m20(x,1)));
colval(x,:)=floor(((mcmap(p,:))*255));     
end
for x=1:numpoints
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('10-20_grav_m_Map');
for x=1:numpoints;
    k.point(LatLongm(x,2),LatLongm(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run


%20-30 grav moisture plot
crange=0:(moisturemax/63):moisturemax;
for x=1:numpoints
[d p] = min(abs(crange - hilo_m30(x,1)));
colval(x,:)=floor(((mcmap(p,:))*255));     
end
for x=1:numpoints
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('20-30_grav_m_Map');
for x=1:numpoints;
    k.point(LatLongm(x,2),LatLongm(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
    hold on   
end
k.run

% Create colorbar for legend
clear colorbar
revcmap=flipud(mcmap);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:moisturemax);
cb.TickLabels={'0','10','20','30','40','50','60','70','80','90','100',}
set(get(cb,'label'),'string','Gravimetric Water Content %');
