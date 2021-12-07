SELECT survey,
  survey_year,
  species_code,
  sex,
  age,
  agepop,
  mean_length,
  standard_deviation
FROM goa.agecomp_total
WHERE species_code
  -- insert species
