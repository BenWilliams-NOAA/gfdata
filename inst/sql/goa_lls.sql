SELECT *
FROM afsc.lls_area_rpn_all_strata
WHERE species_code
  -- insert species
AND country = 'United States'
AND council_sablefish_management_area_id >= 3

