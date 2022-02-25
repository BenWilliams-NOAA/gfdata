SELECT
    survey,
    year,
    stratum,
    species_code,
    haul_count,
    catch_count,
    mean_wgt_cpue,
    var_wgt_cpue,
    mean_num_cpue,
    var_num_cpue,
    stratum_biomass,
    biomass_var,
    min_biomass,
    max_biomass,
    stratum_pop,
    pop_var,
    min_pop,
    max_pop
FROM
    afsc.race_biomassstratumaigoa
WHERE species_code
  -- insert species
AND survey
 -- insert area
