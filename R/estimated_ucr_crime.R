#' Title
#'
#' @param start_year
#' @param end_year
#' @param api_key
#' @param region_name
#' @param state_abb
#' @param nation
#' @param arson
#'
#' @return
#' @export
#'
#' @examples
get_estimated_crime <- function(start_year,
                                end_year,
                                api_key,
                                region_name = NULL,
                                state_abb = NULL,
                                nation = TRUE,
                                arson = FALSE) {

  data_type <- "estimates"
  if (arson) {
    data_type <- "arson"
  }
  url_section <- combine_url_section(data_type, ori = NULL, region_name, state_abb)
  api_url <- make_url(url_section, start_year, end_year, api_key)



  data <- url_to_dataframe(api_url)
  data <- clean_column_names(data)
  return(data)
}
