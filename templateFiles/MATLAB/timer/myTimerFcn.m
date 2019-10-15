function myTimerFcn(obj,event,robot)
% Timer callback function -- runs at every iteration of the timer
% Copyright 2017 The MathWorks, Inc.

    %% SENSE
    % Get data from ROS subscribers
    msg = robot.MySub.LatestMessage;
    
    %% PROCESS + CONTROL
    % Run perception algorithm
    perceptionFcn(robot,msg); 
    
    % Run control algorithm
    controlFcn(robot);
    
    %% VISUALIZE
    % (Optional) Plot results
    robot.CurrentTime = toc;
    plot(robot.MyAxes,robot.CurrentTime,robot.ControlOutputs, ...
         'bo','MarkerSize',5);
    drawnow
    
end

