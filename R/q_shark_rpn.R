
#' IPHC FISS RPN and CPUE from AKFIN
#'
#' @param year assessment year
#' @param save save the file in designated folder if false will load it to global env
#' @param akfin akfin server
#'
#' @return
#' @export q_shark_rpn
#'
#' @examples
#' \dontrun(q_sharl_rpn(year, save=FALSE, akfin))
q_shark_rpn <- function(year, save, akfin){

  files <- grep(paste0("shark_rpn"),
                list.files(system.file("sql", package = "gfdata")), value=TRUE)

  .rpn = sql_read(files)


  if(isTRUE(save)){
    sql_run(akfin, .rpn) %>%
      vroom::vroom_write(here::here(year, "data", "raw", "shark_rpn_data.csv"))
  } else {
    sql_run(akfin, .rpn)
  }
}
