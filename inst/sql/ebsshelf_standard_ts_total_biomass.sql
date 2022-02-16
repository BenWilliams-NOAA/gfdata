SELECT survey,
  year,
  species_code,
  haulcount as haul_count,
  catcount as catch_count,
  meanwgtcpue as mean_wgt_cpue,
  varmnwgtcpue as var_wgt_cpue,
  meannumcpue as mean_num_cpue,
  varmnnumcpue as var_num_cpue,
  biomass as total_biomass,
  varbio as biomass_var,
  lowerb as min_biomass,
  upperb as max_biomass,
  population as total_pop,
  varpop as pop_var
FROM afsc.race_biomass_ebsshelf_standard
WHERE species_code
  -- insert species
  and
  stratum in ('999') -- code for 'all strata combined'
