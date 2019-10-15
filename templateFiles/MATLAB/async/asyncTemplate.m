%% MATLAB Template: Asynchronous Execution
% Algorithms are run immediately on receiving a new sensor message
% Copyright 2017 The MathWorks, Inc.

%% SETUP
% Create object containing all ROS entities, parameters, and algorithms
ipAddr = '';
robot = RobotTemplateClass(ipAddr);
% Modify parameters in the robot object
robot.PerceptionParam = 2;
robot.ControlParams.gain = 0.25; 

% Modify ROS subscriber to process sensor data asynchronously
% Define subscriber callback function, passing in the additional robot object
subCallbackFcn = {@mySubCallback,robot};
% Using a callback, the algorithm can be run when a new message is received.
robot.MySub = ... 
    rossubscriber('/my_sub_topic','geometry_msgs/Point',subCallbackFcn);

%% TEST
% Send random messages to the subscriber
tic;
currentTime = 0;
[testPub,testMsg] = rospublisher('/my_sub_topic');
while(currentTime < 10)
   testMsg.Z = rand;        % Create random message
   send(testPub,testMsg);   % Send message
   pause(rand^2);           % Pause at a random time 
                            % (Squaring exaggerates the time spread)
   currentTime = toc;
end