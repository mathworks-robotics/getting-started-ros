%% Object Detection Example: Webcam
% Copyright 2017 The MathWorks, Inc.

%% SETUP
% Create a video device to acquire data from a camera
if ~exist('myCam','var')
  myCam = imaq.VideoDevice('winvideo',1,'RGB24_640x480','ReturnedDataType','uint8');
end
% Create video player for visualization
vidPlayer = vision.DeployableVideoPlayer;
% Load control parameters
params = controlParams;

%% LOOP
while(1) 
    %% SENSE
    % Grab images
    img = step(myCam);

    %% PROCESS
    % Object detection algorithm
    resizeScale = 0.5;
    [centerX,centerY,circleSize] = detectCircle(img,resizeScale);
    % Object tracking algorithm
    [v,w] = trackCircle(centerX,circleSize,size(img,2),params);
    
    %% CONTROL
    % Display velocity results
    fprintf('Linear Velocity: %f, Angular Velocity: %f\n',v,w);
    
    %% VISUALIZE
    % Annotate image and update the video player
    img = insertShape(img,'Circle',[centerX centerY circleSize/2],'LineWidth',2);
    step(vidPlayer,img);
        
end