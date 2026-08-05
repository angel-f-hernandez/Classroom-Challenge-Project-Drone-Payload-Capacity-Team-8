function [] = designVisualizer(filePaths)
%DESIGNVISUALIZER used to generate 3d images of designs stored in an STL or
%STEP file in order to determine the id of fixed and loaded faces


arguments
    filePaths string

end

nPaths = numel(filePaths);

for designIdx = 1:nPaths
    figure(designIdx)
    clf

    model = femodel("Geometry", filePaths(designIdx));
    model = generateMesh(model);
    pdegplot(model,"FaceAlpha",0.2,"FaceLabels","on")
    title(filePaths(designIdx), "Interpreter", "none")
end
