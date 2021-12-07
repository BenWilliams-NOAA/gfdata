SELECT year,
  survey,
  area_id,
  area,
  species_code,
  common_name,
  cpue,
  rpn,
  rpw,
  akfin_load_date
FROM afsc.web_areas
WHERE species_code
  -- insert species
