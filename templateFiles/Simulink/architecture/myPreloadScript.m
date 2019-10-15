%% Simulink Architecture Template: Sample Preload Script
% Performs Simulink model setup and is called in model's pre-load function
% Copyright 2017 The MathWorks, Inc.

%% ROS setup
rosshutdown;
ipAddr = '';
rosinit(ipAddr)

%% Sample times
sampleTimeSlow = 1;
sampleTimeFast = 0.2;

%% Control parameters
perceptionParam = 0.25;
ctrlParam1 = 2;
ctrlParam2 = 3.5;