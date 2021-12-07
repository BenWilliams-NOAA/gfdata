SELECT survey,
    summary_depth,
    year,
    species_code,
    haul_count,
    catch_count,
    mean_wgt_cpue,
    var_wgt_cpue,
    mean_num_cpue,
    var_num_cpue,
    area_biomass,
    biomass_var,
    min_biomass,
    max_biomass,
    area_pop,
    pop_var
FROM goa.biomass_depth
WHERE species_code
    -- insert species

