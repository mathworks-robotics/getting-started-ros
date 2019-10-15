%% MATLAB Template: Simple Rate
% Copyright 2017 The MathWorks, Inc.

%% SETUP
% Start or connect to ROS master
rosshutdown;
ipAddr = '';
rosinit(ipAddr)

% Create ROS subscribers
mySub = rossubscriber('/my_sub_topic','geometry_msgs/Point');

% Create ROS publishers
[myPub,pubMsg] = rospublisher('/my_pub_topic','geometry_msgs/Point');
 
% Start visualization
close all
myViz = axes;
title(myViz,'Control Output')
xlabel(myViz,'Time [s]')
hold(myViz,'on') 

% Load parameters
perceptionParam = 2;        % Individual parameter
controlParams.gain = 0.25;   % Parameter structure

%% CONTROL LOOP
% Start while-loop, which runs indefinitely at a given rate, or as quickly
% as possible if the rate cannot be satisfied.

% Uses wall clock time
myRate = robotics.Rate(2);    

% Rate uses global ROS node time source. 
% Useful if connecting to a ROS enabled simulator like Gazebo or V-REP
% myRate = rosrate(2);   

while(myRate.TotalElapsedTime < 10)
    %% 1: SENSE
    % Get latest data from ROS subscribers
    receivedMsg = mySub.LatestMessage;
    if isempty(receivedMsg)
       receivedData = rand; % If message is empty, assign random number
    else
       receivedData = receivedMsg.Z;
    end

    %% 2: PROCESS
    % Run perception and control algorithms, which use received data and 
    % control parameters to produce some output.
    ctrlInput  = myPerceptionAlgorithm(receivedData,perceptionParam);
    ctrlOutput = myControlAlgorithm(ctrlInput,controlParams);
    
    %% 3: CONTROL
    % Package and send control outputs as ROS messages
    pubMsg.X = ctrlOutput;
    send(myPub,pubMsg);
    
    %% 4: VISUALIZE
    % (Optional) Visualize data as the algorithm is running.
    currentTime = myRate.TotalElapsedTime;
    plot(myViz,currentTime,ctrlOutput,'bo','MarkerSize',5)
    drawnow
        
    %%  Block execution based on the rate defined.
    waitfor(myRate);

% End while-loop
end
