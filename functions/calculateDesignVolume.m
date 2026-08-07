function [volumes] = calculateDesignVolume(filePaths)
%CALCULATEDESIGNVOLUME function takes the file paths of .STL or .STEP
%files, generates a pde model and mesh, and calculates and returns the
%total volume of the object.
%   Inputs: 
%       filePaths:  contains an array with the file path for each design
%   Outputs:
%       volumes: outputs the volumes of each design in m^3
arguments
    filePaths string

end

nPaths = numel(filePaths);
volumes = zeros(1, nPaths);
for designIdx = 1:nPaths
    model = createpde;
    importGeometry(model, filePaths(designIdx));
    mesh = generateMesh(model);
    volumes(designIdx) = volume(mesh);
end

end