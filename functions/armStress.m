function [maxStress, FOS] = armStress(design, dims, F_tip, yieldStrength)
% INPUTS:
% design:        "oval" or "truss"
% dims:          struct of dimensions
%                oval: L = length, W = width, H = height, t = thickness
%                truss: L = length, H = height, d = member dimension, nBays = number of bays
% F_tip:         net transverse tip force [N]
% yieldStrength: material yield strength [Pa]
%
% OUTPUTS:
% maxStress: estimated peak stress [Pa]
% FOS: factor of safety = yieldStrength / maxStress

switch design
    case "oval"
        maxStress = ovalBendingStress(dims, F_tip);
    case "truss"
        maxStress = trussChordStress(dims, F_tip);
end

FOS = yieldStrength / maxStress;
end


function sigMax = ovalBendingStress(dims, F_tip)
%   Vertical tip load: bending about the horizontal centroidal axis.
mm = 1e-3;
L = dims.L*mm;  W = dims.W*mm;  H = dims.H*mm;  t = dims.t*mm;

a  = W/2;    b  = H/2;      % outer semi-axes (a horizontal, b vertical)
ai = a - t;  bi = b - t;    % inner semi-axes

% Second moment of area of a hollow ellipse about the horizontal axis:
I = (pi/4) * (a*b^3 - ai*bi^3);   % [m^4]
c = b;                            % distance to extreme (top/bottom) [m]

M = F_tip * L;                    % cantilever root moment [N*m]
sigMax = M * c / I;               % [Pa]
end


function sigMax = trussChordStress(dims, F_tip)
%   Peak chord axial stress in a truss cantilever [Pa].
%   Root moment is carried as a tension/compression couple in the two chords,
%   separated by the truss height H. Chord force = M / H.
mm = 1e-3;
L = dims.L*mm;  H = dims.H*mm;  d = dims.d*mm;

A = d^2;                 % member cross-sectional area (square section) [m^2]
M = F_tip * L;           % root moment [N*m]
F_chord = M / H;         % axial force in a chord [N]
sigMax = F_chord / A;    % axial stress [Pa]
end