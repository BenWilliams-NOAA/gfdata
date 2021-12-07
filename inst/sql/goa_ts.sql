SELECT survey,
  year,
  species_code,
  haul_count,
  catch_count,
  mean_wgt_cpue,
  var_wgt_cpue,
  mean_num_cpue,
  var_num_cpue,
  total_biomass,
  biomass_var,
  min_biomass,
  max_biomass,
  total_pop,
  pop_var
FROM goa.biomass_total
WHERE species_code
  -- insert species
