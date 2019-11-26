get_agencies <- function(key = get_api_key()) {
  url <- make_url("agencies", start_year = NULL, end_year = NULL,
                  key = key)
  data <- parse_lookup_response(url)
  data[] <- sapply(data, as.character)
  data <- data.table::setorder(data, ori)
  data <- as.data.frame(data)
  return(data)
}

parse_lookup_response <- function(url) {
  # Returns a stupid list of lists of lists
  response <- httr::GET(url = paste0(url))

  if (response$status_code %in% 200) {
    response <- jsonlite::fromJSON(rawToChar(response$content))
    response <- lapply(response, function(x)data.frame(t(sapply(x, c))))
    response <- data.table::rbindlist(response)
  }
  return(response)
}

#' Title
#'
#' @param agency
#' @param state
#' @param ori_only
#' @param exact_match
#'
#' @return
#' @export
#'
#' @examples
get_agency_info <- function(agency,
                            state = NULL,
                            ori_only = FALSE,
                            exact_match = TRUE) {
  if (exact_match) {
    data <- fbi::fbi_api_agencies[tolower(fbi::fbi_api_agencies$agency_name) %in%
                                    tolower(agency), ]
  } else {
    data <- fbi::fbi_api_agencies[grep(tolower(agency),
                                       tolower(fbi::fbi_api_agencies$agency_name)), ]
  }
  if (!is.null(state)) {
    data <- data[tolower(data$state_name) %in% tolower(state), ]
  }

  if (nrow(data) == 0) {
    message("No matching agencies found. Please revise your `agency` input.")
  }
  if (ori_only) {
    data <- data$ori
  }

  return(data)
}

#' Checks if the ORI is valid
#'
#' Checks an ORI (a 9-digit unique identifier code assigned to each agency)
#' if valid for the API.
#'
#' @inheritParams get_agency_crime
#' @param ori
#'
#' @return
#' TRUE if ori is valid, else FALSE. If ori is a vector, returns TRUE or FALSE
#' for each ori.
#' @export
#'
#' @examples
#' # ORI for Oakland Police Deparment in California
#' is_valid_ori("CA0010900")
#' # Incorrect ori
#' is_valid_ori("abc123")
is_valid_ori <- function(ori) {
  return(ori %in% fbi::fbi_api_agencies$ori)
}



#' All agencies included in the FBI's Crime Data Explorer API.
#'
#' A dataset containing information about the 18,459 agencies included in the
#' FBI's API.
#'
#' @format A data frame with 18459 rows and 13 variables:
#' \describe{
#'   \item{ori}{9-digit unique ID number for the agency}
#'   \item{agency_name}{Agency name}
#'   \item{agency_type_name}{Type of department - e.g city, county, school}
#'   \item{state_name}{State name}
#'   \item{state_abbr}{State abbreviation}
#'   \item{division_name}{Census division name}
#'   \item{region_name}{Census region name}
#'   \item{region_desc}{Census region code}
#'   \item{county_name}{County name}
#'   \item{nibrs}{Boolean on whether the agency reports to NBIRS}
#'   \item{latitude}{Agency latitude}
#'   \item{longitude}{Agency longitude}
#'   \item{nibrs_start_date}{Date agency started reporting to NIBRS. NULL if
#'   the agency does not report to NIBRS}
#'
#' }
#' @source \url{https://crime-data-explorer.fr.cloud.gov/api}
"fbi_api_agencies"
