% Copyright 2017 The MathWorks, Inc.

% Clean up
close all;
clear;
clc;

% Set up the path
addpath(pwd,genpath('MATLAB'),genpath('Simulink'));

% Set up simulation cache and code generation folders
Simulink.fileGenControl('set','CacheFolder','work','CodeGenFolder','work');