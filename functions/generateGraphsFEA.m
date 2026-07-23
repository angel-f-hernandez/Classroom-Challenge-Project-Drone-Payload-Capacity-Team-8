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
        ColorMapData=solution.Displacement.ux, ...
        Deformation=solution.Displacement)
    title("x-Displacement (m)")
    
    nexttile
    pdeplot3D(solution.Mesh, ...
        ColorMapData=solution.Displacement.uy, ...
        Deformation=solution.Displacement)
    title("y-Displacement (m)")
    
    nexttile
    pdeplot3D(solution.Mesh, ...
        ColorMapData=solution.Displacement.uz, ...
        Deformation=solution.Displacement)
    title("z-Displacement (m)")

    nexttile
    pdeplot3D(solution.Mesh, ...
        ColorMapData=solution.VonMisesStress, ...
        Deformation=solution.Displacement)
    title("Von Mises Stress (Pa)")
end

end