function robotTimerFcn(obj,event,robot)
% Timer callback function -- runs at every iteration of the timer
% Copyright 2017 The MathWorks, Inc.

    % Run perception algorithm
    perceptionFcn(robot); 
    
    % Run control algorithm
    controlFcn(robot);
    
end