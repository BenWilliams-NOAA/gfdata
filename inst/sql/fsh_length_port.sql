SELECT to_char(port_join)
AS port_join
FROM norpac.debriefed_length_mv
WHERE fmp_area
          -- insert region
AND species
          -- insert species
