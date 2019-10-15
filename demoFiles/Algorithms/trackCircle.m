function [v,w] = trackCircle(x,blobSize,imgWidth,params)
% Tracks location and distance of detected circle by assigning 
% linear and angular velocities
% Copyright 2017 The MathWorks, Inc.

    %% Initialize persistent variables
    persistent xBuffer xPrev sizeBuffer outlierCount
    if isempty(xBuffer); xBuffer = zeros(1,params.bufSize); end
    if isempty(sizeBuffer); sizeBuffer = zeros(1,params.bufSize); end
    if isempty(xPrev); xPrev = x; end
    if isempty(outlierCount); outlierCount = 0; end
     
    %% Input processing
    % Count outliers
    if (abs(x-xPrev)<params.maxDisp) && (blobSize>params.minSize) && (blobSize<params.maxSize)      
        outlierCount = 0;
    else
        outlierCount = min(outlierCount+1,1000); % Increment with saturation
    end
    % Update and average the measurement buffers
    xBuffer = [xBuffer(2:params.bufSize) x];
    sizeBuffer = [sizeBuffer(2:params.bufSize) blobSize];
    xFilt = mean(xBuffer);
    sizeFilt = mean(sizeBuffer);
    xPrev = x;
    
    %% Angular velocity control: Keep the marker centered
    w = 0;
    if outlierCount < params.maxCounts        
        posError = xFilt - imgWidth/2;
        if abs(posError) > params.posDeadZone
            speedReduction = max(sizeFilt/params.speedRedSize,1);
            w = -params.angVelGain*posError*speedReduction;
        end
        if w > params.maxAngVel
            w = params.maxAngVel;
        elseif w < -params.maxAngVel
            w = -params.maxAngVel;
        end
    end

    %% Linear velocity control: Keep the marker at a certain distance
    v = 0;
    if outlierCount < params.maxCounts      
        sizeError = params.targetSize - sizeFilt;
        if abs(sizeError) > params.sizeDeadZone
            v = params.linVelGain*sizeError;
        end
        if v > params.maxLinVel
            v = params.maxLinVel;
        elseif v < -params.maxLinVel
            v = -params.maxLinVel;
        end
    end

    %% Scan autonomously for a while if the outlier count has been exceeded
    if outlierCount > 50 && outlierCount < 500
       w = params.maxAngVel/2; 
    end
    
end

