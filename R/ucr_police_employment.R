#' Get agency-, state-, region-, or national-level police staffing data.
#'
#' @inheritParams get_estimated_arson
#'
#' @param key
#' @param ori
#' @param state_abb
#' @param region
#'
#' @return
#' A data.frame with columns for annual number of employees and officers (also broken up by gender).
#' @export
#'
#' @examples
get_police_employment <- function(key,
                                  ori = NULL,
                                  state_abb = NULL,
                                  region = NULL) {

  data_type <- "police-employment"
  url_section <- combine_url_section(data_type, ori, region, state_abb)
  url <- make_url(url_section, 1985, 2018, key)

  data <- url_to_dataframe(url)
  data <- clean_column_names(data)
  return(data)
}
