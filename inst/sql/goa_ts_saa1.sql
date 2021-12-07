SELECT *
FROM(racebase.haul
  INNER JOIN racebase.specimen
  ON racebase.haul.hauljoin = racebase.specimen.hauljoin)
INNER JOIN goa.biennial_surveys
ON racebase.specimen.cruisejoin = goa.biennial_surveys.cruisejoin
WHERE (racebase.specimen.species_code
  -- insert species
AND (racebase.specimen.region = 'GOA')
AND (racebase.haul.performance >= 0))
