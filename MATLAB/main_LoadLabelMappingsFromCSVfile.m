clear,close all; clc;

fileDir = fullfile('..','PascalContextClasses.csv');
[ map ] = loadLabelMappingsFromCSVfile( fileDir );
