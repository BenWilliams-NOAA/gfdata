SELECT survey,
  year,
  species_code,
  haul_count,
  catch_count,
  mean_wgt_cpue,
  var_wgt_cpue,
  mean_num_cpue,
  var_num_cpue,
  stratum_biomass as total_biomass,
  bio_var as biomass_var,
  min_biomass,
  max_biomass,
  stratum_pop as total_pop,
  pop_var
FROM afsc.race_biomass_ebsslope
WHERE species_code
  -- insert species
  and
  stratum in ('999999') -- code for 'all strata combined'
