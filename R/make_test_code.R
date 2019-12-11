# # crime_oris <- get_oris("-violent-crime.csv")
# # police_oris <- get_oris("police-employment-breakout.csv")
# get_oris <- function(pattern) {
#   oris <- list.files(system.file("testdata",
#                                  package = "fbi"),
#                      pattern = pattern)
#   oris <- gsub("-.*", "", oris)
#   oris <- gsub("_police", "", oris)
#   oris <- unique(oris)
#   return(oris)
# }
#
# # make_tests_text(crime_oris, "get_agency_crime", "_combined",
# #                 "crime")
# # make_tests_text(police_oris, "get_police_employment", "_police-employment-breakout",
# #                 "police")
# make_tests_text <- function(oris, get_function, pattern, type) {
#   if (type == "crime") {
#     reader <- "read.csv_system_file"
#   } else if (type == "police") {
#     reader <- "prep_ucr_crime_test"
#   }
#
#   for (ori in oris) {
#     temp <- paste0('expect_equal(', get_function, "('", ori,
#                    "')[, ", type, "_matching_columns],\n ", reader, "('",
#                    ori,
#                    pattern, ".csv'))")
#     if (type == "police") {
#       temp <- gsub("))$", ",\n type = 'police'))", temp)
#     }
#
#     writeLines(temp)
#   }
# }
#
#
# #combined_cde_ucr_files(oris)
# combined_cde_ucr_files <- function(oris, matching_columns) {
#   for (ori in oris) {
#     final <- data.frame()
#     files <- list.files(system.file("testdata",
#                                     package = "fbi"),
#                         pattern = ori)
#     files <- files[grep("_combined.csv$", files, invert = TRUE)]
#     files <- files[grep("rape", files, invert = TRUE)]
#     for (file in files) {
#       temp <- prep_ucr_crime_test(file)
#       if (nrow(final) == 0) {
#         final <- temp
#       } else {
#         final <- merge(final, temp, by = c("ori", "year"))
#       }
#     }
#     final <- final[, matching_columns]
#     data.table::fwrite(final, file = paste0(system.file("testdata",
#                                                         package = "fbi"),
#                                             "/", ori, "_combined.csv"))
#
#   }
# }
