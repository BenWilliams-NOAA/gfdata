#' longline survey biomass data query
#'
#' @param year
#' @param area
#' @param afsc_species
#' @param akfin
#' @param save
#'
#' @return
#' @export
#'
#' @examples
q_lls_biomass <- function (year, area = "goa", afsc_species, akfin, save = TRUE){

  area = tolower(area)

  files <- grep(paste0(area,"_lls"),
                list.files(system.file("sql", package = "gfdata")), value=TRUE)

  .bio = sql_read(files[1])

  if(length(afsc_species) == 1){
    .bio = sql_filter(x = afsc_species, sql_code = .bio, flag = "-- insert species")

  } else {
    .bio = sql_filter(sql_precode = "IN", x = afsc_species,
                      sql_code = .bio, flag = "-- insert species")
  }

  if(isTRUE(save)){
    sql_run(akfin, .bio) %>%
      vroom::vroom_write(here::here(year, "data", "raw", paste0(area, "_lls_biomass_data.csv")), delim = ",")
  } else {
    sql_run(akfin, .bio)
  }
}
