oris <- list.files(system.file("testdata",
                               package = "fbi"),
                   pattern = "-violent-crime.csv")
oris <- gsub("-.*", "", oris)
oris <- unique(oris)

# for (ori in oris) {
#   #  writeLines(paste0(ori, "_real <- get_agency_crime('", i, "')"))
#
#   writeLines(paste0('expect_equal(', ori,
#          "_real[, ucr_matching_columns],\n read.csv_system_file('",
#          ori,
#          "_combined.csv'))"))
# }
#

#combined_cde_ucr_files(oris)
combined_cde_ucr_files <- function(oris) {
  for (ori in oris) {
    final <- data.frame()
    files <- list.files(system.file("testdata",
                                    package = "fbi"),
                        pattern = ori)
    files <- files[grep("_combined.csv$", files, invert = TRUE)]
    files <- files[grep("rape", files, invert = TRUE)]
    for (file in files) {
      temp <- prep_ucr_crime_test(file)
      if (nrow(final) == 0) {
        final <- temp
      } else {
        final <- merge(final, temp, by = c("ori", "year"))
      }
    }
    final <- final[, ucr_matching_columns]
    data.table::fwrite(final, file = paste0(system.file("testdata",
                                                        package = "fbi"),
                                            "/", ori, "_combined.csv"))

  }
}
