test <- get_police_employment(start_year = 1990,
                              end_year = 2011,
                              api_key = key)

get_police_employment <- function(start_year,
                                  end_year,
                                  api_key,
                                  ori = NULL,
                                  region_name = NULL,
                                  state_abb = NULL,
                                  nation = TRUE) {

  data_type <- "police-employment"
  url_section <- combine_url_section(data_type, ori = NULL, region_name, state_abb)
  api_url <- make_url(url_section, start_year, end_year, api_key)

  data <- url_to_dataframe(api_url)
  data <- clean_column_names(data)
  return(data)
}
