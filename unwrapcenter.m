%Created by Tianyi Yang on 5/23/2016
%This program is designed to estimate the central line for phase unwrapping

% dir = '\\MOORE-GGN437\M-GRIN Docs\Surmet 2016 AJY\Radial Samples 2_5_16'
dir = 'E:\Work\Surmet 2016 AJY\Radial Samples 2_5_16\';
foldername = 'GR16\';
detectposition = {'Top' 'Left' 'Bottom' 'Right'};

for i = 1:4
    load([dir, foldername, char(detectposition(i)), '\out_wrapped.mat']);
    wrapped = phase;
    figure;
    subplot(1,2,1);
    imagesc(wrapped);
    subplot(1,2,2);
    plot(wrapped(:,1))
    pause;
    close all;
end