#' Get agency-level data from the UCR's Offenses Known and Clearances by Arrest data set.
#'
#' @family UCR crime functions
#' @param ori
#' A string or vector of strings of the 9-character ORI code (unique agency ID) for the desired agency.
#' @param key
#' FBI's Crime Data Explorer API key
#'
#' @return
#' @export
#'
#' @examples
#' get_agency_crime("AK0010100")
get_agency_crime <- function(ori,
                             key = get_api_key()) {

  url <- paste0("https://api.usa.gov/crime/fbi/sapi/",
                "api/summarized/agencies/",
                ori, "/",
                "offenses/",
                1985, "/",
                2018,
                "?api_key=",
                key)

  response <- url_to_dataframe(url)
  response <- data.table::as.data.table(response)
  response <- srs_long_to_wide(response)
  response <- clean_column_names(response)
  response <- as.data.frame(response)
  return(response)
}

#' Get state- or national-level estimated crime counts from the UCR's Offenses Known
#' and Clearances by Arrest data set.
#'
#' @family UCR crime functions
#' @inheritParams get_agency_crime
#'
#' @param state_abb
#' String or vector of strings input for state abbreviation(s) to get data for -
#' if NULL returns national data. By default will get all state's data.
#' @param key
#'
#' @return
#' @export
#'
#' @examples
#' get_estimated_crime("CA")
get_estimated_crime <- function(state_abb = NULL,
                                key = get_api_key()) {

  url_section <- combine_url_section("estimates",
                                     ori = NULL,
                                     state_abb = state_abb,
                                     region_name = NULL)
  url <- make_url(url_section, 1979, 2018, key)


  data <- url_to_dataframe(url)
  data <- clean_column_names(data)
  data <- data.table::setorder(data, -year)
  data$state <- make_state(data$state_abbr)
  rownames(data) <- 1:nrow(data)
  data <- data[, c(2, 16, 1, 3, 4:15)]

  return(data)
}

#' Get state-, region- or national-level estimated arson data from the UCR's Offenses Known
#' and Clearances by Arrest data set.
#'
#' @family UCR crime functions
#' @inheritParams get_agency_crime
#' @inheritParams get_estimated_crime
#'
#' @param key
#' @param state_abb
#' @param region
#' String input for region - if NULL and `state_abb` is NULL, returns national data.
#'
#' @return
#' @export
#'
#' @examples
#' get_estimated_arson("CA")
get_estimated_arson <- function(key = get_api_key(),
                                state_abb = NULL,
                                region = NULL) {

  url_section <- combine_url_section("arson",
                                     ori = NULL,
                                     state_abb = state_abb,
                                     region_name = region)
  url <- make_url(url_section, 1975, 2018, key)


  data <- url_to_dataframe(url)
  data <- clean_column_names(data)
  return(data)
}


