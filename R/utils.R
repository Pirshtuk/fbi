clean_column_names <- function(.data) {
  names(.data) <- tolower(names(.data))
  names(.data) <- gsub("-", "_", names(.data))
  return(.data)
}


url_to_dataframe <- function(url) {
  response <- httr::GET(url = paste0(url))


  if (response$status_code %in% 200) {
    response <- jsonlite::fromJSON(rawToChar(response$content))
    response <- response$results
  }
  return(response)
}


combine_url_section <- function(data_type, ori, region_name, state_abb) {
  url_section <- paste0(data_type, "/national")
  if (!is.null(ori)) {
    url_section <- paste0(data_type, "/agencies/")
    url_section <- paste0(url_section, ori)
  } else if (!is.null(region_name)) {
    url_section <- paste0(data_type, "/regions/")
    url_section <- paste0(url_section, region_name)
  } else if (!is.null(state_abb)) {
    url_section <- paste0(data_type, "/states/")
    url_section <- paste0(url_section, state_abb)
  }
  return(url_section)
}


make_url <- function(url_section,
                     start_year,
                     end_year,
                     key) {

  url <- paste0("https://api.usa.gov/crime/fbi/sapi/api/",
                url_section,
                "/",
                start_year,
                "/",
                end_year,
                "?API_KEY=",
                key)
  api_url <- gsub("//", "/", url)
  return(api_url)
}

srs_long_to_wide <- function(.data) {
  .data <- data.table::melt(.data, id = c("ori",
                                          "state_abbr",
                                          "data_year",
                                          "offense"))
  .data <- data.table::dcast(.data,
                             ori + state_abbr + data_year ~ offense + variable,
                             measure.var = c("value"))
  return(.data)
}
