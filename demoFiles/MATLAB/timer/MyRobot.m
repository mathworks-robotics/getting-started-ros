classdef MyRobot < handle
    % MYROBOT Contains Robot Information
    % Copyright 2017 The MathWorks, Inc.

    properties
        % ROS publishers and subscribers
        ImgSub = [];
        VelPub = [];
        VelMsg = [];
        
        % Perception algorithm
        CircleX = 0;
        CircleY = 0;
        CircleSize = 0;
        ImgWidth = 0;
        ImgResizeScale = 1;
        
        % Control algorithm
        Params = [];
        
        % Visualization
        VidPlayer = [];
    end
    
    methods
        
        %% CONSTRUCTOR
        function obj = MyRobot(ip,subName,pubName,paramFcn)
            % Connect to ROS master
            rosshutdown;
            rosinit(ip);
            
            % Create subscriber
            obj.ImgSub = rossubscriber(subName);
            msg = receive(obj.ImgSub,10);
            
            % Create publisher
            [obj.VelPub,obj.VelMsg] = rospublisher(pubName);
            
            % Create parameters
            obj.Params = feval(paramFcn);    
            
            % Start visualization
            obj.VidPlayer = vision.DeployableVideoPlayer;
            step(obj.VidPlayer,readImage(msg)); % Display first image
            
        end       
        
        %% PERCEPTION ALGORITHM
        % Receives latest image data, runs detectCircle function, and
        % visualizes the results
        function perceptionFcn(obj,~,~)           
            % Read image from ROS subscriber
            img = readImage(obj.ImgSub.LatestMessage);
            obj.ImgWidth = size(img,2);
            
            % Run perception algorithm
            [obj.CircleX,obj.CircleY,obj.CircleSize] = ... 
                detectCircle(img,obj.ImgResizeScale);
            
            % Insert detected shape and visualize results
            img = insertShape(img,'Circle',[obj.CircleX obj.CircleY obj.CircleSize/2], ...
                              'LineWidth',2);
            step(obj.VidPlayer,img);           
        end
        
        %% CONTROL ALGORITHM
        % Runs trackCircle function and publishes ROS velocity commands
        function controlFcn(obj,~,~)            
             % Object tracking algorithm
            [v,w] = trackCircle(obj.CircleX,obj.CircleSize,obj.ImgWidth,obj.Params);

            % Package ROS message and send to the robot
            obj.VelMsg.Linear.X = v;
            obj.VelMsg.Angular.Z = w;
            send(obj.VelPub,obj.VelMsg);           
        end       
    end
    
end

