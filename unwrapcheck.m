%% Quick check if unwrapping is performed on the center
% 0. Created by Tianyi Yang on 5/20/2016
% 1. change dir to your working directory.
% 2. change the number in 'GRX\' to the folder that you want to visit.
% 3. If the designated folder does not contain out_wrapped.mat or
% out_unwrapped.mat, an error will occur.


% dir = '\\MOORE-GGN437\M-GRIN Docs\Surmet 2016 AJY\Radial Samples 2_5_16'
dir = 'E:\Work\Surmet 2016 AJY\Radial Samples 2_5_16\';
foldername = 'GR16\'
detectposition = {'Top' 'Left' 'Bottom' 'Right'};

for i = 1:4
    load([dir, foldername, char(detectposition(i)), '\out_wrapped.mat']);
    wrapped = phase;
    load([dir, foldername,char(detectposition(i)),'\out_unwrapped.mat']);
    unwrapped = phase_unwrap;
    figure;
    subplot(1,2,1);
    imagesc(wrapped);
    subplot(1,2,2);
    imagesc(unwrapped);
    pause;
    close all;
end
