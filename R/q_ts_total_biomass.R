#' trawl survey biomass data query
#'
#' @param year assessment year
#' @param area corresponds to the survey e.g. 'GOA', 'AI', 'EBSSHELF', 'EBSSLOPE',future dev: 'EBSSHELF_PLUSNW', 'EBS_SHELF_STANDARD', etc.
#' @param afsc_species afsc species code(s)
#' @param akfin  the database to query
#' @param save save the file in designated folder
#'
#' @return
#' @export
#'
#' @examples
q_ts_total_biomass <- function (year, area = "GOA", afsc_species, akfin, save = TRUE){

  files <- grep("ts_total_biomass",
                list.files(system.file("sql", package = "gfdata")), value=TRUE)
  files <- grep(tolower(area), files, value=TRUE)
  .bio = sql_read(files[1])

  if(area %in% c("GOA", "AI")) {
    .bio = sql_filter(x = area, sql_code = .bio, flag = "-- insert area")
  }

  if(length(afsc_species) == 1) {
    .bio = sql_filter(x = afsc_species, sql_code = .bio, flag = "-- insert species")
  } else {
    .bio = sql_filter(sql_precode = "IN", x = afsc_species,
                      sql_code = .bio, flag = "-- insert species")
  }

  if(isTRUE(save)){
    sql_run(akfin, .bio) %>%
      write.csv(here::here(year, "data", "raw", paste0(tolower(area), "_ts_total_biomass_data.csv")),
                row.names = FALSE)
  } else {
    sql_run(akfin, .bio)
  }
}


