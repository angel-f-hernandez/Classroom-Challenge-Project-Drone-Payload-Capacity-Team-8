function [results] = droneArmFEA(filePaths, areas, fixedFaces, loadedFaces, designNames, materialNames, youngsModulus, poissonsRatio, density, yieldStrength)
% droneArmFEA: performs FEA for each of the materials provided on a
% specified drone arm and outputs the results as a struct which stores the
% name of the material and the StaticStructuralResults objects of the test.
% 
% INPUTS:
%   filePath:      a string containing the file path to the STL/STEP file
%   areas:         stores the areas of the different designs
%   fixedFaces     stores the id of the fixed face of each design
%   loadedFaces    stores the id of the loaded face of each design
%   designNames:   contains the strings of the different design names
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
    filePaths string
    areas (:, 1) double
    fixedFaces (:, 1) cell
    loadedFaces (:, 1) cell
    designNames (:,1) string
    materialNames (:, 1) string
    youngsModulus (:, 1) double
    poissonsRatio (:, 1) double
    density (:, 1) double
    yieldStrength (:, 1) double
end

% Gets the total number of properties + designs
nMaterialNames = numel(materialNames);
nDesigns = numel(filePaths);

% Checks to ensure all provided material properties are of the same size
if numel(designNames) ~= nDesigns || ...
        numel(areas) ~= nDesigns || ...
        numel(fixedFaces) ~= nDesigns || ...
        numel(loadedFaces) ~= nDesigns

    error("Each design must have one name, area, fixed-face entry, and loaded-face entry.")
end

% Define gravity

g = 9.81;   % m/s^2

% Preallocate storage for material names and solution objects

nResults = nDesigns * nMaterialNames;
results(nResults, 1) = struct( ...
    "DesignName" , "",...
    "MaterialName", "", ...
    "Solution", [], ...
    "MaximumDisplacement", [], ...
    "MaximumVonMisesStress", [], ...
    "FOS", []);

% Calculate load on object in Newtons
motorThrustN = 1 * g;        % Newtons
motorWeightN = 0.065 * g;    % Newtons


for idxDesign = 1 : nDesigns
    % loads the fixed, loaded, and face area to memory
    fixedFacesID = fixedFaces{idxDesign};
    loadedFaceID = loadedFaces{idxDesign};
    faceArea = areas(idxDesign) * numel(loadedFaceID);
    
    % Convert load into surface traction (N/m^2)
    netMotorTraction = (motorThrustN - motorWeightN) / faceArea; % N/m^2
    
    % Model for FEA is generated
    model = femodel("AnalysisType","structuralStatic", "Geometry", filePaths(idxDesign));

    % Generate the mesh and run the simulation
    model = generateMesh(model);

    
    % Boundary conditions/applied loads are configured on the model
    model.FaceLoad(loadedFaceID) = faceLoad(SurfaceTraction = [0; 0; netMotorTraction]);
    model.FaceBC(fixedFacesID) = faceBC(Constraint='fixed');
    model.CellLoad = cellLoad(Gravity=[0, 0, -g]);

    % Loop that iterates over each material
    for idxMaterials = 1:nMaterialNames

        resultIndex = (idxDesign - 1) * nMaterialNames + idxMaterials;
    
        % Material properties are loaded into the model
        model.MaterialProperties.YoungsModulus = youngsModulus(idxMaterials);
        model.MaterialProperties.PoissonsRatio = poissonsRatio(idxMaterials);
        model.MaterialProperties.MassDensity = density(idxMaterials);
        
        % Solve the model
        R = solve(model);

        % Find maximum stress, displacement, and also calculate FOS
        maxDisplacement = max(R.Displacement.Magnitude);
        maxStress = max(R.VonMisesStress);
        FOS = yieldStrength(idxMaterials) ./ maxStress;
    
        % Store the results in a struct for later access
        results(resultIndex).DesignName = designNames(idxDesign);
        results(resultIndex).MaterialName = materialNames(idxMaterials);
        results(resultIndex).Solution = R;
        results(resultIndex).MaximumDisplacement = maxDisplacement;
        results(resultIndex).MaximumVonMisesStress = maxStress;
        results(resultIndex).FOS = FOS;
    
    
    end
end
end