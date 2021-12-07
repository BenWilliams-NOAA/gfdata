SELECT year,
  fmp_area,
  species,
  length,
  frequency,
  performance
FROM norpac.debriefed_length_mv
WHERE fmp_area
        -- insert region
AND species
        -- insert species
