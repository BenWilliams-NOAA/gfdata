#' fishery age comp data query
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
q_fish_age_comp <- function(year, fishery = "fsh", norpac_species, area, akfin, save = TRUE){

  area = toupper(area)
  # get appropriate age compe query data for a specific fishery
  # e.g., ("fsh1", "fsh2")

files <- grep(paste0(fishery,"_age"),
              list.files(system.file("sql", package = "gfdata")), value=TRUE)

  .age = sql_read(files[1])
  .age = sql_filter(x = area, sql_code = .age, flag = "-- insert region")


if(length(norpac_species) == 1){

    .age = sql_filter(x = norpac_species, sql_code = .age, flag = "-- insert species")

  } else {

    .age = sql_filter(sql_precode = "IN", x = norpac_species,
                      sql_code = .age, flag = "-- insert species")
  }

  if(isTRUE(save)){
  sql_run(akfin, .age) %>%
            write.csv(here::here(year, "data", "raw", paste0(fishery, "_age_comp_data.csv")),
            row.names = FALSE)
  } else {
    sql_run(akfin, .age)
  }
}

