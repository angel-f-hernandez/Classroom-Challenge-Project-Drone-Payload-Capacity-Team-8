function [names, rho, E, nu, yieldStrength, cost] = materialDataExtractor(materials)
% MATERIALDATAEXTRACTOR Extracts material properties from a struct array
%
% Inputs:
%   materials - struct with array fields
%       name                - Name of material as a string
%       rho_kg_m3           - Density in kg/m3 
%       E_Pa                - Young's modulus in Pascals
%       nu                  - Poissons Ratio
%       yieldStrength_Pa    - Yield strength in Pascals
%       cost_USD_per_m      - cost in USD per meter
% Outputs: 
%   names           - string array of material names
%   rho             - density array
%   E               - Young's modulus array
%   nu              - Poissons array
%   yieldStrength  - Yield strength array
%   cost            - cost array

arguments
    materials (1, :) struct

end



nMaterials = numel(materials);

names = strings(nMaterials, 1);
rho = zeros(nMaterials, 1);
E = zeros(nMaterials, 1);
nu = zeros(nMaterials, 1);
yieldStrength = zeros(nMaterials, 1);
cost = zeros(nMaterials, 1);

for idx = 1:nMaterials
    item = materials(idx);
    names(idx) = string(item.name);
    rho(idx) = item.rho_kg_m3;
    E(idx) = item.E_Pa;
    nu(idx) = item.nu;
    yieldStrength(idx) = item.yieldStrength_Pa;
    cost(idx) = item.cost_USD_per_m;


end
end
