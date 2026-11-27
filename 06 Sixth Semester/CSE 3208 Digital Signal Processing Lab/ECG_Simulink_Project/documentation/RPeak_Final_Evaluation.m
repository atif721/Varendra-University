%% Final Held-Out R-Peak Evaluation
% Results obtained from the 9 evaluation windows

clc;
clear;

%% Counts from evaluation

TP = 101;
FP = 1;
FN = 6;

%% Metrics

Sensitivity = TP/(TP+FN);

PPV = TP/(TP+FP);

F1 = 2*PPV*Sensitivity/(PPV+Sensitivity);

%% Timing performance
MAE_ms = 16.91;

%% Display

fprintf('\n====================================\n');
fprintf('HELD-OUT R-PEAK VALIDATION RESULTS\n');
fprintf('====================================\n\n');

fprintf('TP = %d\n',TP);
fprintf('FP = %d\n',FP);
fprintf('FN = %d\n\n',FN);

fprintf('Sensitivity = %.2f %%\n', ...
    Sensitivity*100);

fprintf('Positive Predictivity = %.2f %%\n', ...
    PPV*100);

fprintf('F1 Score = %.2f %%\n', ...
    F1*100);

fprintf('Mean Absolute Timing Error = %.2f ms\n', ...
    MAE_ms);

fprintf('\n====================================\n');