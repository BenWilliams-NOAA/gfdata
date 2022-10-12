#' query prohibited species catch estimate
#'
#' @param year assessment year
#' @param trip_target 'p' = pollock-mid, 'b' = pollock-bottom, 'x' = rex, 'h' = shallow flats, 'k' = rockfish, 'w' = arrowtooth, 'c' = pcod, 'i' = halibut
#' @param area goa or bsai
#' @param akfin the database to query
#' @param save save the file in designated folder
#'
#' @return
#' @export
#' @description prohibited species catch (PSC) estimates reported in tons for halibut and herring and counts for salmon and crabs and other fish
#' @examples
#' \dontrun{
#'
#' akfin = DBI::dbConnect(odbc::odbc(), "akfin", UID = akfin_user, PWD = akfin_pwd)

#' q_psc(year=2022, trip_target="k", area="goa", afkin, save=FALSE) %>%
#'
#' }
#'
q_psc <- function(year, trip_target, area, akfin, save = TRUE) {
  area = toupper(area)
  trip_target = toupper(trip_target)

  psc = sql_read("psc.sql")

  psc = sql_filter(sql_precode = "", x = year-4, sql_code = psc, flag = "-- insert year")
  psc = sql_filter(sql_precode = "", x = year, sql_code = psc, flag = "-- year2")

  if(length(area) == 1){
    psc = sql_filter(x = area, sql_code = psc, flag = "-- insert region")
  } else {
    psc = sql_filter(sql_precode = "IN", x = toupper(area),
                      sql_code = psc, flag = "-- insert region")
  }

  if(length(trip_target) == 1){
    psc = sql_filter(x = trip_target, sql_code = psc, flag = "-- insert species")
  } else {
    psc = sql_filter(sql_precode = "IN", x = trip_target,
                      sql_code = psc, flag = "-- insert species")
  }

  if(isTRUE(save)){
      sql_run(akfin, psc) %>%
        dplyr::rename_all(tolower) %>%
        tidyr::pivot_wider(names_from = year, values_from = psc) %>%
        write.csv(here::here(year, "data", "output", "psc_catch.csv"),
                  row.names = FALSE)
  } else {
    sql_run(akfin, psc)
  }
}

