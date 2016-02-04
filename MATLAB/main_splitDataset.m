% This script splits an dataset into a training set and a test set. The
% dataset must be in the form of a set of images located in a single
% folder. The training and test set are copied into a specified traning and
% test set folder.
%
% Author:       Anders Krogh Mortensen
% Affiliation:  Dept. of Agroecology, Aarhus University
% Date:         4 Feb. 2016

clear all;
close all;

%% Settings

fullDatasetPath = '/home/anmo/code/caffe/models/fcn_32_pascal_contex/pascal/VOC2010/pascal-context-59';
trainDatasetPath_out = '/home/anmo/code/caffe/models/fcn_32_pascal_contex/pascal/VOC2010/pascal-context-59 (train)';
testDatasetPath_out = '/home/anmo/code/caffe/models/fcn_32_pascal_contex/pascal/VOC2010/pascal-context-59 (test)';
fileExtention = 'png';

trainFraction = 0.7; % Fraction of dataset used for training. Rest is used for test. E.g. 0.7 results in 70% of the dataset for training and 30% for test set

randomSeed = 1234; % for reproduce ability. Set to [] for "truely" random.

%% 

% Set seed for random generator
if ~isempty(randomSeed)
    rng(randomSeed);
end;

files = dir(fullfile(fullDatasetPath,['*.' fileExtention]));

randOrder = randperm(length(files));

Ntrain = round(0.7*length(files));
Ntest = length(files)-Ntrain;

%% Copy training set

trainIdx = randOrder(1:Ntrain);
disp('Copying training set...');
mkdir(trainDatasetPath_out);
for i = 1:length(trainIdx)
    filename = files(trainIdx(i)).name;
    src = fullfile(fullDatasetPath,filename);
    dst = fullfile(trainDatasetPath_out, filename);
    copyfile(src, dst);
end;

%% Copy test set

testIdx = randOrder(Ntrain+1:end);
disp('Copying test set...');
mkdir(testDatasetPath_out);
for i = 1:length(testIdx)
    filename = files(testIdx(i)).name;
    src = fullfile(fullDatasetPath,filename);
    dst = fullfile(testDatasetPath_out, filename);
    copyfile(src, dst);
end;

%%

disp('Done')
disp(['Training set: ' num2str(Ntrain) ' (' num2str(Ntrain/length(files)*100) '%)'])
disp(['Test set:     ' num2str(Ntest) ' (' num2str(Ntest/length(files)*100) '%)'])