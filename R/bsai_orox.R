#' raw data query for BSAI Other rockfish
#'
#' @param year assessment year
#' @param akfin_user user name
#' @param akfin_pwd user password
#' @param afsc_user user name
#' @param afsc_pwd user password
#' @param off_yr if this is an off-year assessment change to TRUE - doesn't work for T4/5 stocks
#'
#' @return
#' @export bsai_orox
#'
#' @examples
bsai_orox <- function(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd, off_yr = NULL){

  # globals ----
  species = "ROCK" # FIXME! this doesn't work... there are species_group_code = 'THDS' & is.na(species_group_code)) that are also 'other rockfish'
  # The method to get catch for BSAI other rockfish:
  # agency_species_codes provided to J Sullivan by I Spies in 2020:
  bsaiorox_agency_spp <- c(153, 154, 172, 148, 147, 157, 139, 158, 145, 176, 143, 142,
    150, 156, 155, 175, 149, 159, 166, 146, 184, 137,
    138, 178, 182, 179)
  # J Sullivan also started to track GOA orox species in case any of these species start to show up in the GOA:
  goaorox_agency_spp <- c(179, 182, 178, 138, 137, 184, 146, 149, 155, 156, 147, 148)

  # these are species classified in catch as "Other Rockfish" that occur primarily
  # in GOA. Keep these in just in case any of these spp start to show up in the
  # BSAI catch
  goa_orox3 <- c(179, 182, 178, 138, 137, 184, 146, 149, 155, 156, 147, 148)
  area = "GOA"
  # these are the official BSAI other rockfish species lists passed along to J Sullivan from I Spies in 2020
  afsc_species_ls <- c(30330, # black rockfish
                       30430, # redstripe rockfish
                       30470, # yelloweye rockfish
                       30475, # redbanded rockfish
                       30535, # harlequin rockfish
                       30560, # shaprchin rockfish
                       30600, # yellowmouth rockfish
                       30030, # longspine thornyhead rockfish
                       30040, # rockfish unidentified
                       30100, # silvergray rockfish
                       30150, # dusky and dark rockfishes unidentified
                       30152, # dusky rockfish
                       30170, # darkblotches rockfish
                       30270, # rosethorn rockfish
                       30010, # thornyhead rockfish unidentified
                       30020, # shortspine thornyhead rockfish
                       30025 # broadfin thornyhead rockfish
  )

  norpac_species_ls <- c(300, # rockfish unidentified
                         304, # sharpchin rockfish
                         308, # redbanded rockfish
                         309, # rosethorn rockfish
                         310, # silvergray rockfish
                         311, # darkblotched rockfish
                         320, # yellowmouth rockfish
                         322, # yelloweye rockfish
                         323, # harlequin rockfish
                         324, # redstripe rockfish
                         330, # dusky rockfish
                         345, # dark rockfish
                         349, # thornyhead rockfish unidentified
                         350, # shortspine thornyhead rockfish
                         351, # broad banded (?) thornyhead rockfish
                         352, # longspine thornyhead rockfish
                         306, # black rockfish
                         355 # dusky/dark rockfish unidentified
  )

  # establish akfin connection
  akfin = DBI::dbConnect(odbc::odbc(), "akfin", UID = akfin_user, PWD = akfin_pwd)

  q_ts_total_biomass(year, area = 'EBSSHELF', akfin, afsc_species = afsc_species_ls, save = FALSE) %>% str()
  q_ts_total_biomass(year, area = 'EBSSLOPE', akfin, afsc_species = afsc_species_ls, save = FALSE) %>% str()

  # q_fish_catch(year, fishery = "fsh", species = species, area = area, akfin = akfin)
  # q_fish_obs(year, fishery = "fsh", norpac_species = c(norpac_species, norpac_species2),area, akfin)
  # q_fish_age_comp(year, fishery = "fsh", norpac_species = c(norpac_species, norpac_species2),
  #                 area = area, akfin = akfin)
  # q_fish_length_comp(year, fishery = "fsh", norpac_species = c(norpac_species, norpac_species2),
  #                    area = area, akfin = akfin)
  # q_lls_biomass(year, area = "goa", afsc_species = afsc_species, akfin = akfin)
  #
  # q_lls_length_comp(year, area = "goa", afsc_species = afsc_species, akfin = akfin)
  #
  DBI::dbDisconnect(akfin)
  #
  #establish afsc connection
  # afsc = DBI::dbConnect(odbc::odbc(), "afsc",
  #                       UID = afsc_user, PWD = afsc_pwd)
  #
  # afsc_species_n <- c(afsc_species1, afsc_species2,
  #                     afsc_species3)
  #
  # q_ts_biomass(year, area = "ai",
  #              afsc_species = afsc_species_n, afsc = afsc)
  #
  # DBI::dbDisconnect(afsc)

  # gfdata::goa_rebs_catch_1977_2004 %>%
  #   vroom::vroom_write(here::here(year, "data", "user_input", "goa_rebs_catch_1977_2004.csv"), delim = ",")

  q_date(year)
}
