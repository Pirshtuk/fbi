api_url <- "https://api.usa.gov/crime/fbi/sapi/api/summarized/agencies/CA0010900/offenses/2010/2016?API_KEY=dw3MIpdbpWC8AyD5naDpjXZaEgFenyiGh3y0JP1a"



key <- "dw3MIpdbpWC8AyD5naDpjXZaEgFenyiGh3y0JP1a"
data <- get_agency_crime("CA0010900",
                       1990,
                       2017,
                       key)

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

  api_url <- paste0(url_start,
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


