#' @export sql_read
#' @export sql_filter
#' @export sql_run
#' @export collapse_filters
#'
sql_read <- function(x) {
  if(file.exists(system.file("sql", x, package = "gfdata"))) {
    readLines(system.file("sql", x, package = "gfdata"))
  } else {
    stop("The sql file does not exist.")
  }
}

sql_filter <- function(sql_precode = "=", x, sql_code, flag = "-- insert species") {

  i = suppressWarnings(grep(flag, sql_code))
  sql_code[i] <- paste0(
    sql_precode, " (",
    collapse_filters(x), ")"
  )
  sql_code
}

sql_run <- function(database, query) {
  query = paste(query, collapse = "\n")
  DBI::dbGetQuery(database, query, as.is=TRUE, believeNRows=FALSE)
}

collapse_filters <- function(x) {
  sprintf("'%s'", paste(x, collapse = "','"))
}
