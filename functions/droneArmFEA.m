function [results] = droneArmFEA(filePath, designName, materialNames, youngsModulus, poissonsRatio, density, yieldStrength)
% droneArmFEA: performs FEA for each of the materials provided on a
% specified drone arm and outputs the results as a struct which stores the
% name of the material and the StaticStructuralResults objects of the test.
% 
% INPUTS:
%   filePath:      a string containing the file path to the STL/STEP file
%   designNameL:   a string containing the name of the design
%   materialNames: a string array containing the names of the materials   
%   youngsModulus: a double array containing the Young's Modulus of each
%                  material, in Pa
%   poissonsRatio: a double array containing the Poissons Ratios of each
%                  material
%   density:       a double array containing the densities of each material in
%                  kg/m^3
%   yieldStrength: a double array containing the yield strengths of the
%                  provided materials in Pa
% 
% OUTPUTS:
%   results:       a structure array containing the material name and the
%                  corresponding StaticStructuralResults object

arguments
    filePath (1, 1) string
    designName (1, 1) string
    materialNames (:, 1) string
    youngsModulus (:, 1) double
    poissonsRatio (:, 1) double
    density (:, 1) double
    yieldStrength (:, 1) double
end

% Gets the total number of properties
nMaterialNames = numel(materialNames);

% Checks to ensure all provided material properties are of the same size
if numel(youngsModulus) ~= nMaterialNames || numel(poissonsRatio) ~= nMaterialNames || numel(density) ~= nMaterialNames  || numel(yieldStrength) ~= nMaterialNames
    error("Material input arrays must all have the same length.")
end

% Define gravity

g = 9.81;   % m/s^2

% Creates the temporary FEmodel and creates a graph with the faces displayed
model = femodel("AnalysisType","structuralStatic", "Geometry", filePath);
tempMesh = generateMesh(model);
pdegplot(tempMesh, FaceAlpha=0.5, FaceLabels="on");

% Collects user input on which faces are fixed, which faces have loads, and
% the surface area of the selected item
fixedFacesID = input("Which faces are fixed? ");
loadedFaceID = input("What face is loaded? ");
faceArea = input("What is the area of the the loaded face? ");

% Calculate load on object in Newtons
motorThrustN = 1 * g;        % Newtons
motorWeightN = 0.065 * g;    % Newtons


% Convert load into surface traction (N/m^2)
netMotorTraction = (motorThrustN - motorWeightN) / faceArea; % N/m^2

% Preallocate storage for material names and solution objects
results(nMaterialNames, 1) = struct( ...
    "DesignName" , "",...
    "MaterialName", "", ...
    "Solution", [], ...
    "MaximumDisplacement", [], ...
    "MaximumVonMisesStress", [], ...
    "FOS", []);

% Model for FEA is generated
model = femodel("AnalysisType","structuralStatic", "Geometry", filePath);

% Loop that iterates over each material
for idx = 1:nMaterialNames

    % Material properties are loaded into the model
    model.MaterialProperties.YoungsModulus = youngsModulus(idx);
    model.MaterialProperties.PoissonsRatio = poissonsRatio(idx);
    model.MaterialProperties.MassDensity = density(idx);

    % Boundary conditions/applied loads are configured on the model
    model.FaceLoad(loadedFaceID) = faceLoad(SurfaceTraction = [0; 0; netMotorTraction]);
    model.FaceBC(fixedFacesID) = faceBC(Constraint='fixed');
    model.CellLoad = cellLoad(Gravity=[0, 0, -g]);
    
    % Generate the mesh and run the simulation
    model = generateMesh(model);
    R = solve(model);
    
    % Find maximum stress, displacement, and also calculate FOS
    maxDisplacement = max(R.Displacement.Magnitude);
    maxStress = max(R.VonMisesStress);
    FOS = yieldStrength(idx) ./ maxStress;

    % Store the results in a struct for later access
    results(idx).DesignName = designName;
    results(idx).MaterialName = materialNames(idx);
    results(idx).Solution = R;
    results(idx).MaximumDisplacement = maxDisplacement;
    results(idx).MaximumVonMisesStress = maxStress;
    results(idx).FOS = FOS;


end

end