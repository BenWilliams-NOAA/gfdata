SELECT year,
  country,
  vessel_number,
  vessel_name,
  cruise_number,
  area_code,
  geographic_area_name,
  council_sablefish_mgmt_area,
  species_code,
  common_name,
  sex,
  length,
  length_frequency,
  akfin_load_date
FROM afsc.length_frequencies
WHERE species_code
  -- insert species
AND country != 'Japan'
