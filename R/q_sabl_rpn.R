
#' longline survey rpn/rpw data query
#'
#' @param year assessment year
#' @param save save the file in designated folder if false will load it to global env
#'
#' @return
#' @export
#'
#' @examples
q_sabl_rpn <- function(year, save = TRUE){

  files <- grep(paste0("sabl_rpn"),
               list.files(system.file("sql", package = "gfdata")), value=TRUE)

  .rpn = sql_read(files[3])


  if(isTRUE(save)){
    sql_run(akfin, .rpn) %>%
      vroom::vroom_write(here::here(year, "data", "raw", "sabl_rpn_data.csv"))
  } else {
    sql_run(akfin, .rpn)
  }
}
