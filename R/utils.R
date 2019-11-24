make_state <- function(state_abb) {
  state <- datasets::state.name[match(tolower(state_abb),
                                     tolower(datasets::state.abb))]
  state[tolower(state_abb) == "CZ"] <- "canal zone"
  state[tolower(state_abb) == "DC"] <- "district of columbia"
  state[tolower(state_abb) == "GU"] <- "guam"
  state[tolower(state_abb) == "PR"] <- "puerto rico"
  return(state)
}

clean_column_names <- function(.data) {
  names(.data) <- tolower(names(.data))
  names(.data) <- gsub("-", "_", names(.data))
  names(.data) <- gsub("^data_year$", "year", names(.data))
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


prep_ucr_crime_test <- function(file_name) {
  data <- utils::read.csv(system.file("testdata",
                                file_name,
                                package = "fbi"))
  ori <- strsplit(gsub(".csv", "", file_name), "-")[[1]]
  crime <- paste0(ori[2:length(ori)], collapse = "_")
  ori <- ori[1]

  data$Label <- gsub("Reported", "actual", data$Label)
  data <- data.table::as.data.table(data)
  data_actual <- data[data$Label == "actual", ]
  data_clear  <- data[data$Label == "Cleared", ]

  names(data_actual)[2] <- paste0(crime, "_actual")
  names(data_clear)[2] <- paste0(crime, "_cleared")
  data_actual$Label <- NULL
  data_clear$Label <- NULL

  data <- merge(data_actual, data_clear, all = TRUE)


  names(data) <- tolower(names(data))
  data$ori <- ori

  return(data)
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
