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
Nmax=1
hilo_N5=Nmax-Data5(:,8);
hilo_N10=Nmax-Data10(:,8);
hilo_N10_5=Nmax-Data10(:,16);
hilo_N20=Nmax-Data20(:,8);
hilo_N20_5=Nmax-Data20(:,16);
hilo_N30=Nmax-Data30(:,8);
hilo_N30_5=Nmax-Data30(:,16);

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
Mgmax=100
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











% GOOGLE EARTH PLOTS of SOIL MOISTURE at TIDMARSH
% Load in nutrient data
Data0_5= xlsread('0-5_data.xlsx');
Data5_10= xlsread('5-10_data.xlsx');
Data10_20= xlsread('10-20_data.xlsx');
Data20_30= xlsread('20-30_data.xlsx');
% Load in lat long data
LatLong05=Data0_5(:,2:3);
LatLong510=Data5_10(:,10:11);
LatLong1020=Data10_20(:,10:11);
LatLong2030=Data20_30(:,10:11);
% Record number of points data points for each depth in soil profile
numpoints05=length(Data0_5(:,1));
numpoints510=length(Data5_10(:,1));
numpoints1020=length(Data10_20(:,1));
numpoints2030=length(Data20_30(:,1));
GES05=zeros(1,numpoints05);
GES510=zeros(1,numpoints510);
GES1020=zeros(1,numpoints1020);
GES2030=zeros(1,numpoints2030);
x=1;
% Extract ppm P data
% Assign P max
Pmax=10;
P05=Data0_5(:,5);
hi_lo_P05=Pmax-P05;
P510=Data5_10(:,3);
hi_lo_P510=Pmax-P510;
P510_05=Pmax-Data5_10(:,12);
hi_lo_P510_05=Pmax-P510_05;
P1020=Data10_20(:,3);
hi_lo_P1020=Pmax-P1020;
P2030=Data20_30(:,3);
hi_lo_P2030=Pmax-P2030;
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_P05(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_P510(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
Data5_10(:,12)
P510_05
P510_05=Data5_10(:,12);
hi_lo_P510_05=Pmax-P510_05;
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_P510_05(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_510_05_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_P1020(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_1020_GEMap');
for x=1:numpoints510;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
P1020_05=Data10_20(:,12);
hi_lo_P1020_05=Pmax-P1020_05;
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_P1020_05(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_1020_05_GEMap');
for x=1:numpoints510;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_P1020_05(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_1020_05_GEMap');
for x=1:numpoints1020;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_P2030(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_2030_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
P2030_05=Data20_30(:,12);
hi_lo_P2030_05=Pmax-P2030_05;
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_P2030_5(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_2030_05_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_P2030_05(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_2030_05_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract ppm Ca data
% Assign Ca max
Camax=190;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-P05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-P510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-P510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-P1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-P1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-P2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-P2030_05;
% Assign cmap for P
cmapP=cmap_burgundy_white;
cmapCa=colormap('bone');
cmapCa
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
colorbar(Cacmap)
colorbar
% Assign Ca max
Camax=100;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-P05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-P510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-P510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-P1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-P1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-P2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-P2030_05;
% Assign cmap for P
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for Ca
cmapCa=cmap_blue_white;
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract ppm Ca data
% Assign Ca max
Camax=80;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-P05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-P510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-P510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-P1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-P1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-P2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-P2030_05;
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract Ca data
% Extract ppm Ca data
% Assign Ca max
Camax=20;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-P05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-P510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-P510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-P1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-P1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-P2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-P2030_05;
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract Ca data
% Extract ppm Ca data
% Assign Ca max
Camax=60;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-P05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-P510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-P510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-P1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-P1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-P2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-P2030_05;
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
cmap=colormap('bone')
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
% Extract Ca data
% Extract ppm Ca data
% Assign Ca max
Camax=30;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-P05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-P510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-P510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-P1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-P1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-P2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-P2030_05;
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_PCa10(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Ca10(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Ca510(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract ppm Ca data
% Assign Ca max
Camax=100;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-Ca05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-Ca510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-Ca510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-Ca1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-Ca1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-Ca2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-Ca2030_05;
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract Ca data
% Extract ppm Ca data
% Assign Ca max
Camax=150;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-Ca05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-Ca510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-Ca510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-Ca1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-Ca1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-Ca2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-Ca2030_05;
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign Ca max
Camax=190;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-Ca05;
Ca510=Data5_10(:,4);
hi_lo_P510=Camax-Ca510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-Ca510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-Ca1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-Ca1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-Ca2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-Ca2030_05;
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for Ca
cmapCa=colormap('bone');
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract ppm P data
% Assign P max
Femax=80;
Fe05=Data0_5(:,7);
hi_lo_Fe05=Femax-Fe05;
Fe510=Data5_10(:,5);
hi_lo_Fe510=Femax-Fe510;
Fe510_05=Data5_10(:,14);
hi_lo_P510_05=Femax-Fe510_05;
Fe1020=Data10_20(:,5);
hi_lo_Fe1020=Femax-Fe1020;
Fe1020_05=Data10_20(:,14);
hi_lo_Fe1020_05=Femax-Fe1020_05;
Fe2030=Data20_30(:,5);
hi_lo_Fe2030=Femax-Fe2030;
Fe2030_05=Data20_30(:,14);
hi_lo_Fe2030_05=Femax-Fe2030_05;
% Assign cmap for P
cmapFe=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Fe05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapFe=colormap('bone');
crange=0:(Pmax/63):Pmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Fe05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapFe=colormap_orange_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Fe05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapFe=cmap_orange_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Fe05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract ppm P data
% Assign P max
Femax=50;
Fe05=Data0_5(:,7);
hi_lo_Fe05=Femax-Fe05;
Fe510=Data5_10(:,5);
hi_lo_Fe510=Femax-Fe510;
Fe510_05=Data5_10(:,14);
hi_lo_P510_05=Femax-Fe510_05;
Fe1020=Data10_20(:,5);
hi_lo_Fe1020=Femax-Fe1020;
Fe1020_05=Data10_20(:,14);
hi_lo_Fe1020_05=Femax-Fe1020_05;
Fe2030=Data20_30(:,5);
hi_lo_Fe2030=Femax-Fe2030;
Fe2030_05=Data20_30(:,14);
hi_lo_Fe2030_05=Femax-Fe2030_05;
% Assign cmap for P
cmapFe=cmap_orange_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Fe05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract ppm P data
% Assign P max
Femax=80;
Fe05=Data0_5(:,7);
hi_lo_Fe05=Femax-Fe05;
Fe510=Data5_10(:,5);
hi_lo_Fe510=Femax-Fe510;
Fe510_05=Data5_10(:,14);
hi_lo_P510_05=Femax-Fe510_05;
Fe1020=Data10_20(:,5);
hi_lo_Fe1020=Femax-Fe1020;
Fe1020_05=Data10_20(:,14);
hi_lo_Fe1020_05=Femax-Fe1020_05;
Fe2030=Data20_30(:,5);
hi_lo_Fe2030=Femax-Fe2030;
Fe2030_05=Data20_30(:,14);
hi_lo_Fe2030_05=Femax-Fe2030_05;
% Assign cmap for P
cmapFe=cmap_orange_white;
crange=0:(Femax/63):Femax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Fe05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Femax/63):Femax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Fe510(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapFe=cmap_orange_white;
crange=0:(Femax/63):Femax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Fe510(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Femax/63):Femax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Fe510(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Femax/63):Femax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Fe510_05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_510_05_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
hi_lo_Fe510_05=Femax-Fe510_05;
Fe1020=Data10_20(:,5);
crange=0:(Femax/63):Femax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Fe510_05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_510_05_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Femax/63):Femax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_Fe1020(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_1020_GEMap');
for x=1:numpoints510;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Femax/63):Femax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_Fe1020_05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_1020_05_GEMap');
for x=1:numpoints1020;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Femax/63):Femax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_Fe2030(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_2030_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Femax/63):Femax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_Fe2030_05(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_2030_05_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(cmapFe);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,8);
cb.TickLabels = num2cell(0:Femax);
cb.TickLabels={'0','10','20','30','40','50','60','70','>=80'}
set(get(cb,'label'),'string','ppm Fe');
% Create colorbar for legend
clear colorbar
revcmap=flipud(cmapFe);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,9);
cb.TickLabels = num2cell(0:Femax);
cb.TickLabels={'0','10','20','30','40','50','60','70','>=80'}
set(get(cb,'label'),'string','ppm Fe');
% Extract Ca data
% Extract ppm Ca data
% Assign Ca max
Camax=100;
Ca05=Data0_5(:,6);
hi_lo_Ca05=Camax-Ca05;
Ca510=Data5_10(:,4);
hi_lo_Ca510=Camax-Ca510;
Ca510_05=Data5_10(:,13);
hi_lo_Ca510_05=Camax-Ca510_05;
Ca1020=Data10_20(:,4);
hi_lo_Ca1020=Camax-Ca1020;
Ca1020_05=Data10_20(:,13);
hi_lo_Ca1020_05=Camax-Ca1020_05;
Ca2030=Data20_30(:,4);
hi_lo_Ca2030=Camax-Ca2030;
Ca2030_05=Data20_30(:,13);
hi_lo_Ca2030_05=Camax-Ca2030_05;
% Assign cmap for Ca
cmapCa=cmap_blue_white;
crange=0:(Camax/63):Camax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Ca05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Camax/63):Camax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Ca510(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Camax/63):Camax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_Ca510_05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_510_05_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Camax/63):Camax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_Ca1020(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_1020_GEMap');
for x=1:numpoints510;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Camax/63):Camax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_Ca1020_05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_1020_05_GEMap');
for x=1:numpoints1020;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Camax/63):Camax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_Ca2030(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_2030_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Camax/63):Camax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_Ca2030_05(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_2030_05_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(cmapCa);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:Femax);
cb.TickLabels={'0','10','20','30','40','50','60','70','80','90','>=100'}
set(get(cb,'label'),'string','ppm Ca');
% Extract ppm K data
% Assign K max
Kmax=100;
K05=Data0_5(:,8);
hi_lo_K05=Kmax-K05;
K510=Data5_10(:,6);
hi_lo_K510=Kmax-K510;
K510_05=Data5_10(:,14);
hi_lo_K510_05=Kmax-K510_05;
K1020=Data10_20(:,6);
hi_lo_K1020=Kmax-K1020;
K1020_05=Data10_20(:,14);
hi_lo_K1020_05=Kmax-K1020_05;
K2030=Data20_30(:,6);
hi_lo_K2030=Kmax-K2030;
K2030_05=Data20_30(:,14);
hi_lo_K2030_05=Kmax-K2030_05;
% Assign cmap for K
cmapK=cmap_salmon_white;
crange=0:(Kmax/63):Kmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_K05(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Kmax/63):Kmax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_K510(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_510_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Kmax/63):Kmax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_K510_05(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_510_05_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Extract ppm K data
% Assign K max
Kmax=100;
K05=Data0_5(:,8);
hi_lo_K05=Kmax-K05;
K510=Data5_10(:,6);
hi_lo_K510=Kmax-K510;
K510_05=Data5_10(:,14);
hi_lo_K510_05=Kmax-K510_05;
K1020=Data10_20(:,6);
hi_lo_K1020=Kmax-K1020;
K1020_05=Data10_20(:,14);
hi_lo_K1020_05=Kmax-K1020_05;
K2030=Data20_30(:,6);
hi_lo_K2030=Kmax-K2030;
K2030_05=Data20_30(:,14);
hi_lo_K2030_05=Kmax-K2030_05;
% Assign cmap for K
cmapK=cmap_salmon_white;
crange=0:(Kmax/63):Kmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_K05(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
K05=Data0_5(:,8);
hi_lo_K05=Kmax-K05;
K510=Data5_10(:,6);
hi_lo_K510=Kmax-K510;
K510_05=Data5_10(:,15);
hi_lo_K510_05=Kmax-K510_05;
K1020=Data10_20(:,6);
hi_lo_K1020=Kmax-K1020;
K1020_05=Data10_20(:,15);
hi_lo_K1020_05=Kmax-K1020_05;
K2030=Data20_30(:,6);
hi_lo_K2030=Kmax-K2030;
K2030_05=Data20_30(:,15);
hi_lo_K2030_05=Kmax-K2030_05;
crange=0:(Kmax/63):Kmax;
for x=1:numpoints510
[d p] = min(abs(crange - hi_lo_K510_05(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints510
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_510_05_GEMap');
for x=1:numpoints510;
k.point(LatLong510(x,2),LatLong510(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Femax/63):Femax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_Fe1020(x,1)));
colval(x,:)=floor(((cmapFe(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Fe_1020_GEMap');
for x=1:numpoints1020;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Camax/63):Camax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_Ca1020(x,1)));
colval(x,:)=floor(((cmapCa(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Ca_1020_GEMap');
for x=1:numpoints1020;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Assign cmap for P
cmapP=cmap_burgundy_white;
crange=0:(Pmax/63):Pmax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_P1020(x,1)));
colval(x,:)=floor(((cmapP(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('P_1020_GEMap');
for x=1:numpoints1020;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Kmax/63):Kmax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_K1020(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_1020_GEMap');
for x=1:numpoints1020;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Kmax/63):Kmax;
for x=1:numpoints1020
[d p] = min(abs(crange - hi_lo_K1020_05(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints1020
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_1020_05_GEMap');
for x=1:numpoints1020;
k.point(LatLong1020(x,2),LatLong1020(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Kmax/63):Kmax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_K2030(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_2030_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
crange=0:(Kmax/63):Kmax;
for x=1:numpoints2030
[d p] = min(abs(crange - hi_lo_K2030_05(x,1)));
colval(x,:)=floor(((cmapK(p,:))*255));
end
for x=1:numpoints2030
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('K_2030_05_GEMap');
for x=1:numpoints2030;
k.point(LatLong2030(x,2),LatLong2030(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run
% Create colorbar for legend
clear colorbar
revcmap=flipud(cmapK);
colormap(revcmap);
cb=colorbar;
cb.Ticks=linspace(0,1,11);
cb.TickLabels = num2cell(0:Kmax);
cb.TickLabels={'0','10','20','30','40','50','60','70','80','90','>=100'}
set(get(cb,'label'),'string','ppm K');
% Extract ppm Mg data


% Assign Mg max
Mgmax=100;
Mg05=Data0_5(:,9);
hi_lo_Mg05=Mgmax-Mg05;
Mg510=Data5_10(:,7);
hi_lo_Mg510=Mgmax-Mg510;
Mg510_05=Data5_10(:,16);
hi_lo_Mg510_05=Mgmax-Mg510_05;
Mg1020=Data10_20(:,7);
hi_lo_Mg1020=Mgmax-Mg1020;
Mg1020_05=Data10_20(:,16);
hi_lo_Mg1020_05=Mgmax-Mg1020_05;
Mg2030=Data20_30(:,7);
hi_lo_Mg2030=Mgmax-Mg2030;
Mg2030_05=Data20_30(:,16);
hi_lo_Mg2030_05=Mgmax-Mg2030_05;

% Assign cmap for Mg
cmapMg=cmap_purple_white;
crange=0:(Mgmax/63):Mgmax;
for x=1:numpoints05
[d p] = min(abs(crange - hi_lo_Mg05(x,1)));
colval(x,:)=floor(((cmapMg(p,:))*255));
end
for x=1:numpoints05
RGB=dec2hex(colval(x,:));
RR=RGB(1,:);
GG=RGB(2,:);
BB=RGB(3,:);
GE_DTScolour{x,1}=['ff',BB,GG,RR];
end
x=1;
k = kml('Mg_05_GEMap');
for x=1:numpoints05;
k.point(LatLong05(x,2),LatLong05(x,1),0,'name', ' ', 'iconColor',GE_DTScolour{x,1},'iconScale', 0.5);%IRGPS(x,9),IRGPS(x,10));
hold on
end
k.run





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
