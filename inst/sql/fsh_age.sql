SELECT year,
  fmp_area,
  species,
  length,
  weight,
  age,
  specimen_type,
  performance
FROM norpac.debriefed_age_mv
WHERE area
        -- insert region
AND species
        -- insert species