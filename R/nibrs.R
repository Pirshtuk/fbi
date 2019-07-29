z <- get_nibrs_victim(key, state_abb = "SC")
z2 <- get_nibrs_offender(key, state_abb = "SC")
z3 <- get_nibrs_offense(key, state_abb = "SC")

get_nibrs <- function(api_key,
                      offense     = "robbery",
                      variable    = "race",
                      ori         = NULL,
                      region_name = NULL,
                      state_abb   = NULL,
                      nation      = TRUE,
                      type) {

  data_type <- paste0("data/nibrs/", offense, "/", type)

  url_section <- combine_url_section(data_type, ori, region_name, state_abb)
  api_url <- paste0("https://api.usa.gov/crime/fbi/sapi/api/",
                    url_section, "/", variable, "/?API_KEY=", api_key)



  data <- url_to_dataframe(api_url)
  data <- clean_column_names(data)
  data$offense <- offense
  return(data)
}

get_nibrs_victim <- function(api_key,
                             offense     = "robbery",
                             variable    = "race",
                             ori         = NULL,
                             region_name = NULL,
                             state_abb   = NULL,
                             nation      = TRUE) {

  data <- get_nibrs(api_key     = api_key,
                    offense     = offense,
                    variable    = variable,
                    ori         = ori,
                    region_name = region_name,
                    state_abb   = state_abb,
                    nation      = nation,
                    type        = "victim")

  return(data)
}

get_nibrs_offender <- function(api_key,
                             offense     = "robbery",
                             variable    = "race",
                             ori         = NULL,
                             region_name = NULL,
                             state_abb   = NULL,
                             nation      = TRUE) {

  data <- get_nibrs(api_key     = api_key,
                    offense     = offense,
                    variable    = variable,
                    ori         = ori,
                    region_name = region_name,
                    state_abb   = state_abb,
                    nation      = nation,
                    type        = "offender")

  return(data)
}

get_nibrs_offense <- function(api_key,
                              offense     = "robbery",
                              ori         = NULL,
                              region_name = NULL,
                              state_abb   = NULL,
                              nation      = TRUE) {

  data <- get_nibrs(api_key     = api_key,
                    offense     = offense,
                    variable    = "count",
                    ori         = ori,
                    region_name = region_name,
                    state_abb   = state_abb,
                    nation      = nation,
                    type        = "offender")

  return(data)
}
