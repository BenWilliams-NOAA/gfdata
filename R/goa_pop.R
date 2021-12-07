

#' raw data query for GOA POP
#'
#' @param year assessment year
#' @param akfin_user user name
#' @param akfin_pwd user password
#' @param afsc_user user name
#' @param afsc_pwd user password
#'
#' @return
#' @export goa_pop
#'
#' @examples
#' \dontrun{
#' goa_pop(year = 2020, akfin_user, akfin_pwd, afsc_user, afsc_pwd)
#'}
goa_pop <- function(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd){

  # globals ----
  species = "POPA"
  area = "GOA"
  afsc_species = 30060
  norpac_species = 301

  if(!is.null(off_yr)){
    # establish akfin connection
    akfin = DBI::dbConnect(odbc::odbc(), "akfin",
                           UID = akfin_user, PWD = akfin_pwd)

    # catch
    q_fish_catch(year, fishery = "fsh", species = species, area = area, akfin = akfin)
    q_fish_obs(year, fishery = "fsh", norpac_species = norpac_species, area, akfin)

    DBI::dbDisconnect(akfin)

    afsc = DBI::dbConnect(odbc::odbc(), "afsc",
                          UID = afsc_user, PWD = afsc_pwd)

    q_ts_biomass(year, area = "goa", afsc_species = afsc_species, afsc = afsc)

    DBI::dbDisconnect(afsc)

  } else{
  # establish akfin connection
  akfin = DBI::dbConnect(odbc::odbc(), "akfin",
                         UID = akfin_user, PWD = akfin_pwd)

  # catch
  q_fish_catch(year, fishery = "fsh", species = species, area = area, akfin = akfin)
  q_fish_obs(year, fishery = "fsh", norpac_species = norpac_species, area, akfin)
  q_fish_age_comp(year, fishery = "fsh", norpac_species = norpac_species, area = area, akfin = akfin)
  q_fish_length_comp(year, fishery = "fsh", norpac_species = norpac_species, area = area, akfin = akfin)

  DBI::dbDisconnect(akfin)

  #establish afsc connection ----
  afsc = DBI::dbConnect(odbc::odbc(), "afsc",
                        UID = afsc_user, PWD = afsc_pwd)

  q_ts_biomass(year, area = "goa", afsc_species = afsc_species, afsc = afsc)
  q_ts_age_comp(year, area = "goa", afsc_species = afsc_species, afsc = afsc)
  q_ts_length_comp(year, area = "goa", afsc_species = afsc_species, afsc = afsc)
  q_ts_saa(year, area = "goa", afsc_species = afsc_species, afsc = afsc)

  DBI::dbDisconnect(afsc)
  }

  gfdata::goa_pop_catch_1960_1990 %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "goa_pop_catch_1960_1990.csv"))

  gfdata::goa_pop_fixed_fish_length_comp %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "goa_pop_fixed_fish_length_comp.csv"))

  gfdata::saa_pop_60 %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "saa_pop_60.csv"))


  q_date(year)
}



