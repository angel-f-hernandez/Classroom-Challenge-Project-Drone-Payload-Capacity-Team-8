function [names, rho, E, nu, yield_strength, cost] = material_data_extractor(materials)
% MATERIAL_DATA_EXTRACTOR Extracts material properties from a struct array
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
%   yield_strength  - Yield strength array
%   cost            - cost array

arguments
    materials (1, :) struct

end



material_size = numel(materials);

names = strings(material_size, 1);
rho = zeros(material_size, 1);
E = zeros(material_size, 1);
nu = zeros(material_size, 1);
yield_strength = zeros(material_size, 1);
cost = zeros(material_size, 1);

for idx = 1:material_size
    item = materials(idx);
    names(idx) = string(item.name);
    rho(idx) = item.rho_kg_m3;
    E(idx) = item.E_Pa;
    nu(idx) = item.nu;
    yield_strength(idx) = item.yieldStrength_Pa;
    cost(idx) = item.cost_USD_per_m;


end
end
