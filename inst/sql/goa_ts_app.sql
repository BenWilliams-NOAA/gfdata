SELECT survey,
  year,
  regulatory_area_name,
  species_code,
  area_biomass,
  biomass_var
FROM goa.biomass_area
WHERE species_code
  -- insert species
