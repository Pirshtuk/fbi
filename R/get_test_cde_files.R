# library(RSelenium)
# library(dplyr)
#
# selectTag = function(element){
#   if (!inherits(element, "webElement")){
#     stop("element should be a web element.")
#   }
#   if (!identical(element$getElementTagName()[[1]], "select")){
#     stop("element does not appear to point to a select element in DOM.")
#   }
#   options <- element$findChildElements("css", "option")
#   optiontext <- vapply(options,
#                        function(x)x$getElementText()[[1]],
#                        character(1)
#   )
#   optionvalues <- vapply(options,
#                          function(x)x$getElementAttribute("value")[[1]],
#                          character(1)
#   )
#   list(elements = options, text = optiontext, value = optionvalues)
# }
#
# selenium_clicker <- function(remDr, using, value) {
#
#   webElem <- find_element(remDr, using, value)
#
#   if (!is.null(webElem)) {
#     webElem$clickElement()
#   }
# }
#
# find_element <- function(remDr, using, value) {
#   webElem <- tryCatch({
#     remDr$findElement(using = using,
#                       value)
#   }, error = function(e) {
#     return(NULL)
#   }, message = function(m) {
#     return(NULL)
#   })
#   return(webElem)
# }
#
#
# wait_for_element <- function(remDr, using, value, time_to_wait) {
#   time_start <- Sys.time()
#   webElem <- find_element(remDr, using, value)
#
#   while(is.null(webElem) && ((Sys.time() - time_start) < time_to_wait))
#
#
#     return(NULL)
# }
#
#
# start_rsDriver <- function() {
#   count <- 1
#   catcher <- NULL
#   while (is.null(catcher) & count < 100) {
#     catcher <- tryCatch({
#       rD <- rsDriver(browser = "firefox",
#                      port = as.integer(Sys.Date() + count))
#     },
#     error = function(e){})
#     count <- count + 1
#     message(count)
#   }
#   return(rD)
# }
#
# agencies_to_download <-
#   fbi::fbi_api_agencies %>%
#   filter(!agency_type_name %in% c("Other State Agency", "Other")) %>%
#   sample_n(50)
# largest_agencies <-
#   fbi_api_agencies %>%
#   filter(ori %in% c("NY0303000", "CA0194200", "ILCPD0000", "TXHPD0000",
#                     "TX1010000", "NV0020100", "AZ0072300", "PAPEP0000",
#                     "TXSPD0000", "CA0371100", "NY0510100", "TXDPD0000",
#                     "FL0130000", "VA0290100", "NY0290000", "CA0431300",
#                     "MD0160400", "HI0020000", "CA0190000", "TX2270100",
#                     "FL0290000", "NC0600100", "FL0160200", "CA0380100",
#                     "INIPD0000")) # Top 25 largest agencies by population
# agencies_to_download <-
#   agencies_to_download %>%
#   bind_rows(largest_agencies) %>%
#   distinct(ori, .keep_all = TRUE)
#
# #get_cde_test_files(agencies_to_download, "crime", "#explorer > div > div.mb3.ng-scope > div > div > div.bg-white > line-chart > div.clearfix.pt1.mb1 > button")
# # get_cde_test_files("pe", "line-chart.ng-isolate-scope:nth-child(2) > div:nth-child(4) > button:nth-child(1)")
# get_cde_test_files(agencies_to_download,
#                    "arrest",
#                    "div.mt1:nth-child(5) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > basic-table:nth-child(1) > div:nth-child(3) > button:nth-child(1)")
# get_cde_test_files <- function(agencies_to_download,
#                                page_name,
#                                download_button_css_selector) {
#   rD <- start_rsDriver()
#   remDr <- rD$client
#   for (i in 1:nrow(agencies_to_download)) {
#     ori         <- agencies_to_download$ori[i]
#     agency_name <- agencies_to_download$agency_name[i]
#     agency_name <- gsub(" |_", "-", agency_name)
#     agency_name <- gsub(":", "_", agency_name)
#     agency_name <- gsub("-+", "-", agency_name)
#     agency_name <- tolower(agency_name)
#
#
#     url <- paste0("https://crime-data-explorer.fr.cloud.gov/explorer/agency/",
#                   ori,
#                   "/",
#                   page_name)
#     remDr$navigate(url);
#     Sys.sleep(15)
#
#     # Change starting year to earliest possible year
#     webElem <- remDr$findElement(using = "css selector", value = "#since")
#     years <- selectTag(webElem)
#     years$elements[[1]]$clickElement()
#     #   Sys.sleep(10)
#
#     if (page_name == "crime") {
#       # 10 crimes total.
#       for (crime_num in 1:10) {
#         webElem <- remDr$findElement(using = "css selector", "#crime-select")
#         crimes <- selectTag(webElem)
#         crimes$elements[[crime_num]]$clickElement()
#
#         wait_for_element(webDr,
#                          using = "css selector",
#                          value = download_button_css_selector,
#                          time_to_wait = 15)
#         selenium_clicker(remDr, using = "css selector",
#                          download_button_css_selector)
#         Sys.sleep(1)
#       }
#     } else if (page_name == 'pe') {
#       selenium_clicker(remDr, using = "css selector",
#                        download_button_css_selector)
#       #  Sys.sleep(3)
#     } else if (page_name == 'arrest') {
#       webElem <- remDr$findElement(using = "css selector", "year-ddl.mb2:nth-child(2) > select:nth-child(1)")
#       arrest_year <- selectTag(webElem)
#       setwd("C:/Users/user/Downloads")
#       for (arrest_year_val in 1:length(arrest_year$value)) {
#
#         arrest_year$elements[[arrest_year_val]]$clickElement()
#
#
#         wait_for_element(webDr,
#                          using = "css selector",
#                          value = download_button_css_selector,
#                          time_to_wait = 5)
#         selenium_clicker(remDr, using = "css selector",
#                          download_button_css_selector)
#
#         # Gives time to set auto-save on Firefox.
#         if (arrest_year_val == 1) {
#           Sys.sleep(10)
#         }
#
#         files <- list.files(pattern = ".csv$")
#         file.rename(files, gsub("2018\\(.*\\)", arrest_year$value[arrest_year_val],
#                                 files))
#       }
#
#       files <- list.files(pattern = ".csv$")
#       file.rename(files, paste0(ori, "_", files))
#       files <- list.files(pattern = ".csv$")
#       file.copy(files, "C:/Users/user/Desktop/cde")
#       file.remove(files)
#
#
#
#       # Arrests by age, sex, race
#       webElem <- remDr$findElement(using = "css selector",
#                                    "#crime-select")
#       ASR_crime <- selectTag(webElem)
#       webElem <- remDr$findElement(using = "css selector",
#                                    "year-ddl.mb2:nth-child(3) > select:nth-child(1)")
#       ASR_year <- selectTag(webElem)
#
#       male_arrest_button <- "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[1]/div/div/div/basic-table/div/button"
#
#       for (ASR_crime_val in 1:length(ASR_crime$text)) {
#         ASR_crime$elements[[ASR_crime_val]]$clickElement()
#
#         crime <- ASR_crime$text[ASR_crime_val]
#         crime <- tolower(gsub(" |-|:|,|/", "_", crime))
#         crime <- gsub("_+", "_", crime)
#
#         # No data on manslaughter so skips the loop
#         if (ASR_crime$text[[ASR_crime_val]] == "Manslaughter by Negligence") {
#           next
#         }
#         wait_for_element(webDr,
#                          using = "xpath",
#                          value = male_arrest_button,
#                          time_to_wait = 13)
#
#         # Uses just 2016-2018 since takes FOREVER to download all years!
#         for (ASR_year_val in 1:3) {
#           ASR_year$elements[[ASR_year_val]]$clickElement()
#           wait_for_element(webDr,
#                            using = "xpath",
#                            value = male_arrest_button,
#                            time_to_wait = 10)
#
#
#
#           # Male arrests by age
#           selenium_clicker(remDr, using = "xpath",
#                            "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[1]/div/div/div/basic-table/div/button")
#
#           # Pauses for time to save files by default
#           if (ASR_crime_val == 1 & ASR_year_val == 1) Sys.sleep(10)
#
#           # Female arrests by age
#           selenium_clicker(remDr, using = "xpath",
#                            "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[2]/div/div/div/basic-table/div/button")
#
#           # Arrests by race
#           selenium_clicker(remDr, using = "xpath",
#                            "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div/div/basic-table/div/button")
#           # Arrests by sex
#           selenium_clicker(remDr, using = "xpath",
#                            "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div/div/stack-table/div/div[2]/button")
#
#           Sys.sleep(2)
#           files <- list.files(pattern = ".csv$")
#           # For crimes without any reports there will be no files downloaded.
#           # This avoids code crashing since you can't rename a file that
#           # doesn't exist.
#           if (length(files) > 0) {
#             file.rename(files, gsub("2018",
#                                     ASR_year$value[ASR_year_val],
#                                     files))
#             files <- list.files(pattern = ".csv$")
#             file.rename(files, paste0(ori, "_", crime, "_", files))
#
#             files <- list.files(pattern = ".csv$")
#             file.copy(files, "C:/Users/user/Desktop/cde")
#             file.remove(files)
#             Sys.sleep(0.5)
#           }
#
#         }
#       }
#     }
#   }
#
#   files <- list.files(pattern = ".csv$")
#   if (length(files) > 0) {
#     if (page_name == "crime") {
#       file.rename(files, gsub(agency_name, ori, files))
#     } else if (page_name %in% c("pe", "arrest")) {
#       file.rename(files, paste0(ori, "_", files))
#     }
#     files <- list.files(pattern = ".csv$")
#     file.copy(files, "C:/Users/user/Desktop/cde")
#     file.remove(files)
#   }
#   message(i)
# }
#
