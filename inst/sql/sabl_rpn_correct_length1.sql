SELECT    *
FROM      afsc.lls_length_rpn_by_area_3_to_7_depred
WHERE     country = 'United States'
AND       year >= 1990
AND       council_sablefish_management_area NOT IN ('Bering Sea', 'Aleutians')
AND       length BETWEEN 40 AND 900
