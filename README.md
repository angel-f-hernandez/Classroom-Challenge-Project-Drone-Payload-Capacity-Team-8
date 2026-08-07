# Solution to Classroom Challenge Project Drone Payload Capacity and Structural Design Analysis
This is a template repository for nominated Classroom Challenge Project submissions. Note to students participating in Classroom Challenge Projects: use this template so that your project may be reviewed by the MathWorks team for a prize. Remember that only your instructor can nominate projects for MathWorks review and prize eligibility. Once you have filled out this template and uploaded your MATLAB and/or Simulink solution, notify your instructor that your project is ready for review. Your instructor will need the URL for your GitHub repository to submit your project to MathWorks for evaluation.

Please add the following items:
* Short project description, including the MathWorks project number (on the GitHub page for the project)

# Project Details
Briefly describe your team's approach to the project and how you implemented your solution.

In this project, a drone arm was designed and analyzed by calculating the maximum stress of the arm, performing a thrust-to-weight analysis to determine payload capacity, and conducting Finite Element Analysis. In designing the arm, our team first brainstormed simple shapes that could be used. After those shapes were sketched, their area, volume, and density equations were inputted into a MATLAB code, and dimensions were approximated before they were sketched and completed in a CAD software. This allowed us to pick dimensions for each arm that would keep it above our minimum factor of safety of 1.5 while still meeting the 0.5 kg minimum payload and 2:1 thrust-to-weight requirements. Finite element analysis would be completed after the shapes were sketched and designed in a CAD software. The two shapes that our team decided to use in this project are a hollow, oval shaped arm, and a truss inspired arm.

Our first set of dimensions came from the approximate MATLAB calculations, but the finite element analysis showed that those designs did not hold up. The oval arm deformed more than we wanted, and the truss arm fell below the minimum factor of safety for half of the material options, mostly because of stress concentrations at the joints and mounting holes that our simpler equations could not account for. We revised both designs with thicker walls and wider truss members, which fixed both problems but added mass and reduced how much payload the drone could carry.

After completing a MATLAB code to run a stress analysis and finite element analysis on each arm design, the two were compared to determine which design best met the requirements and stayed above the minimum factor of safety. Some of the factors that were considered when determining which design had the best results included which one had a better margin above the required factor of safety, and which one had the higher maximum payload capacity. The finite element analysis was also used to determine which arm design had less strain and deformation. These results can be seen in the graph and data below.
# Project Solution Instructions
In order to run this solution, please follow these steps:
* Requires MATLAB R2023b or later with the Partial Differential Equation Toolbox
1. Load the .stl or .step files into the /cad folder
2. Open the DroneDesign_StudentProjectTemplate.mlx file and modify the filePaths variable with the the file paths of the uploaded designs
3. Update the designNames variable to accurately reflect the name of the design uploaded
4. Update the areas array with the surface area of the face(s) that are going to be loaded. This value comes from your choice of CAD software
5. Run Task 1, Task 3, and the first part of Task 4 in order to generate a visual of the drone arm designs
6. From the drone arm visual, update the fixedFaces and loadedFaces with the number associated to each face to accurately represent the load conditions on the drone arm
7. Run the second part of Task 4 in order to complete the FEA simulation and generate the graphs and the final results table

# Results
Add a picture, plot, animation, GIF, or table to demonstrate the expected result or output of your project solution.

# Reference
Add reference papers, data, or supporting materials that have been used, if any.

# Contact (optional)
Provide the best e-mail at which to contact you and your team in the event that you are chosen to receive a prize.
