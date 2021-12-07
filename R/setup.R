#' Setup folder structure
#'
#' Creates a common folder structure for ADMB assessments
#'
#' @param year
#' @param off_yr if this is an off-year assessment change to TRUE
#' #'
#' @return
#' @export setup
#'
#' @examples
#' \dontrun{
#' setup(2020)
#'}
setup <- function(year, off_yr = NULL){

  if(!is.null(off_yr)){
    dirs = c("raw", "user_input", "output", "sara")
    for(i in 1:length(dirs)){
      if(dir.exists(here::here(year, "data", dirs[i])) == FALSE){
        dir.create(here::here(year, "data", dirs[i]), recursive=TRUE)
      }
    }

  } else {
    dirs = c("raw", "user_input", "output", "sara", "models")
    folders = c("ageage", "allometric", "vonb", "wvonb", "length_sd")

    for(i in 1:length(dirs)){
      if(dir.exists(here::here(year, "data", dirs[i])) == FALSE){
        dir.create(here::here(year, "data", dirs[i]), recursive=TRUE)
      }
    }
    for(i in 1:length(folders)){
      dir.create(here::here(year, "data", "models", folders[i]))
    }

    file.copy(system.file("models", "ageage.tpl", package = "groundfishr"),
              here::here(year, "data", "models", "ageage"))

    file.copy(system.file("models", "allometric.tpl", package = "groundfishr"),
              here::here(year, "data", "models", "allometric"))

    file.copy(system.file("models", "vbl.tpl", package = "groundfishr"),
              here::here(year, "data", "models", "vonb"))

    file.copy(system.file("models", "wvbl.tpl", package = "groundfishr"),
              here::here(year, "data", "models", "wvonb"))

    file.copy(system.file("models", "wvbl.ctl", package = "groundfishr"),
              here::here(year, "data", "models", "wvonb"))

    file.copy(system.file("models", "lengthsd.tpl", package = "groundfishr"),
              here::here(year, "data", "models", "length_sd"))
  }
  dir.create(here::here(year, "proj"))
  dir.create(here::here(year, "apportionment"))

}
