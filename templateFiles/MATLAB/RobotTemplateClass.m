classdef RobotTemplateClass < handle
    % ROBOTTEMPLATECLASS Contains Robot Information
    % Copyright 2017 The MathWorks, Inc.
    
    properties
        % ROS publishers and subscribers
        MySub = [];
        MyPub = [];
        PubMsg = [];
        
        % Perception algorithm   
        PerceptionParam = 1;
        
        % Control algorithm
        ControlInputs = 0; 
        ControlOutputs = 0;
        ControlParams = struct('gain',1);
        
        % Visualization
        MyFig = [];
        MyAxes = [];
        CurrentTime = 0;
    end
    
    methods       
        %% CONSTRUCTOR
        function obj = RobotTemplateClass(ipAddr)
            % Connect to ROS master at the IP address specified
            rosshutdown;
            rosinit(ipAddr);
            
            % Create subscribers
            obj.MySub = ...
                rossubscriber('/my_sub_topic','geometry_msgs/Point');
            
            % Create publisher
            [obj.MyPub,obj.PubMsg] = ... 
                rospublisher('/my_pub_topic','geometry_msgs/Point'); 
            
            % Start visualization
            obj.MyFig = figure;
            obj.MyAxes = axes(obj.MyFig);
            title(obj.MyAxes,'Control Output')
            xlabel(obj.MyAxes,'Time [s]')
            hold(obj.MyAxes,'on');
        end     
        
        %% PERCEPTION ALGORITHM
        % Receives sensor data, runs perception algorithm, and visualizes
        function perceptionFcn(obj,receivedMsg)           
            if isempty(receivedMsg)
               receivedData = rand; % If message is empty, assign random number
            else
               receivedData = receivedMsg.Z;
            end
            
            % Perception algorithm
            obj.ControlInputs = ... 
                myPerceptionAlgorithm(receivedData,obj.PerceptionParam);            
        end
        
        %% CONTROL ALGORITHM
        % Runs control algorithm and publishes ROS commands
        function controlFcn(obj)            
             % Control algorithm
            obj.ControlOutputs = ... 
                myControlAlgorithm(obj.ControlInputs,obj.ControlParams);
            
            % Package ROS message and send to the robot
            obj.PubMsg.X = obj.ControlOutputs;
            send(obj.MyPub,obj.PubMsg);    
            
        end       
    end
    
end

