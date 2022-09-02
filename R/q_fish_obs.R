#' fishery observer data query
#'
#' @param year assessment year
#' @param fishery default is fsh, change if age comps from multiple fisheries
#' @param norpac_species norpac species code
#' @param area goa or bsai
#' @param akfin the database to query
#' @param save save the file in designated folder
#'
#' @return
#' @export
#'
#' @examples
#'
q_fish_obs <- function(year, fishery = "fsh", norpac_species, area, akfin, save = TRUE){

  area = toupper(area)
  file <- grep(paste0(fishery,"_obs"),
               list.files(system.file("sql", package = "gfdata")), value=TRUE)

  .obs = sql_read(file)
  .obs = sql_filter(sql_precode = "", x = year-3, sql_code = .obs, flag = "-- insert year")
  .obs = sql_filter(sql_precode = "", x = year-1, sql_code = .obs, flag = "-- year2")

  if(length(area) == 1){
    .obs = sql_filter(x = area, sql_code = .obs, flag = "-- insert region")
  } else {
    .obs = sql_filter(sql_precode = "IN", x = toupper(area),
                      sql_code = .obs, flag = "-- insert region")
  }

  if(length(norpac_species) == 1){
    .obs = sql_filter(x = norpac_species, sql_code = .obs, flag = "-- insert species")
  } else {
    .obs = sql_filter(sql_precode = "IN", x = norpac_species,
                      sql_code = .obs, flag = "-- insert species")
  }

  if(isTRUE(save)){
    sql_run(akfin, .obs) %>%
      write.csv(here::here(year, "data", "raw", paste0(fishery, "_obs_data.csv")),
                row.names = FALSE)
  } else {
    sql_run(akfin, .obs)
  }


}
