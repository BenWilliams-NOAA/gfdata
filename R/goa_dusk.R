#' raw data query for GOA dusky rockfish
#'
#' The catch if dusky rockfish is a combination of catch of dusky rockfish and pelagic rockfish (prior to 2012).
#' @param year assessment year
#' @param akfin_user user name
#' @param akfin_pwd user password
#' @param afsc_user user name
#' @param afsc_pwd user password
#' @param off_yr if this is an off-year assessment change to TRUE
#'
#' @return
#' @export goa_dusk
#'
#' @examples
#' \dontrun{
#' goa_disk(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd)
#' }
goa_dusk <- function(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd, off_yr = NULL){

  # globals ----
  species = "DUSK"
  area = "goa"
  afsc_species1 =  30150
  afsc_species2 = 30152
  norpac_species = 330

if(!is.null(off_yr)){
  # establish akfin connection
  akfin = DBI::dbConnect(odbc::odbc(), "akfin",
                          UID = akfin_user, PWD = akfin_pwd)
  # catch
  # catch
  .c = .d = sql_read("fsh_catch.sql")
  .c = sql_filter(sql_precode = ">=", 2012, sql_code = .c, flag = "-- insert year")
  .c = sql_filter(x = area, sql_code = .c, flag = "-- insert region")
  .c = sql_filter(x = species, sql_code = .c, flag = "-- insert species")

  .d = sql_filter(sql_precode = "<=", 2011, sql_code = .d, flag = "-- insert year")
  .d = sql_filter(x = area, sql_code = .d, flag = "-- insert region")
  .d = sql_filter(sql_precode = "IN", x = c("PEL7", "PELS"), sql_code = .d, flag = "-- insert species")

  sql_run(akfin, .c) %>%
    dplyr::bind_rows(sql_run(akfin, .d)) %>%
    vroom::vroom_write(here::here(year, "data", "raw", "fsh_catch_data.csv"))
  q_fish_obs(year = year, norpac_species = norpac_species, area = area, akfin = akfin)

  DBI::dbDisconnect(akfin)

  afsc = DBI::dbConnect(odbc::odbc(), "afsc",
                      UID = afsc_user, PWD = afsc_pwd)

  q_ts_biomass(year, area = "goa", afsc_species = c(afsc_species1, afsc_species2), afsc = afsc)

  DBI::dbDisconnect(afsc)

  } else{
  # establish akfin connection
  akfin <- DBI::dbConnect(odbc::odbc(), "akfin",
                          UID = akfin_user, PWD = akfin_pwd)

  # catch
  .c = .d = sql_read("fsh_catch.sql")
  .c = sql_filter(sql_precode = ">=", 2012, sql_code = .c, flag = "-- insert year")
  .c = sql_filter(x = area, sql_code = .c, flag = "-- insert region")
  .c = sql_filter(x = species, sql_code = .c, flag = "-- insert species")

  .d = sql_filter(sql_precode = "<=", 2011, sql_code = .d, flag = "-- insert year")
  .d = sql_filter(x = area, sql_code = .d, flag = "-- insert region")
  .d = sql_filter(sql_precode = "IN", x = c("PEL7", "PELS"), sql_code = .d, flag = "-- insert species")

  sql_run(akfin, .c) %>%
    dplyr::bind_rows(sql_run(akfin, .d)) %>%
    vroom::vroom_write(here::here(year, "data", "raw", "fsh_catch_data.csv"))

  q_fish_obs(year, fishery = "fsh", norpac_species = norpac_species, area, akfin)
  q_fish_age_comp(year, fishery = "fsh", norpac_species = norpac_species, area = area, akfin = akfin)
  q_fish_length_comp(year, fishery = "fsh", norpac_species = norpac_species, area = area, akfin = akfin)

  DBI::dbDisconnect(akfin)

  #establish afsc connection ----
  afsc = DBI::dbConnect(odbc::odbc(), "afsc",
                        UID = afsc_user, PWD = afsc_pwd)

  q_ts_biomass(year, area = "goa", afsc_species = c(afsc_species1, afsc_species2), afsc = afsc)
  q_ts_age_comp(year, area = "goa", afsc_species = c(afsc_species1, afsc_species2), afsc = afsc)
  q_ts_length_comp(year, area = "goa", afsc_species = c(afsc_species1, afsc_species2), afsc = afsc)
  q_ts_saa(year, area = "goa", afsc_species = c(afsc_species1, afsc_species2), afsc = afsc)

  DBI::dbDisconnect(afsc)

  gfdata::goa_dusk_catch_1977_1990 %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "goa_dusk_catch_1977_1990.csv"))

}
  q_date(year)

}
