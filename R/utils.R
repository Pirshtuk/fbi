make_state <- function(state_abb) {
  state <- datasets::state.name[match(tolower(state_abb),
                                     tolower(datasets::state.abb))]
  state[tolower(state_abb) == "CZ"] <- "canal zone"
  state[tolower(state_abb) == "DC"] <- "district of columbia"
  state[tolower(state_abb) == "GU"] <- "guam"
  state[tolower(state_abb) == "PR"] <- "puerto rico"
  return(state)
}

read.csv_system_file <- function(file) {
  data <- utils::read.csv(system.file("testdata",
                               file,
                               package = "fbi"))
  data$ori <- as.character(data$ori)
  return(data)
}

clean_column_names <- function(.data) {
  names(.data) <- tolower(names(.data))
  names(.data) <- gsub("-", "_", names(.data))
  names(.data) <- gsub("^data_year$", "year", names(.data))
  .data$csv_header <- NULL
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



prep_ucr_crime_test <- function(file_name, type = "crime") {
  data <- utils::read.csv(system.file("testdata",
                                file_name,
                                package = "fbi"))
  ori <- strsplit(gsub(".csv", "", file_name), "-")[[1]]
  ori <- gsub("_police", "", ori)
  crime <- paste0(ori[2:length(ori)], collapse = "_")
  crime <- paste0(crime, "_")
  ori <- ori[1]


  if (type == "police") {
    names(data) <- c("Year", "Label", "Value")
    crime <- ""
  }
  data <- stats::reshape(data,
                         idvar = "Year",
                         timevar = "Label",
                         direction = "wide")
  names(data) <- gsub("^Value\\.", "", names(data))
  names(data)[2:ncol(data)] <- paste0(crime, names(data)[2:ncol(data)])
  data$ori <- ori
  names(data) <- tolower(names(data))
  names(data) <- gsub("_reported$", "_actual", names(data))
  names(data) <- gsub(" ", "_", names(data))
  data <- data.frame(data)
  rownames(data) <- 1:nrow(data)

  if (type == "police") {
    data$male_total      <- data$male_civilians   + data$male_officers
    data$female_total    <- data$female_civilians + data$female_officers
    data$civilians_total <- data$female_civilian  + data$male_civilian
    data$officers_total  <- data$female_officer   + data$male_officer
    data$employees_total <- data$civilians_total  + data$officers_total

  }

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
