SELECT norpac.debriefed_spcomp_mv.year,
  norpac.debriefed_spcomp_mv.haul_date,
  norpac.debriefed_spcomp_mv.species,
  norpac.debriefed_haul_mv.fmp_area,
  norpac.debriefed_haul_mv.gear_type,
  norpac.debriefed_spcomp_mv.extrapolated_weight
FROM norpac.debriefed_spcomp_mv
INNER JOIN norpac.debriefed_haul_mv
ON norpac.debriefed_spcomp_mv.join_key = norpac.debriefed_haul_mv.join_key
WHERE norpac.debriefed_spcomp_mv.year
BETWEEN
-- insert year
AND
-- year2
AND norpac.debriefed_haul_mv.fmp_area
-- insert region
AND norpac.debriefed_spcomp_mv.species
-- insert species
