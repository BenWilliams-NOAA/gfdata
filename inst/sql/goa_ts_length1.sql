SELECT survey,
 year,
 species_code,
 length,
 males,
 females,
 unsexed,
 total
 FROM goa.sizecomp_total
 WHERE species_code
   -- insert species
