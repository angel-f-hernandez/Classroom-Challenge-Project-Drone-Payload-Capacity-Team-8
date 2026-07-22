function [armMass, maxPayload, armVolume] = armAnalysis(design, dims, density, params)

% --- Arm volume [m^3] based on design geometry ---
switch design
    case "oval"
        armVolume = ovalVolume(dims);
    case "truss"
        armVolume = trussVolume(dims);
end

% --- Arm mass [kg] ---
armMass = armVolume * density;

% --- Max payload [kg] from the thrust-to-weight constraint ---
%   T/W >= TWmin  ==>  totalDroneMass <= maxTotalThrust_kg / TWmin
%   totalDroneMass = baseMass + nArms*armMass + payload
%   => maxPayload  = maxTotalThrust_kg/TWmin - baseMass - nArms*armMass
allowableTotalMass = params.maxTotalThrust_kg / params.TWmin;
maxPayload = allowableTotalMass - params.baseMass - params.nArms * armMass;
end

function V = ovalVolume(dims)
%OVALVOLUME  Hollow elliptical (oval) tube. dims in MM. Returns V in m^3.
mm = 1e-3;
L = dims.L*mm;  W = dims.W*mm;  H = dims.H*mm;  t = dims.t*mm;

a  = W/2;   b  = H/2;      % outer semi-axes
ai = a - t; bi = b - t;    % inner semi-axes (uniform wall)

A = pi*(a*b - ai*bi);      % cross-sectional area [m^2]
V = A * L;                 % [m^3]
end


function V = trussVolume(dims)
%   Planar triangular truss
%   dims in MM. Returns V in m^3.
%   Model: 2 chords (top + bottom, each length L) + one diagonal per bay.
mm = 1e-3;
L = dims.L*mm;  H = dims.H*mm;  d = dims.d*mm;  nBays = dims.nBays;

memberArea  = d^2;                       % square section [m^2] (circular: pi*d^2/4)
bayLength   = L / nBays;
diagLength  = hypot(bayLength, H);       % one diagonal spans one bay
totalLength = 2*L + nBays*diagLength + 2*H;   % 2 chords + diagonals + 2 endposts
V = memberArea * totalLength;
end