#' trawl survey apportionment data query
#'
#' @param year assessment year
#' @param area default is "goa"
#' @param afsc_species afsc species code(s)
#' @param afsc  the database to query
#' @param save save the file in designated folder
#'
#' @return
#' @export
#'
#' @examples
q_ts_app <- function (year, area = "goa", afsc_species, afsc, save = TRUE){

  files <- grep("_ts",
                list.files(system.file("sql", package = "gfdata")), value=TRUE)

  .app = sql_read(files[4])

  if(length(afsc_species) == 1){
    if(afsc_species == 20510){
      .app = sql_read(files[9])
    } else {
      .app = sql_read(files[1])
    }}


  if(length(afsc_species) == 1){
    .app = sql_filter(x = afsc_species, sql_code = .app, flag = "-- insert species")
  } else {
    .app = sql_filter(sql_precode = "IN", x = afsc_species,
                      sql_code = .app, flag = "-- insert species")
  }

  if(isTRUE(save)){
    sql_run(afsc, .app) %>%
      write.csv(here::here(year, "data", "raw", paste0(area, "_ts_apportion_data.csv")),
                row.names = FALSE)
  } else {
    sql_run(afsc, .app)
  }
}


