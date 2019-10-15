%% Object Detection Example: Gazebo (with timer and handle class)
% Copyright 2017 The MathWorks, Inc.

%% SETUP
% Create robot class containing all ROS entities and parameters
gazeboIp = '192.168.119.133';
subName = '/camera/rgb/image_raw';
pubName = '/mobile_base/commands/velocity';
paramFcn = 'controlParamsGazebo';
robot = MyRobot(gazeboIp,subName,pubName,paramFcn);

%% TIMER
robot.Params.Ts = 0.2; % 1/0.2 = 5 Hz
robotTimer = timer('TimerFcn',{@robotTimerFcn,robot}, ...
                'Period',robot.Params.Ts, ...
                'ExecutionMode','fixedRate');
start(robotTimer);

%% CLEANUP
% stop(robotTimer);