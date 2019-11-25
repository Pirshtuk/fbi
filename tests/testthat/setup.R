# From Crime Data Explorer site
# ucr_estimates <- system.file("testdata",
#                              "estimated_crimes_1979_2018.csv",
#                              package = "fbi")
# state_level_estimated_crime <- read.csv(ucr_estimates)
# state_name <- c(state.name, "District of Columbia")
# state_abb   <- c(state.abb, "DC")
# state_level_estimated_crime$state <- state_name[match(state_level_estimated_crime$state_abbr,state_abb)]
# state_level_estimated_crime$agency <- paste(state_level_estimated_crime$state, "State-Level Estimate")
# state_level_estimated_crime$agency[is.na(state_level_estimated_crime$state)] <- "United States - National Estimate"
# state_level_estimated_crime$state[is.na(state_level_estimated_crime$state)] <- "United States"
# names(state_level_estimated_crime) <- gsub("rape_legacy", "rape", names(state_level_estimated_crime))
# # state_level_estimated_crime$rape[!is.na(state_level_estimated_crime$rape_revised)] <-
# #   state_level_estimated_crime$rape_revised[!is.na(state_level_estimated_crime$rape_revised)]
# state_level_estimated_crime[] <- sapply(state_level_estimated_crime, as.character)
# state_level_estimated_crime <- state_level_estimated_crime[order(state_level_estimated_crime$year,
#                                                    decreasing = TRUE), ]
# state_level_estimated_crime$rape[state_level_estimated_crime$year %in% 2017:2018] <- NA
# names(state_level_estimated_crime) <- gsub("^rape$", "rape_legacy",
#                                            names(state_level_estimated_crime))
# state_level_estimated_crime$caveats <- NULL
# state_level_estimated_crime$agency  <- NULL
# state_level_estimated_crime[c(1, 3:13)] <- sapply(state_level_estimated_crime[c(1, 3:13)], as.numeric)
# state_level_estimated_crime <- state_level_estimated_crime[, c(2, 14, 1, 3:13)]

#save(state_level_estimated_crime, file = "state_level_estimated_crime.rda")

load(system.file("testdata",
                 "state_level_estimated_crime.rda",
                 package = "fbi"))
set_api_key("dw3MIpdbpWC8AyD5naDpjXZaEgFenyiGh3y0JP1a")

read.csv_system_file <- function(file) {
  data <- read.csv(system.file("testdata",
                               file,
                               package = "fbi"))
  data$ori <- as.character(data$ori)
  return(data)
}

ucr_matching_columns <- c("year",
                          "ori",
                          "violent_crime_actual",
                          "violent_crime_cleared",
                          "homicide_actual",
                          "homicide_cleared",
                          # "rape_actual",
                          # "rape_cleared",
                          "robbery_actual",
                          "robbery_cleared",
                          "aggravated_assault_actual",
                          "aggravated_assault_cleared",
                          "property_crime_actual",
                          "property_crime_cleared",
                          "arson_actual",
                          "arson_cleared",
                          "burglary_actual",
                          "burglary_cleared",
                          "larceny_actual",
                          "larceny_cleared",
                          "motor_vehicle_theft_actual",
                          "motor_vehicle_theft_cleared")

AL0210200_real <- get_agency_crime('AL0210200')
AR0230600_real <- get_agency_crime('AR0230600')
AR0600500_real <- get_agency_crime('AR0600500')
AZ0072300_real <- get_agency_crime('AZ0072300')
CA0190000_real <- get_agency_crime('CA0190000')
CA0194200_real <- get_agency_crime('CA0194200')
CA0250000_real <- get_agency_crime('CA0250000')
CA0371100_real <- get_agency_crime('CA0371100')
CA0380100_real <- get_agency_crime('CA0380100')
CA0401300_real <- get_agency_crime('CA0401300')
CA0421200_real <- get_agency_crime('CA0421200')
CA0431300_real <- get_agency_crime('CA0431300')
CA0470500_real <- get_agency_crime('CA0470500')
CO0020100_real <- get_agency_crime('CO0020100')
CT0000200_real <- get_agency_crime('CT0000200')
FL0130000_real <- get_agency_crime('FL0130000')
FL0160200_real <- get_agency_crime('FL0160200')
FL0229000_real <- get_agency_crime('FL0229000')
FL0290000_real <- get_agency_crime('FL0290000')
FL0350800_real <- get_agency_crime('FL0350800')
GA1440000_real <- get_agency_crime('GA1440000')
GA1560100_real <- get_agency_crime('GA1560100')
HI0020000_real <- get_agency_crime('HI0020000')
IA0690100_real <- get_agency_crime('IA0690100')
IL0460000_real <- get_agency_crime('IL0460000')
IL0630400_real <- get_agency_crime('IL0630400')
IL0901900_real <- get_agency_crime('IL0901900')
ILCPD0000_real <- get_agency_crime('ILCPD0000')
IN0200200_real <- get_agency_crime('IN0200200')
IN0410800_real <- get_agency_crime('IN0410800')
IN0420100_real <- get_agency_crime('IN0420100')
IN0490400_real <- get_agency_crime('IN0490400')
INIPD0000_real <- get_agency_crime('INIPD0000')
KY0420700_real <- get_agency_crime('KY0420700')
LA0190100_real <- get_agency_crime('LA0190100')
MA0090700_real <- get_agency_crime('MA0090700')
MD0160400_real <- get_agency_crime('MD0160400')
MN0730600_real <- get_agency_crime('MN0730600')
MO0956200_real <- get_agency_crime('MO0956200')
MS0020000_real <- get_agency_crime('MS0020000')
MS0250000_real <- get_agency_crime('MS0250000')
NB0710000_real <- get_agency_crime('NB0710000')
NBNSP2000_real <- get_agency_crime('NBNSP2000')
NC0030000_real <- get_agency_crime('NC0030000')
NC0460200_real <- get_agency_crime('NC0460200')
NC0600100_real <- get_agency_crime('NC0600100')
NC0670300_real <- get_agency_crime('NC0670300')
NH008010X_real <- get_agency_crime('NH008010X')
NJ0024600_real <- get_agency_crime('NJ0024600')
NJ0121300_real <- get_agency_crime('NJ0121300')
NJ0151400_real <- get_agency_crime('NJ0151400')
NV0020100_real <- get_agency_crime('NV0020100')
NY0290000_real <- get_agency_crime('NY0290000')
NY0303000_real <- get_agency_crime('NY0303000')
NY0350200_real <- get_agency_crime('NY0350200')
NY0510100_real <- get_agency_crime('NY0510100')
NY0513600_real <- get_agency_crime('NY0513600')
NY0560100_real <- get_agency_crime('NY0560100')
OH0350400_real <- get_agency_crime('OH0350400')
OH0451300_real <- get_agency_crime('OH0451300')
OH0691100_real <- get_agency_crime('OH0691100')
OK0170100_real <- get_agency_crime('OK0170100')
OR0030900_real <- get_agency_crime('OR0030900')
PA0060500_real <- get_agency_crime('PA0060500')
PA0115800_real <- get_agency_crime('PA0115800')
PA0360700_real <- get_agency_crime('PA0360700')
PA0406500_real <- get_agency_crime('PA0406500')
PAPEP0000_real <- get_agency_crime('PAPEP0000')
SC014FC00_real <- get_agency_crime('SC014FC00')
SC0231000_real <- get_agency_crime('SC0231000')
SC041SP00_real <- get_agency_crime('SC041SP00')
SD0620200_real <- get_agency_crime('SD0620200')
TN0570000_real <- get_agency_crime('TN0570000')
TX0151100_real <- get_agency_crime('TX0151100')
TX0610600_real <- get_agency_crime('TX0610600')
TX0770100_real <- get_agency_crime('TX0770100')
TX1010000_real <- get_agency_crime('TX1010000')
TX1016100_real <- get_agency_crime('TX1016100')
TX2270100_real <- get_agency_crime('TX2270100')
TX2300300_real <- get_agency_crime('TX2300300')
TX2490000_real <- get_agency_crime('TX2490000')
TXDPD0000_real <- get_agency_crime('TXDPD0000')
TXHPD0000_real <- get_agency_crime('TXHPD0000')
TXSPD0000_real <- get_agency_crime('TXSPD0000')
VA0290100_real <- get_agency_crime('VA0290100')
VA0510100_real <- get_agency_crime('VA0510100')
VA0820500_real <- get_agency_crime('VA0820500')
WI0540800_real <- get_agency_crime('WI0540800')
WV0060200_real <- get_agency_crime('WV0060200')
WV0140500_real <- get_agency_crime('WV0140500')

us_estimated_crime <- get_estimated_crime()
us_estimated_crime$state_id <- NULL
us_estimated_crime$arson <- NULL
us_estimated_crime$state <- NULL
us_estimated_crime_test <- state_level_estimated_crime[state_level_estimated_crime$state %in%
                                                         "United States", ]
us_estimated_crime_test$state <- NULL
rownames(us_estimated_crime_test) <- 1:nrow(us_estimated_crime_test)
us_estimated_crime$state_abbr <- ""


ca_estimate_crime <- state_level_estimated_crime[state_level_estimated_crime$state_abbr %in%
                                                   "CA", ]
rownames(ca_estimate_crime) <- 1:nrow(ca_estimate_crime)
pa_estimate_crime <- state_level_estimated_crime[state_level_estimated_crime$state_abbr %in%
                                                   "PA", ]
rownames(pa_estimate_crime) <- 1:nrow(pa_estimate_crime)
oh_estimate_crime <- state_level_estimated_crime[state_level_estimated_crime$state_abbr %in%
                                                   "OH", ]
rownames(oh_estimate_crime) <- 1:nrow(oh_estimate_crime)
me_estimate_crime <- state_level_estimated_crime[state_level_estimated_crime$state_abbr %in%
                                                   "ME", ]
rownames(me_estimate_crime) <- 1:nrow(me_estimate_crime)
ny_estimate_crime <- state_level_estimated_crime[state_level_estimated_crime$state_abbr %in%
                                                   "NY", ]
rownames(ny_estimate_crime) <- 1:nrow(ny_estimate_crime)
wy_estimate_crime <- state_level_estimated_crime[state_level_estimated_crime$state_abbr %in%
                                                   "WY", ]
rownames(wy_estimate_crime) <- 1:nrow(wy_estimate_crime)
dc_estimate_crime <- state_level_estimated_crime[state_level_estimated_crime$state_abbr %in%
                                                   "DC", ]
rownames(dc_estimate_crime) <- 1:nrow(dc_estimate_crime)
dc_estimate_crime$state <- NA
dc_estimate_crime$state <- as.character(dc_estimate_crime$state)
