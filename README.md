# Getting Started with MATLAB, Simulink, and ROS
Copyright 2017-2019 The MathWorks, Inc.

## Getting Started
This repository contains resources for getting started with MATLAB and Simulink 
and the Robot Operating System (ROS). This functionality is provided by ROS Toolbox.

To learn more, refer to our [blog post](https://blogs.mathworks.com/racing-lounge/2017/11/08/matlab-simulink-ros/) and the following videos.

* [Getting Started with MATLAB and ROS](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-getting-started-with-matlab-and-ros-1508263034047.html)
* [Getting Started with Simulink and ROS](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-getting-started-with-simulink-and-ros-1509397202143.html)
* [Deploying Standalone ROS Nodes from Simulink](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-deploying-algorithms-to-ros-1510659362460.html)
* [Distributed Computing with MATLAB, Simulink, and ROS](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-designing-distributed-systems-with-ros-1514584072926.html)

## templateFiles Folder
Contains files provide a basic structure for creating your own MATLAB and Simulink files.

### MATLAB Templates
* **loopTemplate:** Algorithm runs in a simple loop, with an optional pause between iterations
* **rateTemplate:** Algorithm runs in a simple loop, which runs at a fixed rate dictated by either the wall clock or the global ROS node clock
* **async/asyncTemplate:** Algorithm runs asynchronously, whenever a new ROS message is received
* **timer/timerTemplate:** Algorithm is scheduled to run on a timer in the background

### Simulink Templates
* **simulationTemplate:** Model is slowed down using the wall clock, to run approximately in real time
* **codeGenerationTemplate:** Model is configured to generate a standalone C++ ROS node using Embedded Coder
* **multirateTemplate:** Model contains multiple subscribe and algorithm rates, as well as displays the color-coded rates in the model
* **architecture/mdlArchTemplate:** Model contains MATLAB, Simulink, and Stateflow elements. Links to reusable MATLAB files and Simulink block library in the **architecture** folder
* **paramServerGetterTemplate + paramServerSetterTemplate**: The "getter" model can run on the desktop or deployed standalone, and receives parameters from the ROS parameter server. To modify the parameter value, you can either run the "setter" model, or use **rosparam** in MATLAB or a Terminal window.

## demoFiles Folder
Contains filled out versions of the templates above, that will run on several platforms.

### Algorithms

#### Object Detection
* Uses camera information to detect a blue object and return its position and size
* MATLAB code can be found in **Algorithms\detectCircle.m**
* The same function is called in the Simulink examples using a MATLAB Function block

#### Object Tracking
* Uses the output of the object detection algorithm to assign linear and angular velocities such that the object is centered in the field of vision and has a certain pixel size (or distance)
* MATLAB code can be found in **Algorithms\trackCircle.m**
* Simulink and Stateflow versions of the same algorithm can be found in **Algorithms\controlLib.slx**

### Target Platforms

#### Webcam
These examples have been tested on Windows using the MATLAB Support Package for USB Webcams at https://www.mathworks.com/matlabcentral/fileexchange/45182-matlab-support-package-for-usb-webcams

#### Gazebo Examples
These examples have been tested using the Linux virtual machine at https://www.mathworks.com/support/product/robotics/v3-installation-instructions.html.

When you open the virtual machine, you can track blue objects in either the **Gazebo Playground** or **Gazebo TurtleBot World** worlds. To test the tracking algorithm, you can use Gazebo to move the robot and/or the blue objects in the world.

#### TurtleBot
These examples have been tested using the TurtleBot 2. 

You can find a printable blue circle in the **Images** folder.

### MATLAB Examples
The **MATLAB** subfolder contains loop examples, as well as a **timer** subfolder showing the timer object and handle class approach.

### Simulink Examples
The **Simulink** subfolder contains examples with Simulink blocks, with Simulink blocks and a Stateflow chart, and using External Mode and the ROS Parameter Server (see the **paramServer** subfolder).

In addition, the **distributed** subfolder contains examples of the perception, control, and visualization components broken into multiple tasks and separate models. The models can communicate with each other with a standard ROS message or with a custom message which can be found in the **custom_robot_msgs** folder. To get the latter example working, you will need to use the ROS Toolbox Interface for ROS Custom Messages add-on and follow the steps shown at https://www.mathworks.com/help/ros/ug/ros-custom-message-support.html
