#' raw data query for GOA RE/BS rockfish
#'
#' @param year assessment year
#' @param akfin_user user name
#' @param akfin_pwd user password
#' @param afsc_user user name
#' @param afsc_pwd user password
#' @param off_yr if this is an off-year assessment change to TRUE
#'
#' @return
#' @export goa_rebs
#'
#' @examples
goa_rebs <- function(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd, off_yr = NULL){

  # globals ----
  species = "REYE"
  area = "GOA"
  afsc_species1 = 30050 # Rougheye and Blackspotted rockfish unidentified, use this code for Longline Survey Data
  afsc_species2 = 30051 # Rougheye rockfish, Sebastes aleutianus, use for Trawl Survey Data
  afsc_species3 = 30052 # Blackspotted rockfish, Sebastes melanostictus, use for Trawl Survey Data
  norpac_species = 307 # Rougheye and Blackspotted rockfish unidentified, use for NORPAC Data
  norpac_species2 = 357 # Blackspotted rockfish, use for NORPAC Data


  if(!is.null(off_yr)){
      # establish akfin connection
      akfin = DBI::dbConnect(odbc::odbc(), "akfin", UID = akfin_user, PWD = akfin_pwd)

      q_fish_catch(year, fishery = "fsh", species = species, area = area, akfin = akfin)
      q_fish_obs(year, fishery = "fsh", norpac_species = c(norpac_species, norpac_species2), area, akfin)

      DBI::dbDisconnect(akfin)

      afsc = DBI::dbConnect(odbc::odbc(), "afsc", UID = afsc_user, PWD = afsc_pwd)

      q_ts_biomass(year, area = "goa", afsc_species = c(afsc_species1, afsc_species2, afsc_species3), afsc = afsc)

      DBI::dbDisconnect(afsc)

    } else{
  # establish akfin connection
  akfin = DBI::dbConnect(odbc::odbc(), "akfin", UID = akfin_user, PWD = akfin_pwd)
  q_fish_catch(year, fishery = "fsh", species = species, area = area, akfin = akfin)
  q_fish_obs(year, fishery = "fsh", norpac_species = c(norpac_species, norpac_species2),area, akfin)
  q_fish_age_comp(year, fishery = "fsh", norpac_species = c(norpac_species, norpac_species2),
                     area = area, akfin = akfin)
  q_fish_length_comp(year, fishery = "fsh", norpac_species = c(norpac_species, norpac_species2),
                        area = area, akfin = akfin)
  # q_lls_biomass(year, area = "goa", afsc_species = afsc_species, akfin = akfin)

  # q_lls_length_comp(year, area = "goa", afsc_species = afsc_species, akfin = akfin)

  DBI::dbDisconnect(akfin)

  #establish afsc connection ----
  afsc = DBI::dbConnect(odbc::odbc(), "afsc",
                        UID = afsc_user, PWD = afsc_pwd)

  q_ts_biomass(year, area = "goa",
               afsc_species = c(afsc_species1, afsc_species2, afsc_species3), afsc = afsc)
  q_ts_age_comp(year, area = "goa",
                afsc_species = c(afsc_species1, afsc_species2, afsc_species3), afsc = afsc)
  q_ts_length_comp(year, area = "goa",
                   afsc_species = c(afsc_species1, afsc_species2, afsc_species3), afsc = afsc)
  q_ts_saa(year, area = "goa",
           afsc_species = c(afsc_species1, afsc_species2, afsc_species3), afsc = afsc)

  DBI::dbDisconnect(afsc)
    }

  gfdata::goa_rebs_catch_1977_2004 %>%
    vroom::vroom_write(here::here(year, "data", "user_input", "goa_rebs_catch_1977_2004.csv"))

  q_date(year)

}
