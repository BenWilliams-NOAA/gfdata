#' trawl survey biomass data query
#'
#' @param year assessment year
#' @param area default is "goa"
#' @param afsc_species afsc species code(s)
#' @param shelf_slope if the area is the Bering Sea this default designated "shelf" alternate is "slope"
#' @param depth defaut is NULL, otherwise queries data by depth
#' @param stratum defaut is NULL, otherwise queries data by stratum
#' @param akfin  the database to query
#' @param save save the file in designated folder, if FALSE outputs to global environment
#'
#' @return
#' @export
#'
#' @examples
q_ts_biomass <- function (year, area = "goa", afsc_species, shelf_slope = "shelf", depth = NULL, stratum = NULL, akfin, save = TRUE){

  area = toupper(area)
  shelf_slope = toupper(shelf_slope)

  if(area == "BS" & shelf_slope == "SHELF"){
    message("you are querying the Bering Sea shelf, change shelf_slope = 'slope' to get slope results")
  }

  if(is.null(depth) & is.null(stratum)){
    files = grep('tot_ts',
                 list.files(system.file("sql", package = "gfdata")), value=TRUE)
    id1 = "_tot_"

  } else if(!is.null(depth) & is.null(stratum)){
    files = grep('depth_ts',
                 list.files(system.file("sql", package = "gfdata")), value=TRUE)
    id1 = "_depth_"

  } else {
    files = grep('stratum_ts',
                 list.files(system.file("sql", package = "gfdata")), value=TRUE)
    id1 = "_stratum_"
  }

  # FUTURE - can add BS by depth or strata switches
  if(area=="BS"){
    files = grep("bs", files, value=TRUE)
    if(shelf_slope=="shelf"){
      file = grep("shelf", files, value=TRUE)
      id = "bsshelf"
    } else {
      file = grep("slope", files, value=TRUE)
      id = "bsslope"
    }
  } else {
    file = grep("aigoa", files, value=TRUE)
    id = tolower(area)
  }

  .bio = sql_read(file)


  if(length(afsc_species) == 1){
    .bio = sql_filter(x = afsc_species, sql_code = .bio, flag = "-- insert species")
  } else {
    .bio = sql_filter(sql_precode = "IN", x = afsc_species,
                      sql_code = .bio, flag = "-- insert species")
  }

  if(area!="BS"){
    .bio = sql_filter(x = area, sql_code = .bio, flag = "-- insert area")
  }

  if(isTRUE(save)){
    sql_run(akfin, .bio) %>%
      vroom::vroom_write(here::here(year, "data", "raw", paste0(id, id1, "ts_biomass_data.csv")),
                         delim = ",")
  } else {
    sql_run(akfin, .bio)
  }
}


