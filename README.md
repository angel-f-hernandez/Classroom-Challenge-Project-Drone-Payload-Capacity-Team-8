# Solution to Classroom Challenge Project Drone Payload Capacity and Structural Design Analysis
This is a template repository for nominated Classroom Challenge Project submissions. Note to students participating in Classroom Challenge Projects: use this template so that your project may be reviewed by the MathWorks team for a prize. Remember that only your instructor can nominate projects for MathWorks review and prize eligibility. Once you have filled out this template and uploaded your MATLAB and/or Simulink solution, notify your instructor that your project is ready for review. Your instructor will need the URL for your GitHub repository to submit your project to MathWorks for evaluation.

Please add the following items:
* Short project description, including the MathWorks project number (on the GitHub page for the project)

# Project Details
Briefly describe your team's approach to the project and how you implemented your solution.

In this project, a drone arm was designed and analyzed by calculating the maximum stress of the arm using the given factor of safety, and conducting Finite Element Analysis. In designing the arm, our team first brainstormed simple shapes that could be used. After those shapes were sketched, and their area, volume and density equations were inputed into a MATLAB code, dimensions were approximated before they were sketched and completed in a CAD software. This allowed us to pick dimensions for each arm that would set it below our factor of safety for stress in the arm. Finite element analysis would be completed after the shapes were sketched and design in a CAD software. The two shapes that our team decided to use in this project are a hollow, oval shaped arm, and a truss inspired arm. 

After completed a MATLAB code to run a stress analysis and finite element analysis on each arm design, the two were compared to determine which design best met the requirements, and fell below the given factor of safety. Some of the factors that were considered when determining which design had the best results included which one had a better margin of error in terms of the given factor of safety. The finite element analysis was also used to determine which arm design had less strain and deformation. These results can be seen in the graph and data below.

# Project Solution Instructions
Please explain step-by-step how to setup and run your project solution. Include any information about resources or external tools that might be needed to run your MATLAB code and/or Simulink model without errors.

# Results
Add a picture, plot, animation, GIF, or table to demonstrate the expected result or output of your project solution.

# Reference
Add reference papers, data, or supporting materials that have been used, if any.

# Contact (optional)
Provide the best e-mail at which to contact you and your team in the event that you are chosen to receive a prize.
