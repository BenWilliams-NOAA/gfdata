SELECT to_char(haul_join)
AS haul_join
FROM norpac.debriefed_age_mv
WHERE fmp_area
        -- insert region
AND species
        -- insert species
