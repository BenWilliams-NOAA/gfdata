SELECT racebase.specimen.cruise,
  goa.biennial_surveys.year,
  racebase.specimen.hauljoin,
  racebase.specimen.cruisejoin,
  racebase.specimen.species_code,
  racebase.specimen.specimenid,
  racebase.specimen.length,
  racebase.specimen.sex,
  racebase.specimen.age,
  racebase.specimen.weight,
  racebase.specimen.region,
  racebase.haul.performance
FROM (racebase.haul
INNER JOIN racebase.specimen
ON racebase.haul.hauljoin = racebase.specimen.hauljoin)
INNER JOIN goa.biennial_surveys
ON racebase.specimen.cruisejoin = goa.biennial_surveys.cruisejoin
WHERE racebase.specimen.species_code
  -- insert species
AND racebase.specimen.region = 'GOA'
AND racebase.haul.performance >= 0
