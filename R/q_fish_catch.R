#' fishery catch data query
#'
#' @param year assessment year
#' @param fishery default is fsh, change if age comps from multiple fisheries
#' @param species group species code
#' @param area goa or bsai
#' @param akfin the database to query
#' @param save save the file in designated folder
#'
#' @return
#' @export q_fish_catch
#'
#' @examples
#'\dontrun{q_fish_catch(year, fishery = "fsh", species, area, akfin, save = TRUE)
#'}
q_fish_catch <- function(year, fishery = "fsh", species, area = "goa", akfin, save = TRUE){

  area = toupper(area)
  # get appropriate age compe query data for a specific fishery
  # e.g., ("fsh1", "fsh2")

  .c = sql_read("fsh_catch.sql")

  .c = sql_filter(sql_precode = "<=", year, sql_code = .c, flag = "-- insert year")
    if(length(area) > 1){
    .c = sql_filter(sql_precode = "IN", x = area, sql_code = .c, flag = "-- insert region")
    } else {
      .c = sql_filter(x = area, sql_code = .c, flag = "-- insert region")
    }
    if(length(species) > 1){
      .c = sql_filter(sql_precode = "IN", x = species, sql_code = .c, flag = "-- insert species")
    }
    .c = sql_filter(x = species, sql_code = .c, flag = "-- insert species")


  if(isTRUE(save)){

  sql_run(akfin, .c) %>%
    write.csv(here::here(year, "data", "raw", paste0(fishery, "_catch_data.csv")),
              row.names = FALSE)
  } else {
    catch <- sql_run(akfin, .c)
  }
}

