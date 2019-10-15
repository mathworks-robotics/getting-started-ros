function mySubCallback(~,msg,robot)
% Example subscriber callback function
% Copyright 2017 The MathWorks, Inc.
    
    % Run perception algorithm
    perceptionFcn(robot,msg);
    
    % Run control algorithm
    controlFcn(robot);
   
    % (Optional) Visualize results
    robot.CurrentTime = toc;
    plot(robot.MyAxes,robot.CurrentTime,robot.ControlOutputs, ...
         'bo','MarkerSize',5);
    drawnow

end

