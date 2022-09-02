#' raw data query for BSAI flathead sole
#'
#' @param year assessment year
#' @param akfin_user user name
#' @param akfin_pwd user password
#' @param afsc_user user name
#' @param afsc_pwd user password
#' @param off_yr if this is an off-year assessment change to TRUE
#'
#' @return
#' @export bsai_flathead
#'
#' @examples
#' \dontrun{
#' bsai_flathead(year = 2020, akfin_user, akfin_pwd, afsc_user, afsc_pwd)
#'}
bsai_flathead <- function(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd, off_yr = NULL){
  year = 2022
  # globals ----
  species = "FSOL"
  area = "BSAI"
  afsc_species = 30420
  norpac_species = 103


  if(!is.null(off_yr)){
    akfin = DBI::dbConnect(odbc::odbc(), "akfin",
                           UID = akfin_user, PWD = akfin_pwd)


    # catch
    q_fish_catch(year, fishery = "fsh", species = species, area = area, akfin = akfin, save = FALSE)
    q_fish_obs(year, fishery = "fsh", norpac_species = norpac_species, area, akfin)
    q_ts_biomass(year, area = "goa", afsc_species = afsc_species, akfin = akfin)

    DBI::dbDisconnect(akfin)

  } else{
    akfin = DBI::dbConnect(odbc::odbc(), "akfin",
                           UID = akfin_user, PWD = akfin_pwd)

    # catch
    q_fish_catch(year, fishery = "fsh", species = species, area = area, akfin = akfin)
    q_fish_obs(year, fishery = "fsh", norpac_species = norpac_species, area, akfin)
    q_fish_age_comp(year, fishery = "fsh", norpac_species = norpac_species, area = area, akfin = akfin)
    q_fish_length_comp(year, fishery = "fsh", norpac_species = norpac_species, area = area, akfin = akfin)
    q_ts_biomass(year, area = "goa", afsc_species = afsc_species, akfin = akfin)
    DBI::dbDisconnect(akfin)

    #establish afsc connection ----
    afsc = DBI::dbConnect(odbc::odbc(), "afsc",
                          UID = afsc_user, PWD = afsc_pwd)

    q_ts_age_comp(year, area = "goa", afsc_species = afsc_species, afsc = afsc)
    q_ts_length_comp(year, area = "goa", afsc_species = afsc_species, afsc = afsc)
    q_ts_saa(year, area = "goa", afsc_species = afsc_species, afsc = afsc)

    DBI::dbDisconnect(afsc)

  }

  gfdata::goa_nork_catch_1961_1992 %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "goa_nork_catch_1961_1992.csv"))


  q_date(year)
}
