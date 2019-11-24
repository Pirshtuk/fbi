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


AK0010100_agg_assault <- prep_ucr_crime_test("AK0010100-aggravated-assault.csv")
AK0010100_violent <- prep_ucr_crime_test("AK0010100-violent-crime.csv")
AK0010100_real <- get_agency_crime("AK0010100")

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
