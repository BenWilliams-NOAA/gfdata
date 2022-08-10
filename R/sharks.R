#' query shark data
#'
#' @param year assessment year
#' @param akfin_user user name
#' @param akfin_pwd user password
#' @param afsc_user user name
#' @param afsc_pwd user password
#' @param save save in standard location (default)
#'
#' @return
#' @export sharks
#'
#' @examples
#' \dontrun{
#' shakrs(year=2022, akfin_user, akfin_pwd, afsc_user, afsc_pwd, save = FALSE)
#' }
sharks <- function(year, akfin_user, akfin_pwd, afsc_user, afsc_pwd, save = TRUE) {

  # establish akfin connection
  akfin = DBI::dbConnect(odbc::odbc(), "akfin",
                         UID = akfin_user, PWD = akfin_pwd)

  q_shark_rpn(year, akfin=akfin, save = save)

}
