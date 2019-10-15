%% MATLAB Template: Timer and Handle Class
% Timers are useful for scheduling tasks, for example, algorithm execution, 
% in the background without blocking the MATLAB session.
% Storing all robot data and functionality in a handle class allows you to
% easily use and modify a single object. Multiple actions, such as timers
% or user input, can access the object functionality at the same time.
% Copyright 2017 The MathWorks, Inc.

%% SETUP
% Create object containing all ROS entities, parameters, and algorithms
ipAddr = '';
robot = RobotTemplateClass(ipAddr);
% Modify parameters in the robot object
obj.PerceptionParam = 2;
obj.ControlParams.gain = 0.25; 

%% TIMERS
% Create a timer that executes at a fixed rate.
% Note that you can create multiple timers for a multirate system.
% Each timer function requires at least two arguments. The syntax
% {@fcnName,robot} allows you to pass the robot class as a third argument.
sampleTime = 0.5;
myTimer = timer('TimerFcn',{@myTimerFcn,robot}, ...
                'Period',sampleTime, ...
                'ExecutionMode','fixedRate');
% Begin keeping track of time and start timer
tic;   
start(myTimer);

%% CLEANUP
% To stop the algorithms, use the command
% stop(myTimer);
% If there are any unstopped timers, you can enter 
% delete(timerfindall);