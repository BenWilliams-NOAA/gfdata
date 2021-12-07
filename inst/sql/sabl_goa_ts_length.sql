SELECT survey,
    summary_depth,
    year,
    species_code,
    length,
    males,
    females,
    unsexed,
    total
    FROM goa.sizecomp_depth
WHERE species_code
    -- insert species
