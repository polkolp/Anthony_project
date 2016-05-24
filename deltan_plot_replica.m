%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Originally coded by Anthony Yee, Edited by Tianyi Yang on 5/20.2016
%How to use the program
%1. Change foldername to your working folder.
%2. Fill in the value of central thickness for the variable t.
clear; clc; close all;
%%
% dir = '\\MOORE-GGN437\M-GRIN Docs\Surmet 2016 AJY\Radial Samples 2_5_16'
dir = 'E:\Work\Surmet 2016 AJY\Radial Samples 2_5_16\';
foldername = 'GR5\'
load([dir, foldername, 'Top\out_unwrapped.mat']);
top = phase_unwrap;
load([dir, foldername, 'Left\out_unwrapped.mat']);
left = phase_unwrap;
load([dir, foldername, 'Bottom\out_unwrapped.mat']);
bottom = phase_unwrap;
load([dir, foldername, 'Right\out_unwrapped.mat']);
right = phase_unwrap;

wl = 632.82 * 10^(-6); %(wavelength in mm)
t = 1.031; %(Thickness in mm)

% figure();hold on; plot(left(600,13:1280),'r');plot(right(600,5:1280),'c');hold off



figure(100);clf;hold on; 


% Converting from unwrapped phase to change in index
nonzerophase = find(top(:,1) >= 0);
central = fix(mean(nonzerophase)); %calculate the central line of the unwrapped phase as a baseline
range = 28:1280;
top1=wl.*top(central,range)./(2.*pi.*t);
length1 = (1:length(range))/71;

nonzerophase = find(bottom(:,1) >= 0);
central = fix(mean(nonzerophase));
range = 1:1280;
bottom1=wl.*bottom(central,range)./(2.*pi.*t);
length2 = (1:length(range))/71;

nonzerophase = find(right(:,1) >= 0);
central = fix(mean(nonzerophase));
range = 5:1280;
right1=wl.*right(central,range)./(2.*pi.*t);
length3 = (1:length(range))/71;

nonzerophase = find(left(:,1) >= 0);
central = fix(mean(nonzerophase));
range = 9:1280;
left1=wl.*left(central,range)./(2.*pi.*t);
length4 = (1:length(range))/71;

plot(length1,top1-max(top1),'r');
plot(length2,bottom1-max(bottom1),'k');
plot(length3,right1-max(right1),'c');
plot(length4,left1-max(left1),'g');
legend('Top','Bottom','Right','Left');


ylabel('\Deltan')
xlabel('[mm]')
filename = [foldername, 'Deltan.jpg'];
fullFileName = fullfile(dir,filename);
saveas(gca, fullFileName, 'jpeg');

% n = 1.78403;
% dnr=wl.*(1.045-1.031).*n./(2.*pi.*1.045)
% dnl=wl.*(1.016-1.031).*n./(2.*pi.*1.016)