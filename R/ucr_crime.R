

#' Title
#'
#' @param ori
#' @param start_year
#' @param end_year
#' @param api_key
#' @param offense
#'
#' @return
#' @export
#'
#' @examples
get_agency_crime <- function(ori,
                             start_year,
                             end_year,
                             api_key,
                             offense = "") {

  if (length(offense) > 1 || !offense %in% ucr_crime_categories) {
    stop()
  }

  if (offense == "") {
    offense = "offenses"
  }

  api_url <- paste0("https://api.usa.gov/crime/fbi/sapi/",
                    "api/summarized/agencies/",
                    ori,
                    "/",
                    offense,
                    "/",
                    start_year,
                    "/",
                    end_year,
                    "?API_KEY=",
                    api_key)

  response <- url_to_dataframe(api_url)

  response <- srs_long_to_wide(response)
  response <- clean_column_names(response)
  return(response)
}



