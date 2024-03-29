#' raw data query for sablefish in the GOA and BSAI
#'
#' @param year assessment year
#' @param akfin_user user name
#' @param akfin_pwd user password
#' @param afsc_user user name
#' @param afsc_pwd user password
#'
#' @return
#' @export sablefish
#'
#' @examples
#' \dontrun{
#' sablefish(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd)
#' }
sablefish <- function(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd, whale = FALSE){

  # globals ----
  species = "SABL"
  area = c("GOA", "BSAI")
  afsc_species =  20510
  norpac_species = 203

  # establish akfin connection
  akfin <- DBI::dbConnect(odbc::odbc(), "akfin",
                          UID = akfin_user, PWD = akfin_pwd)

  # catch data ----
  .c = sql_read("fsh_catch.sql")
  .c = sql_filter(sql_precode = "<=", year, sql_code = .c, flag = "-- insert year")
  .c = sql_filter(sql_precode = "IN", area, sql_code = .c, flag = "-- insert region")
  .c = sql_filter(x = species, sql_code = .c, flag = "-- insert species")

  sql_run(akfin, .c) %>%
    dplyr::rename_all(tolower) %>%
    dplyr::group_by(agency_gear_code) %>%
    dplyr::mutate(year = as.numeric(year),
           type = dplyr::case_when(agency_gear_code %in% c("BTR", "PTR", "NPT", "TRW") ~ "trawl",
                                   agency_gear_code %in% c("HAL", "POT") ~ "fixed")) -> .df

  .df %>%
    dplyr::filter(type == "fixed") %>%
    write.csv(here::here(year, "data", "raw", "fsh1_catch_data.csv"),
              row.names = FALSE)

  .df %>%
    dplyr::filter(type == "trawl") %>%
    write.csv(here::here(year, "data", "raw", "fsh2_catch_data.csv"),
              row.names = FALSE)

  # observer data ----
  q_fish_obs(year, fishery = "fsh1", norpac_species = norpac_species, area = area, akfin = akfin)

  # whale depredation ----
  if(!isFALSE(whale)){
  .wd = sql_read("sabl_whale.sql")

  sql_run(akfin, .wd) %>%
    dplyr::rename_all(tolower) %>%
    write.csv(here::here(year, "data", "raw", "fsh1_whale_dep_data.csv"),
              row.names = FALSE)

  # vessel lengths ----
  .v = sql_read("sabl_vessel.sql")

  sql_run(akfin, .v) %>%
    dplyr::rename_all(tolower) %>%
    write.csv(here::here(year, "data", "raw", "vessels.csv"),
              row.names = FALSE)
  }

  # goa ts biomass ----
  q_ts_biomass(year, area = "goa", afsc_species = afsc_species, akfin = akfin)

  DBI::dbDisconnect(akfin)

  # lls rpw/rpn ----
  spq_run(akfin,  "SELECT * FROM afsc.lls_ak_wide_3_to_7_depred") %>%
    vroom::vroom_write(., here::here(year, "data", "raw", "lls_rpn_dep_data.csv"))

  # llf cpue ----

  # llf age comp ----

  # lls age comp ----
  sql_run(akfin, "SELECT * FROM AFSC.LLS_AGE_VIEW") %>%
    vroom::vroom_write(., here::here(year, "data", "raw", "lls_age_comp_data.csv"))

  # llf length comp ----

  # lls length comp ----
  q_lls_length_comp(year, area = "goa", afsc_species = afsc_species, akfin = akfin)

  # tf length comp ----


  #establish afsc connection ----
  afsc = DBI::dbConnect(odbc::odbc(), "afsc",
                        UID = afsc_user, PWD = afsc_pwd)


  # ts length comp ----
  q_ts_length_comp(year, area = "goa", afsc_species = afsc_species, afsc = afsc)

  DBI::dbDisconnect(afsc)

  gfdata::sabl_fixed_abundance %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "sabl_fixed_abundance.csv"))

  gfdata::sabl_fixed_ageage %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "sabl_fixed_ageage.csv"))

  gfdata::sabl_fixed_comps %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "sabl_fixed_comps.csv"))

  gfdata::sabl_fixed_saa %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "sabl_fixed_saa.csv"))

  gfdata::sabl_waa %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "sabl_waa.csv"))

  q_date(year)

}
