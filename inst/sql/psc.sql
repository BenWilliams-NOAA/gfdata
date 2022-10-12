SELECT
  year,
  species_group_name,
  round(sum(pscnq_estimate),3) psc
from council.comprehensive_psc
where year
  between
  -- insert year
  and
  -- year2
and trip_target_code
  -- insert species
and fmp_area
  -- insert region
group by species_group_name, year
order by species_group_name, year;
