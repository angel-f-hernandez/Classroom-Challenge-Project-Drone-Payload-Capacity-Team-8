function [] = generateGraphsFEA(results)
%GENERATEGRAPHSFEA 

arguments
    results (:,1) struct
end

nResults = numel(results);

for idx = 1:nResults
    designName = results(idx).DesignName;
    materialName = results(idx).MaterialName;
    solution = results(idx).Solution;
    
    figureName = compose("%s - %s Results", designName, materialName);
    figure("Name", figureName)
    
    tiledlayout(2, 2)
    sgtitle(figureName)

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