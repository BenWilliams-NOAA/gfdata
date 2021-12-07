
SELECT year,
        species_group_name,
        species_group_code,
        agency_gear_code,
        trip_target_code,
        fmp_gear,
        fmp_area,
        fmp_subarea,
        week_end_date,
        weight_posted
FROM council.comprehensive_blend_ca
WHERE fmp_area
        -- insert region
AND year
        -- insert year
AND species_group_code
        -- insert species
