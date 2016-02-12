clear all;
% close all;

% logFile = '../../../code/caffe/models/fcn_32_pascal_contex/TrainingLogtBrain2 (Copy).log';

% logFile = 'E:\BioMap\TrainFullTBrain6 (9th copy).log';
logFile = 'E:\BioMap\TrainFullTBrain7 (6th copy).log';
logFile = 'E:\BioMap\TrainFull_lr10(Mads).log';
% logFile = 'E:\BioMap\CIGR\logs\TrainFinetune__lr9.log';

fid = fopen(logFile);

test_itr = 7072;
test_itr = 72;
test_itr = 2000;
medianNumberOfPixelsInImage = 187500;
medianNumberOfPixelsInImage = 400*500;
medianNumberOfPixelsInImage = 512*512;

lineMemory = 3;

% pattern = '.+Iteration: \d';
pattern = '.+Iteration \d{1,6), loss = +.';
pattern = {'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6}) \d{1,10} solver\.cpp:\d{1,5}] Iteration ((\d\.\d{1,5}e\+\d{2})|(\d{1,6})), loss = (\d{1,10})', ...
           'Test net output'};
       
pattern = {'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6}) \d{1,10} solver\.cpp:\d{1,5}] Iteration (\d{1,6}), loss = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10}))', ...
           'Test net output'};
       
pattern = {'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6}) \d{1,10} solver\.cpp:\d{1,5}] Iteration (\d{1,6}), loss = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10}))', ...
           'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6}) \d{1,10} solver\.cpp:\d{1,5}] {1,}Test net output #\d: loss = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10})) \(\* \d = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10})) loss\)'};

pattern = {'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6})\s{1,}\d{1,10} solver\.cpp:\d{1,5}] Iteration (\d{1,}), loss = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10}))', ...
           'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6})\s{1,}\d{1,10} solver\.cpp:\d{1,5}] {1,}Test net output #(\d): loss = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10})) \(\* \d = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10})) loss\)', ...
           'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6})\s{1,}\d{1,10} solver\.cpp:\d{1,5}] Iteration (\d{1,}), Testing net \(#(\d)\)'};

% pattern = {'Iteration (\d{1,6}), loss = (\d\.\d{1,5}e\+\d{2})', ...
%           'Test net output #(\d): loss = (\d\.\d{1,5}e\+\d{2})'};
% line = 'I0205 15:04:01.768020 21282 solver.cpp:242] Iteration 2748, loss = 1.41966e+07';

% line = 'I0205 11:41:07.543540 16354 solver.cpp:242] Iteration 7241, loss = 135708'

time = [];
iteration = [];
loss = [];


log = struct;
log.train.time = [];
log.train.iteration = [];
log.train.loss = [];
log.test.time = [];
log.test.iteration = [];
log.test.loss = [];

lines = cell(3,1);

k = 0;
line = fgetl(fid);
while ischar(line)
    tokens = regexpi(line, pattern,'tokens');
    if (~isempty(tokens{1}))
        trainItr = tokens{1};
        log.train.time(end+1) = datenum(trainItr{1}{1},'mmdd HH:MM:SS.FFF');
        log.train.iteration(end+1) = str2double(trainItr{1}{2});
        log.train.loss(end+1) = str2double(trainItr{1}{3});
%         disp(line)
    end;
    if (~isempty(tokens{2}))
        testItr = tokens{2};
%         celldisp(testItr)
%         celldisp(testItr);
%         disp(line)
%         celldisp(lines);
        log.test.time(end+1) = datenum(testItr{1}{1},'mmdd HH:MM:SS.FFF');
        log.test.loss(end+1) = str2double(testItr{1}{3});
        
        tokens2 = regexpi(lines{1}, pattern,'tokens');
        if (~isempty(tokens2{3}))
            testItr2 = tokens2{3};
            log.test.iteration(end+1) = str2double(testItr2{1}{2});
        else
            log.test.iteration(end+1) = NaN;
        end;
        
%         k = 99999999;
    end;
 
%     if (k > 22966)
%         disp(line)
%         pause();
%     end
%     k = k+1;
    %
    lines = {line, lines{1:end-1}};
    % Get next line
    line = fgetl(fid);
end;

fclose(fid);

%% 
windowSize = 1001;
b = (1/windowSize)*ones(1,windowSize);
a = 1;

lossMean = filter(b,a,loss);

figure;
subplot(3,1,1);
plot(log.train.iteration,log.train.loss,'.-')
hold on;
set(gca,'XTick',(1:1:ceil(max(log.train.iteration)/test_itr))*test_itr);
set(gca,'XTickLabel',(1:1:ceil(max(log.train.iteration)/test_itr)));
plot(log.test.iteration,log.test.loss,'o-','LineWidth',2);
xlabel('Epoch');
ylabel('Loss pr. image');
legend('Train','Validation','Location','EastOutside');
subplot(3,1,2);
plot(log.train.iteration,log.train.loss/medianNumberOfPixelsInImage,'.-')
hold on;
set(gca,'XTick',(1:1:ceil(max(log.train.iteration)/test_itr))*test_itr);
set(gca,'XTickLabel',(1:1:ceil(max(log.train.iteration)/test_itr)));
plot(log.test.iteration,log.test.loss/medianNumberOfPixelsInImage,'o-','LineWidth',2);
xlabel('Epoch');
ylabel('Avg. loss pr. pixel');
legend('Train','Validation','Location','EastOutside');
subplot(3,1,3);
plot((log.train.time-min(log.train.time))*24,log.train.loss/medianNumberOfPixelsInImage,'.-')
hold on;
plot((log.test.time-min(log.train.time))*24,log.test.loss/medianNumberOfPixelsInImage,'o-','LineWidth',2);
xlabel('Time (hr)');
ylabel('Avg. loss per pixel');
legend('Train','Validation','Location','EastOutside');

%% Testing patterns

% pattern = {'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6}) \d{1,10} solver\.cpp:\d{1,5}] Iteration (\d{1,}), loss = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10}))', ...
%            'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6}) \d{1,10} solver\.cpp:\d{1,5}] {1,}Test net output #(\d): loss = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10})) \(\* \d = ((\d\.\d{1,5}e\+\d{2})|(\d{1,3}\.\d{1,5})|(\d{1,10})) loss\)', ...
%            'I(\d{4} \d{2}:\d{2}:\d{2}\.\d{6}) \d{1,10} solver\.cpp:\d{1,5}] Iteration (\d{1,}), Testing net \(#(\d)\)'};
% % line = 'I0205 11:41:07.543540 16354 solver.cpp:242] Iteration 7241, loss = 135708';
% % line = 'I0205 15:04:01.768020 21282 solver.cpp:242] Iteration 2748, loss = 1.41966e+07';
% % line = 'I0206 06:45:04.345680 21282 solver.cpp:414]     Test net output #0: loss = 1.41297e+07 (* 1 = 1.41297e+07 loss)';
% % line = 'I0205 15:57:10.751566 21282 solver.cpp:346] Iteration 7072, Testing net (#0)';
% line = 'I0208 08:49:30.727206  3518 solver.cpp:242] Iteration 6, loss = 122592'
% tokens = regexpi(line, pattern,'tokens');
% celldisp(tokens)
% tokens