#' Get agency-, state-, region-, or national-level police staffing data.
#'
#' @inheritParams get_estimated_arson
#'
#' @param ori
#' @param state_abb
#' @param region
#' @param key
#'
#' @return
#' A data.frame with columns for annual number of employees and officers (also broken up by gender).
#' @export
#'
#' @examples
#' # Gets only Oakland Police Department in California
#' get_police_employment("CA0010900")
#'
#' # Gets California state-level estimates
#' get_police_employment(state_abb = "CA")
#'
#' # Gets national-level estiamtes
#' get_police_employment()
get_police_employment <- function(ori = NULL,
                                  state_abb = NULL,
                                  region = NULL,
                                  key = get_api_key()) {

  data_type <- "police-employment"
  url_section <- combine_url_section(data_type, ori, region, state_abb)
  url <- make_url(url_section, 1985, 2018, key)

  data <- url_to_dataframe(url)
  data <- clean_column_names(data)
  return(data)
}
