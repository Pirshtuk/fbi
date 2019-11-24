get_nibrs <- function(key = get_api_key(),
                      offense,
                      variable,
                      ori,
                      region_name,
                      state_abb,
                      type) {

  data_type <- paste0("data/nibrs/", offense, "/", type)

  url_section <- combine_url_section(data_type, ori, region_name, state_abb)
  api_url <- paste0("https://api.usa.gov/crime/fbi/sapi/api/",
                    url_section, "/", variable, "/?api_key=", key)


  data <- url_to_dataframe(api_url)
  data <- clean_column_names(data)
  data$offense <- offense
  return(data)
}

#' Title
#'
#' @param key
#' @param offense
#' @param variable
#' @param ori
#' @param region_name
#' @param state_abb
#'
#' @return
#' @export
#'
#' @examples
get_nibrs_victim <- function(key = get_api_key(),
                             offense     = "robbery",
                             variable    = "race",
                             ori         = NULL,
                             region_name = NULL,
                             state_abb   = NULL) {

  data <- get_nibrs(key         = key,
                    offense     = offense,
                    variable    = variable,
                    ori         = ori,
                    region_name = region_name,
                    state_abb   = state_abb,
                    type        = "victim")

  return(data)
}

#' Title
#'
#' @param key
#' @param offense
#' @param variable
#' @param ori
#' @param region_name
#' @param state_abb
#'
#' @return
#' @export
#'
#' @examples
get_nibrs_offender <- function(key = get_api_key(),
                               offense     = "robbery",
                               variable    = "race",
                               ori         = NULL,
                               region_name = NULL,
                               state_abb   = NULL) {

  data <- get_nibrs(key         = key,
                    offense     = offense,
                    variable    = variable,
                    ori         = ori,
                    region_name = region_name,
                    state_abb   = state_abb,
                    type        = "offender")

  return(data)
}

#' Title
#'
#' @param key
#' @param offense
#' @param ori
#' @param region_name
#' @param state_abb
#'
#' @return
#' @export
#'
#' @examples
get_nibrs_offense <- function(key = get_api_key(),
                              offense     = "robbery",
                              ori         = NULL,
                              region_name = NULL,
                              state_abb   = NULL) {

  data <- get_nibrs(key         = key,
                    offense     = offense,
                    variable    = "count",
                    ori         = ori,
                    region_name = region_name,
                    state_abb   = state_abb,
                    type        = "offender")

  return(data)
}
