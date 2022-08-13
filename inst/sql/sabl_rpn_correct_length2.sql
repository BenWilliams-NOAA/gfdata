SELECT
DISTINCT council_sablefish_management_area,
          council_management_area,
          fmp_management_area,
          geographic_area_name,
          exploitable
FROM  afsc.lls_area_view
WHERE exploitable = 1
