
#' RPN weighted sablefish length comp data query
#'
#' @param year assessment year
#' @param save save the file in designated folder if false will load it to global env
#'
#' @return
#' @export q_sabl_length_comp
#'
#' @examples
q_sabl_length_comp <- function(year, save = TRUE){

  files <- grep(paste0("_rpn"),
                list.files(system.file("sql", package = "gfdata")), value=TRUE)

  .l = sql_read(files[1])
  .a = sql_read(files[2])

  .l = sql_run(akfin, .l)
  .a = sql_run(akfin, .a)

  if(isTRUE(save)){
    .l %>%
    vroom::vroom_write(here::here(year, "data", "raw", "sabl_rpn_length_data.csv"))
    .a %>%
      vroom::vroom_write(here::here(year, "data", "raw", "sabl_rpn_area_data.csv"))
  } else {
    list(lengths = .l, areas = .a)
  }
}
