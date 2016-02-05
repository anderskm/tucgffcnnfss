clear,close all; clc; 
% Script for evaluating performance using the following metrics: 
    % 1) Accuracy
    % 2) Mean accuracy
    % 3) Mean intersection over union
    % 4) Frequency weighted intersection over union


% UNDER CONSTRUCTION: CAN ONLY BE USED FOR INSPECTION OF ANNOTATIONS AND RESULTS


% Do remapping of classifier
    % 0: (Normal case) The number of classes is the same under both train
    % and test.
    % 1: The classifier has been trained on XX classes, that is mapped to
    % YY classe

% Select one of the below specified settings to be evaluated.
selectSetting = 4;

evalSetting(1).dirImagesOrg =  '/home/repete/DataFolder/VOC2010/JPEGImages';
evalSetting(1).dirImagesTest =  '../Data/Context33';
evalSetting(1).selectMapping = 1;

evalSetting(2).dirImagesOrg =  '/home/repete/DataFolder/VOC2010/JPEGImages';
evalSetting(2).dirImagesTest =  '../Data/Context59';
evalSetting(2).selectMapping = 2;

evalSetting(3).dirImagesOrg =  '/home/repete/DataFolder/VOC2010/JPEGImages';
evalSetting(3).dirImagesTest =  '../Data/Agro1';
evalSetting(3).selectMapping = 3;

evalSetting(4).dirImagesOrg =  '/home/repete/DataFolder/VOC2010/JPEGImages';
evalSetting(4).dirImagesTest =  '../Data/Agro2';
evalSetting(4).selectMapping = 4;



% Directory of original color images;
dirImagesOrg = evalSetting(selectSetting).dirImagesOrg;

% Directory of annotated test images.
dirImagesTest = evalSetting(selectSetting).dirImagesTest;
dirsImagesTest = dir(fullfile(dirImagesTest,'*.png'));

%
selectMapping = evalSetting(selectSetting).selectMapping;

% Directory of cvs mapping file.
dirCSVfile = '../Data/PascalContextClasses.csv';
[ labelMap ] = loadLabelMappingsFromCSVfile( dirCSVfile );
labels = labelMap(selectMapping).NewLabelIdsUnique;
labelNames = labelMap(selectMapping).NewLabelNamesUnique;


% Show the most frequent classes that covers XX% of the image
% imageLabelCoverage = 0.95;


dColors = distinguishable_colors(length(labels));

for iImage = 1:length(dirsImagesTest)
    imgAnnotation = imread(fullfile(dirImagesTest,dirsImagesTest(iImage).name));
    
    % Show only annotated classes
    vecUsedLabels = double(unique(imgAnnotation(:)));
    vecLabelFreq= histc(imgAnnotation(:),vecUsedLabels);
    freqLabelMat = [vecLabelFreq/sum(vecLabelFreq) vecUsedLabels];
    sortFreqLabelMat = flipud(sortrows(freqLabelMat)); 
    
    
    
    
    
    
    imgAnnotationVis = im2double(imgAnnotation);
    figure(1)
    strTmp = strsplit(dirsImagesTest(iImage).name,'.');
    rgbOrg = imread(fullfile(dirImagesOrg,[strTmp{1} '.jpg']));
    subplot(1,3,1); title('Original image')
    imshow(rgbOrg)
    
    subplot(1,3,2); title('Annotated image')
    imshow(imgAnnotationVis*255/length(labels)); 
%     image(imgAnnotation); 
    colormap(dColors)
    lcolorbar(labelNames');
    
    subplot(1,3,3); title('Predicted')
    imshow(imgAnnotationVis*255/length(labels)); 
%     image(imgAnnotation)
    colormap(dColors)
    lcolorbar(labelNames');

    

end
