SELECT year,
  fmp_area,
  fmp_gear,
  species,
  length,
  frequency,
  performance
FROM norpac.debriefed_length_mv
WHERE fmp_area
        -- insert region
AND species
        -- insert species
