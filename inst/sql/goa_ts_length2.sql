SELECT racebase.length.cruise,
    goa.biennial_surveys.year,
    racebase.length.hauljoin,
    racebase.length.cruisejoin,
    racebase.length.species_code,
    racebase.length.frequency,
    racebase.length.length,
    racebase.length.sex,
    racebase.length.region,
    racebase.haul.performance,
    racebase.haul.stratum
FROM racebase.haul
INNER JOIN racebase.length
ON racebase.haul.hauljoin = racebase.length.hauljoin
INNER JOIN goa.biennial_surveys
ON racebase.length.cruisejoin = goa.biennial_surveys.cruisejoin
WHERE racebase.length.species_code
    -- insert species
AND racebase.length.region = 'GOA'
 AND racebase.haul.performance >=0
