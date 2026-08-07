function [] = generateGraphsFEA(results)
%GENERATEGRAPHSFEA generates x- displacement, y- displacement, z-
%displacement and Von Mises Stress from the results generated in
%droneArmFEA.m
% Inputs:
%   results: struct containing FEA simulation result data

arguments
    results (:,1) struct
end

nResults = numel(results);

for idx = 1:nResults
    % Allocating variables
    designName = results(idx).DesignName;
    materialName = results(idx).MaterialName;
    solution = results(idx).Solution;
    
    % Creates tiled figure
    figureName = compose("%s - %s Results", designName, materialName);
    figure("Name", figureName)
    
    tiledlayout(2, 2)
    sgtitle(figureName)
    
    % Generates x-, y-, z- displacement and Von Mises stress graphs   
    nexttile
    pdeplot3D(solution.Mesh, ...
        ColorMapData=solution.Displacement.ux * 1000, ...
        Deformation=solution.Displacement)
    title("x-Displacement")
    cb = colorbar;
    cb.Label.String = "Displacement (mm)";
    
    nexttile
    pdeplot3D(solution.Mesh, ...
        ColorMapData=solution.Displacement.uy * 1000, ...
        Deformation=solution.Displacement)
    title("y-Displacement")
    cb = colorbar;
    cb.Label.String = "Displacement (mm)";
    
    nexttile
    pdeplot3D(solution.Mesh, ...
        ColorMapData=solution.Displacement.uz* 1000, ...
        Deformation=solution.Displacement)
    title("z-Displacement ")
    cb = colorbar;
    cb.Label.String = "Displacement (mm)";

    nexttile
    pdeplot3D(solution.Mesh, ...
        ColorMapData=solution.VonMisesStress / 1e6, ...
        Deformation=solution.Displacement)
    title("Von Mises Stress")
    cb = colorbar;
    cb.Label.String = "Stress (MPa)";
end

end