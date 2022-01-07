SELECT year,
  fmp_area,
  fmp_gear,
  species,
  length,
  weight,
  age,
  specimen_type,
  performance
FROM norpac.debriefed_age_mv
WHERE fmp_area
        -- insert region
AND species
        -- insert species
