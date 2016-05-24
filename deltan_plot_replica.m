%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Originally coded by Anthony Yee, Edited by Tianyi Yang on 5/20.2016
%How to use the program
%1. Change foldername to your working folder.
%2. Fill in the value of central thickness for the variable t.
clear; clc; close all;
%%
% dir = '\\MOORE-GGN437\M-GRIN Docs\Surmet 2016 AJY\Radial Samples 2_5_16'
dir = 'F:\Radial Samples 2_5_16\';
foldername = 'GR4\'
load([dir, foldername, 'Top\out_unwrapped.mat']);
top = phase_unwrap;
load([dir, foldername, 'Left\out_unwrapped.mat']);
left = phase_unwrap;
load([dir, foldername, 'Bottom\out_unwrapped.mat']);
bottom = phase_unwrap;
load([dir, foldername, 'Right\out_unwrapped.mat']);
right = phase_unwrap;

wl = 632.82 * 10^(-6); %(wavelength in mm)


% figure();hold on; plot(left(600,13:1280),'r');plot(right(600,5:1280),'c');hold off



figure(100);clf;hold on; 
% Converting from unwrapped phase to change in index
Top = 1.017;
Right = 0.991;
Bottom = 1.021;
Left = 1.045;
Center = 1.019;

nonzerophase = find(top(:,1) >= 0);
central = fix(mean(nonzerophase)); %calculate the central line of the unwrapped phase as a baseline
range = 2:1220;
tt = linspace(Center, Top, range(end)-range(1)+1);
top1=wl.*top(central,range)./(2.*pi.*tt);
length1 = (1:length(range))/71;

nonzerophase = find(bottom(:,1) >= 0);
central = fix(mean(nonzerophase));
range = 3:1220;
tb = linspace(Center, Bottom, range(end)-range(1)+1);
bottom1=wl.*bottom(central,range)./(2.*pi.*tb);
length2 = (1:length(range))/71;

nonzerophase = find(right(:,1) >= 0);
central = fix(mean(nonzerophase));
range = 7:1220;
tr = linspace(Center, Right, range(end)-range(1)+1);
right1=wl.*right(central,range)./(2.*pi.*tr);
length3 = (1:length(range))/71;

nonzerophase = find(left(:,1) >= 0);
central = fix(mean(nonzerophase));
range = 1:1220;
tl = linspace(Center, Left, range(end)-range(1)+1);
left1=wl.*left(central,range)./(2.*pi.*tl);
length4 = (1:length(range))/71;

% plot(top1-max(top1),'r');
% plot(bottom1-max(bottom1),'k');
% plot(right1-max(right1),'c');
% plot(left1-max(left1),'g');
% legend('Top','Bottom','Right','Left');
zerotop = top1-top1(100);
zerobottom = bottom1-bottom1(100);
zeroright = right1-right1(100);
zeroleft = left1-left1(100);

plot(length1,top1-top1(100),'r');
plot(length2,bottom1-bottom1(100),'k');
plot(length3,right1-right1(100),'c');
plot(length4,left1-left1(100),'g');
legend('Top','Bottom','Right','Left');

filename = [dir, 'deltan_global4.xlsx'];
T = table(length1');
writetable(T,filename,'Sheet',1,'Range','A1');
T = table(length2');
writetable(T,filename,'Sheet',1,'Range','B1');
T = table(length3');
writetable(T,filename,'Sheet',1,'Range','C1');
T = table(length4');
writetable(T,filename,'Sheet',1,'Range','D1');

T = table(zerotop');
writetable(T,filename,'Sheet',2,'Range','A1');
T = table(zerobottom');
writetable(T,filename,'Sheet',2,'Range','B1');
T = table(zeroright');
writetable(T,filename,'Sheet',2,'Range','C1');
T = table(zeroleft');
writetable(T,filename,'Sheet',2,'Range','D1');

ylabel('\Deltan')
xlabel('[mm]')
filename = [foldername, 'Deltan.jpg'];
fullFileName = fullfile(dir,filename);
saveas(gca, fullFileName, 'jpeg');

% n = 1.78403;
% dnr=wl.*(1.045-1.031).*n./(2.*pi.*1.045)
% dnl=wl.*(1.016-1.031).*n./(2.*pi.*1.016)
