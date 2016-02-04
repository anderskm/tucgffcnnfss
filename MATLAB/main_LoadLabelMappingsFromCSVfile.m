% Example of how to load the label look-up table from a csv-file
%
% Author:       Peter Christiansen
% Affiliation:  Dept. of Engineering, Aarhus University
% Date:         4 Feb. 2016

clear, close all;

fileDir = fullfile('../Data','PascalContextClasses.csv');
[ labelMap ] = loadLabelMappingsFromCSVfile( fileDir );
