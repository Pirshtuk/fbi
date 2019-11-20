get_agencies <- function(key) {
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
