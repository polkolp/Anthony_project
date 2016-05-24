%%%Based on unwrap_code.m, modified by Tianyi Yang on 5/23/2016
%How to use the function
%1. Use unwrapcenter.m to find the central line of phase map for all four
%measurements
%2. Replace the four numbers in the center vector with measured central
%line position in step 1.
%3. Change foldername and dir.
%4. Use unwrapcheck,m to make sure the phase are correctly unwrapped.
dir = 'E:\Work\Surmet 2016 AJY\Radial Samples 2_5_16\';
detectposition = {'top\' 'left\' 'bottom\' 'right\'};
foldername = 'GR16\';
center = [450, 500, 550, 500]; %center row for unwrapping. unwrapping will be performed in between center +/- 20 pixels
for i = 1:4
    load([dir, foldername, char(detectposition(i)), 'out_wrapped.mat']);


    figure(102);clf;imagesc(phase/(2*pi));title(['Transmitted Wavefront (waves at ' num2str(.63282) '{\mu}m)']);colorbar;axis equal;drawnow


    % rowmin = min(max(str2double(get(handles.rowplotmin,'String')),1),max(str2double(get(handles.rowplotmax,'String')),1));
    % rowmax = max(min(str2double(get(handles.rowplotmax,'String')),handles.vidRes(2)),min(str2double(get(handles.rowplotmin,'String')),handles.vidRes(2)));
    % colmin = min(max(str2double(get(handles.columnplotmin,'String')),1),max(str2double(get(handles.columnplotmax,'String')),1));
    % colmax = max(min(str2double(get(handles.columnplotmax,'String')),handles.vidRes(1)),min(str2double(get(handles.columnplotmin,'String')),handles.vidRes(1)));
    %%
    rowmin = center(i)-20;
    % rowmax = 512; % FLIR Camera
    rowmax = center(i)+20; % Sofradir Camera
    colmin = 1;
    colmax = 1280;

    rowmax = max(rowmax,rowmin+1);colmax = max(colmax,colmin+1);
    phasetemp = phase(rowmin:rowmax,colmin:colmax);
    figure(101);clf; 
    [phase_unwraptemp,~,~] = puma_ho(phasetemp,2);
    phase_unwrap = NaN(size(phase));
    phase_unwrap(rowmin:rowmax,colmin:colmax) = phase_unwraptemp;
    % if (rowmax-rowmin) > (colmax-colmin)
    %     figure(103);clf;plot(phase_unwrap(:,round(.5*(colmin+colmax)))/(2*pi));xlabel('Pixel');ylabel('phase (waves)');title(['Unwrapped phase of column ' num2str(round(.5*(colmin+colmax)))])
    % else
    %     figure(103);clf;plot(phase_unwrap(round(.5*(rowmin+rowmax)),:)/(2*pi));xlabel('Pixel');ylabel('phase (waves)');title(['Unwrapped phase of row ' num2str(round(.5*(rowmin+rowmax)))])
    % end

    drawnow
    filename = [foldername, char(detectposition(i)), 'out_unwrapped.mat'];
    fullFileName = fullfile(dir,filename);
    save(fullFileName,'phase_unwrap')
end