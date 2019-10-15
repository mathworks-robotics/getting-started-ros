%% Object Detection Example: TurtleBot (with timer and handle class)
% Copyright 2017 The MathWorks, Inc.

%% SETUP
% Create robot class containing all ROS entities and parameters
turtlebotIp = '172.31.28.38';
subName = '/camera/rgb/image_rect_color';
pubName = '/mobile_base/commands/velocity';
paramFcn = 'controlParams';
robot = MyRobot(turtlebotIp,subName,pubName,paramFcn);

%% TIMERS
robot.Params.Ts = 0.2; % 1/0.2 = 5 Hz
robotTimer = timer('TimerFcn',{@robotTimerFcn,robot}, ...
                'Period',robot.Params.Ts, ...
                'ExecutionMode','fixedRate');
start(robotTimer);

%% CLEANUP
% stop(robotTimer);