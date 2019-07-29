test <- get_estimated_crime(2010,
                            2011,
                            key,
                            state_abb = "CA",
                            arson = TRUE)

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
