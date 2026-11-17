%% Publication Figure 6
% PVC Detection Example - MIT-BIH Record 119
% Segment: 20-30 s

close all;

%% ---------------------------------------------------------
% 1. Get filtered ECG from Simulink log
% ----------------------------------------------------------

filt119 = out.filtered_ecg_log;

ecg119_filt = squeeze(filt119.signals.values);
ecg119_filt = ecg119_filt(:);

t119_filt = filt119.time(:);


%% ---------------------------------------------------------
% 2. Get detected PVC events
% ----------------------------------------------------------

pvc119log = out.pvc_detect_log;

det119 = double(pvc119log.signals.values(:));

detEdge119 = [false; diff(det119) > 0];

detTimes119 = pvc119log.time(detEdge119);


%% ---------------------------------------------------------
% 3. Get reference PVC events
% ----------------------------------------------------------

ref119log = out.ref_pvc_log;

ref119 = double(ref119log.signals.values(:));

refEdge119 = [false; diff(ref119) > 0];

refTimes119 = ref119log.time(refEdge119);

% Remove duplicate reference events occurring
% within 10 ms of each other
refTimes119 = ...
    refTimes119([true; diff(refTimes119) > 0.01]);


%% ---------------------------------------------------------
% 4. Localize reference markers to visible ECG peaks
% ----------------------------------------------------------

searchSamples = round(0.10 * Fs119);  % +/-100 ms

ref_t_plot = zeros(size(refTimes119));
ref_amp    = zeros(size(refTimes119));

for k = 1:length(refTimes119)

    % Find ECG sample closest to reference event
    [~,center] = min( ...
        abs(t119_filt - refTimes119(k)));

    leftIndex = max( ...
        1, ...
        center - searchSamples);

    rightIndex = min( ...
        length(ecg119_filt), ...
        center + searchSamples);

    % Find local ECG maximum
    [ref_amp(k),localIndex] = ...
        max(ecg119_filt(leftIndex:rightIndex));

    peakIndex = ...
        leftIndex + localIndex - 1;

    ref_t_plot(k) = ...
        t119_filt(peakIndex);

end


%% ---------------------------------------------------------
% 5. Localize detector markers to visible ECG peaks
% ----------------------------------------------------------

det_t_plot = zeros(size(detTimes119));
det_amp    = zeros(size(detTimes119));

for k = 1:length(detTimes119)

    [~,center] = min( ...
        abs(t119_filt - detTimes119(k)));

    leftIndex = max( ...
        1, ...
        center - searchSamples);

    rightIndex = min( ...
        length(ecg119_filt), ...
        center + searchSamples);

    [det_amp(k),localIndex] = ...
        max(ecg119_filt(leftIndex:rightIndex));

    peakIndex = ...
        leftIndex + localIndex - 1;

    det_t_plot(k) = ...
        t119_filt(peakIndex);

end


%% ---------------------------------------------------------
% 6. Create publication figure
% ----------------------------------------------------------

fig6 = figure( ...
    'Color','w', ...
    'Position',[100 100 1100 520]);

% ECG
plot( ...
    t119_filt, ...
    ecg119_filt, ...
    'b', ...
    'LineWidth',0.9);

hold on;


%% Reference PVC markers

plot( ...
    ref_t_plot, ...
    ref_amp, ...
    'ko', ...
    'MarkerSize',9, ...
    'LineWidth',1.5);


%% Detected PVC markers

plot( ...
    det_t_plot, ...
    det_amp, ...
    'rx', ...
    'MarkerSize',10, ...
    'LineWidth',1.8);


%% ---------------------------------------------------------
% 7. Axis formatting
% ----------------------------------------------------------

grid on;
box on;

xlim([0 10]);

xlabel( ...
    'Time (s)', ...
    'FontName','Times New Roman', ...
    'FontSize',11);

ylabel( ...
    'Amplitude (mV)', ...
    'FontName','Times New Roman', ...
    'FontSize',11);

set( ...
    gca, ...
    'FontName','Times New Roman', ...
    'FontSize',11, ...
    'LineWidth',0.8);


%% ---------------------------------------------------------
% 8. Legend
% IMPORTANT FIX:
% legend is outside the ECG plotting area
% ----------------------------------------------------------

lgd = legend( ...
    'Preprocessed ECG', ...
    'Reference PVC', ...
    'Detected PVC', ...
    'Location','southoutside', ...
    'Orientation','horizontal');

set( ...
    lgd, ...
    'FontName','Times New Roman', ...
    'FontSize',10, ...
    'Box','off');


%% ---------------------------------------------------------
% 9. Improve plot spacing
% ----------------------------------------------------------

% Leave additional room for legend below
ax = gca;

ax.Position = ...
    [0.09 0.18 0.87 0.76];


%% ---------------------------------------------------------
% 10. Export at publication quality
% ----------------------------------------------------------

RESULTS_ROOT = ...
['X:\Study\University\Varendra-University\06 Sixth Semester\' ...
 'CSE 3208 Digital Signal Processing Lab\' ...
 'ECG_Simulink_Project\results'];

outputFile6 = fullfile( ...
    RESULTS_ROOT, ...
    '06_PVC_Detection', ...
    'Fig06_PVC_Detection_Record119.png');

print( ...
    fig6, ...
    outputFile6, ...
    '-dpng', ...
    '-r300');

fprintf('\nFigure 6 saved:\n%s\n', ...
    outputFile6);