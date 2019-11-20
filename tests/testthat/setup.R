# From Crime Data Explorer site
# ucr_estimates <- system.file("testdata",
#                              "estimated_crimes_1979_2018.csv",
#                              package = "fbi")
# state_level_data_new <- read.csv(ucr_estimates)
# state_name <- c(state.name, "District of Columbia")
# state_abb   <- c(state.abb, "DC")
# state_level_data_new$state <- state_name[match(state_level_data_new$state_abbr,state_abb)]
# state_level_data_new$agency <- paste(state_level_data_new$state, "State-Level Estimate")
# state_level_data_new$agency[is.na(state_level_data_new$state)] <- "United States - National Estimate"
# state_level_data_new$state[is.na(state_level_data_new$state)] <- "United States"
# names(state_level_data_new) <- gsub("rape_legacy", "rape", names(state_level_data_new))
# state_level_data_new$rape[!is.na(state_level_data_new$rape_revised)] <-
#   state_level_data_new$rape_revised[!is.na(state_level_data_new$rape_revised)]
# state_level_data_new[] <- sapply(state_level_data_new, as.character)
# state_level_data_new <- state_level_data_new[order(state_level_data_new$year,
#                                                    decreasing = TRUE), ]
# state_level_estimated_crime <- state_level_data_new
#save(state_level_estimated_crime, file = "state_level_estimated_crime.rda")

load(system.file("testdata",
                 "state_level_estimated_crime.rda",
                 package = "fbi"))
cde_key = "dw3MIpdbpWC8AyD5naDpjXZaEgFenyiGh3y0JP1a"
