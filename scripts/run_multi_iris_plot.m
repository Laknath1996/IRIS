% author : Ashwin de Silva
% iris plot wrapper

%% reset the MATLAB workspace

close all;
clear all;

%% get input from the user

% get the number of rings
prompt = {'Enter Number of Rings:'};
title = 'Number of Rings';
dims = [1 35];
definput = {'5'};
answer = inputdlg(prompt,title,dims,definput);
num_rings = str2num(answer{1});

% get the excel file path
[FileName,PathName] = uigetfile('*.xls','Select the Excel Sheet');

%get the sheet name
prompt = {};
defaultans = {};
for i = 1:num_rings
    prompt{end+1} = sprintf('Enter patient %d sheet name:',i);
    prompt{end+1} = sprintf('Enter control %d sheet name:',i);
    defaultans{end+1} =  '#2096 div29 33';
    defaultans{end+1} = '#2096 div29 2122';
end            
dlg_title = 'Input Sheet Names';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

% get the folder to where the plots should be saved
%save_path = uigetdir('Save the figures to'); % to save the plots uncomment
%this

% get the type of mean for checking the variation direction
choice = menu('Choose a statistic for comparison','mean','harmonic mean',...
                'geometric mean','median'); 
            
%% navigate into the excel sheets

% define the order of the variables        
cols = [27,28,29,30,34,31,40,1,2,3,4,5,6,7,8,22,10,11,12,13,36,37,38,39,14,15,16,17,18,19,20,21,24,25,26,23,33,35,9,32];

% read the matrices from the excel sheet
path = fullfile(PathName,FileName);

patient = {};
ctrl = {};
c1 = 1;
c2 = 1;
for i = 1:num_rings*2
    temp = xlsread(path,answer{i}); 
    temp(any(isnan(temp), 2), :) = [];
    temp = temp(:,cols);
    if mod(i,2) == 1
        patient{c1} = temp;
        c1 = c1 + 1;
    else
        ctrl{c2} = temp;
        c2 = c2 + 1;
    end
end

% run the iris plot with only the variations
irisPlot3(patient, ctrl) %,save_path);

% run the iris plot with increments and decrements
irisPlot4(patient, ctrl, choice) %,save_path);






