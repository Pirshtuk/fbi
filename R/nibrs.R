get_nibrs <- function(key = get_api_key(),
                      offense,
                      variable,
                      ori,
                      region_name,
                      state_abb,
                      type) {

  data_type <- paste0("data/nibrs/", offense, "/", type)

  url_section <- combine_url_section(data_type, ori, region_name, state_abb)
  api_url <- paste0("https://api.usa.gov/crime/fbi/sapi/api/",
                    url_section, "/", variable, "/?api_key=", key)


  data <- url_to_dataframe(api_url)
  data <- clean_column_names(data)
  data$offense <- offense
  return(data)
}

#' Gets victim-level data from the FBI's National Incident-Based Reporting System (NIBRS)
#'
#' @inheritParams get_agency_crime
#' @inheritParams get_estimated_arson
#'
#' @param offense
#' A string or vector of strings with the offenses you want to scrape. If
#' input is 'all' (default), returns data for all offenses. Please run `list_nibrs_offenses()` to see all possible offenses.
#' @param variable
#' A string with the variable you want the data to be in. This is essentially the units you want returned (number of victims by age, race, sex, etc.). By default returns total count of victims. Please run `list_nibrs_victim_variables()`  to see all possible variables.
#'
#' @return
#' A data.frame of NIBRS victim data.
#' @export
#'
#' @examples
#' \dontrun{
#' get_nibrs_victim(ori = "DE0010100")
#' }
get_nibrs_victim <- function(key = get_api_key(),
                             offense     = "robbery",
                             variable    = "race",
                             ori         = NULL,
                             region      = NULL,
                             state_abb   = NULL) {

  data <- get_nibrs(key         = key,
                    offense     = offense,
                    variable    = variable,
                    ori         = ori,
                    region_name = region,
                    state_abb   = state_abb,
                    type        = "victim")

  return(data)
}

#' Gets offender-level data from the FBI's National Incident-Based Reporting System (NIBRS)
#'
#' @inheritParams get_nibrs_victim
#'
#' @param variable
#' A string with the variable you want the data to be in. This is essentially the units you want returned (number of offenders by age, race, sex, etc.). By default returns total count of offenders Please run `list_nibrs_offender_variables()`  to see all possible variables.
#'
#' @return
#' A data.frame of NIBRS offender data.
#' @export
#'
#' @examples
#' \dontrun{
#' get_nibrs_offender(ori = "DE0010100")
#' }
get_nibrs_offender <- function(key = get_api_key(),
                               offense     = "all",
                               variable    = "count",
                               ori         = NULL,
                               region      = NULL,
                               state_abb   = NULL) {

  data <- get_nibrs(key         = key,
                    offense     = offense,
                    variable    = variable,
                    ori         = ori,
                    region_name = region,
                    state_abb   = state_abb,
                    type        = "offender")

  return(data)
}

#' Gets offense-level data from the FBI's National Incident-Based Reporting System (NIBRS)
#'
#' @inheritParams get_nibrs_victim
#'
#' @param variable
#' A string with the variable you want the data to be in. This is essentially the units you want returned (number of offenses by weapon used, race, bias motivation, etc.). By default returns total count of offenders Please run `list_nibrs_offense_variables()`  to see all possible variables.
#'
#' @return
#' A data.frame of NIBRS offense data.
#' @export
#'
#' @examples
#' \dontrun{
#' get_nibrs_offense(ori = "DE0010100")
#' }
get_nibrs_offense <- function(key = get_api_key(),
                              offense     = "all",
                              variable    = "count",
                              ori         = NULL,
                              region      = NULL,
                              state_abb   = NULL) {

  data <- get_nibrs(key         = key,
                    offense     = offense,
                    variable    = variable,
                    ori         = ori,
                    region_name = region,
                    state_abb   = state_abb,
                    type        = "offense")

  return(data)
}

#' Return a vector of all offenses in the NIBRS data.
#'
#' @return
#' A vector containing all permissible offenses to input to `get_nibrs_offenses()`,
#' `get_nibrs_victim()`, and `get_nibrs_offender()`.`
#' @export
#'
#' @examples
#' list_nibrs_offenses()
list_nibrs_offenses <- function() {
  return(c("aggravated-assault",
           "all-offenses",
           "all-other-larceny",
           "all-other-offenses",
           "animal-cruelty",
           "arson",
           "assault-offenses",
           "assisting-or-promoting-prostitution",
           "bad-checks",
           "betting",
           "bribery",
           "burglary-breaking-and-entering",
           "counterfeiting-forgery",
           "credit-card-automated-teller-machine-fraud",
           "crime-against-person",
           "crime-against-property",
           "crime-against-society",
           "curfew-loitering-vagrancy-violations",
           "destruction-damage-vandalism-of-property",
           "driving-under-the-influence",
           "drug-equipment-violations", # GIVE SAME RESULTS AS NARCOTIC OFFENSES
           "drug-violations", # GIVES EQUIPMENT VIOLATIONS RESULT
           "drugs-narcotic-offenses", # GIVE SAME RESULTS AS EQUIPMENT VIOLATIONS
           "drunkenness",
           "embezzlement",
           "extortion-blackmail",
           "false-pretenses-swindle-confidence-game",
           "fondling",
           "fraud-offenses",
           "gambling-equipment-violation",
           "gambling-offenses",
           "hacking-computer-invasion",
           "homicide-offenses",
           "human-trafficking-commerical-involuntary-servitude",
           "human-trafficking-commerical-sex-acts",
           "human-trafficking-offenses",
           "identity-theft",
           "impersonation",
           "incest",
           "intimidation",
           "justifiable-homicide",
           "kidnapping-abduction",
           "larceny-theft-offenses",
           "liquor-law-violations",
           "motor-vehicle-theft",
           "murder-and-nonnegligent-manslaughter",
           "negligent-manslaughter",
           #  "not-specified",
           "operating-promoting-assiting-gambling",
           "peeping-tom,pocket-picking",
           "pornography-obscence-material",
           "prostitution",
           "prostitution-offenses",
           "purchasing-prostitution",
           "purse-snatching",
           "rape",
           "robbery",
           "sex-offenses",
           "sex-offenses-non-forcible",
           "sexual-assult-with-an-object",
           "shoplifting",
           "simple-assault",
           "sodomy",
           "sports-tampering",
           "statutory-rape",
           "stolen-property-offenses",
           "theft-from-building",
           "theft-from-coin-operated-machine-or-device",
           "theft-from-motor-vehicle",
           "theft-of-motor-vehicle-parts-or-accessories",
           "weapon-law-violation",
           "welfare-fraud",
           "wire-fraud"))
}


#' Returns a vector of all `variable` parameter options for `get_nibrs_victim()`.
#'
#' @return
#' A vector of all `variable` parameter options for `get_nibrs_victim()`.
#' @export
#'
#' @examples
#' list_nibrs_victim_variables()
list_nibrs_victim_variables <- function() {
  return(sort(c("age",
                "count",
                "ethnicity",
                "race",
                "sex",
                "relationship",
                "location")))
}

#' Returns a vector of all `variable` parameter options for `get_nibrs_offender()`.
#'
#' @return
#' A vector of all `variable` parameter options for `get_nibrs_offender()`.
#' @export
#'
#' @examples
#' list_nibrs_offender_variables()
list_nibrs_offender_variables <- function() {
  return(c("age",
           "count",
           "ethnicity",
           "race",
           "sex"))
}

#' Returns a vector of all `variable` parameter options for `get_nibrs_offense()`.
#'
#' @return
#' A vector of all `variable` parameter options for `get_nibrs_offense()`.
#' @export
#'
#' @examples
#' list_nibrs_offender_variables()
list_nibrs_offense_variables <- function() {
  return(sort(c("count",
                "weapons",
                "linkedoffense",
                "suspectusing",
                "criminal_activity",
                "property_recovered",
                "property_stolen",
                "bias")))
}


#' Return a vector of all offenses in the UCR Arrest data.
#'
#' @return
#' A vector containing all permissible offenses to input to `get_agency_arrest()`.
#' @export
#'
#' @examples
#' list_ucr_arrest_offenses()
list_ucr_arrest_offenses <- function() {
  return(c("aggravated-assault",
           "all-other-offenses",
           "arson",
           "burglary",
           "curfew",
           "disorderly-conduct",
           "dui",
           "drug-grand-total",
           "drug-possession-marijuana",
           "drug-possession-opium",
           "drug-possession-other",
           "drug-possession-subtotal",
           "drug-possession-synthetic",
           "drug-sales-marijuana",
           "drug-sales-opium",
           "drug-sales-other",
           "drug-sales-subtotal",
           "drug-sales-synthetic",
           "drunkenness",
           "embezzlement",
           "forgery",
           "fraud",
           "gambling-all-other",
           "gambling-bookmaking",
           "gambling-numbers",
           "gambling-total",
           "human-trafficking-commercial",
           "human-trafficking-servitude",
           "larceny",
           "liqour-laws", # MISPELLED
           "motor-vehcile-theft", # MISPELLED
           "murder",
           "offense-against-family",
           "prostitution",
           "prostitution-assisting",
           "prostitution-prostitution",
           "prostitution-purchasing",
           "rape",
           "robbery",
           "runaway",
           "sex-offenses",
           "simple-assault",
           "stolen-property",
           "suspicion",
           "vagrancy",
           "vandalism",
           "weapons"))
}

#' Return a vector of all regions choices.
#'
#' @return
#' A vector of all regions choices.
#' @export
#'
#' @examples
#' list_regions()
list_regions <- function() {
  return(c("U.S. Territories",
           "Northeast",
           "Midwest",
           "South",
           "West",
           "Other"))
}
