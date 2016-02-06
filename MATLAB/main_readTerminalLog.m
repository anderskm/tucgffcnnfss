clear all;
close all;

logFile = '../../../code/caffe/models/fcn_32_pascal_contex/TrainingLogtBrain.log';

fid = fopen(logFile);



% pattern = '.+Iteration: \d';
pattern = '.+Iteration \d{1,6), loss = +.';
pattern = 'Iteration (\d{1,6}), loss = (\d{1,10})';

% line = 'I0205 11:41:07.543540 16354 solver.cpp:242] Iteration 7241, loss = 135708'

iteration = [];
loss = [];

line = fgetl(fid);
while ischar(line)
    startIdx = regexpi(line, pattern,'tokens');
    if (~isempty(startIdx))
        iteration(end+1) = str2double(startIdx{1}{1});
        loss(end+1) = str2double(startIdx{1}{2});
    end;
    
    % Get next line
    line = fgetl(fid);
end;

fclose(fid);

%% 
windowSize = 101;
b = (1/windowSize)*ones(1,windowSize);
a = 1;

lossMean = filter(b,a,loss);

figure;
plot(iteration,loss,'.')
hold on;
plot(iteration,lossMean,'-','LineWidth',3);





