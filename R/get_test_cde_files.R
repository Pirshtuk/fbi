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
#   webElem <- remDr$findElement(using = using,
#                                value)
#   webElem$clickElement()
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
#   sample_n(100)
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
# #get_cde_test_files("crime", "#explorer > div > div.mb3.ng-scope > div > div > div.bg-white > line-chart > div.clearfix.pt1.mb1 > button")
# # get_cde_test_files("pe", "line-chart.ng-isolate-scope:nth-child(2) > div:nth-child(4) > button:nth-child(1)")
# get_cde_test_files("arrest", "div.mt1:nth-child(5) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > basic-table:nth-child(1) > div:nth-child(3) > button:nth-child(1)")
# get_cde_test_files <- function(page_name, download_button_css_selector) {
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
#
#
#     years <- selectTag(webElem)
#     years$elements[[1]]$clickElement()
#     Sys.sleep(10)
#
#     if (page_name == "crime") {
#       # 10 crimes total.
#       for (crime_num in 1:10) {
#         webElem <- remDr$findElement(using = "css selector", "#crime-select")
#         crimes <- selectTag(webElem)
#         crimes$elements[[crime_num]]$clickElement()
#         Sys.sleep(15)
#
#         selenium_clicker(remDr, using = "css selector",
#                          download_button_css_selector)
#         Sys.sleep(1)
#       }
#     } else if (page_name == 'pe') {
#       selenium_clicker(remDr, using = "css selector",
#                        download_button_css_selector)
#       Sys.sleep(3)
#     } else if (page_name == 'arrest') {
#       webElem <- remDr$findElement(using = "css selector", "year-ddl.mb2:nth-child(2) > select:nth-child(1)")
#       arrest_year <- selectTag(webElem)
#       setwd("C:/Users/user/Downloads")
#       for (arrest_year_val in 1:length(arrest_year$value)) {
#
#         arrest_year$elements[[arrest_year_val]]$clickElement()
#         # Gives time to set auto-save on Firefox.
#         if (arrest_year_val == 1) {
#           Sys.sleep(10)
#         }
#         Sys.sleep(5)
#         selenium_clicker(remDr, using = "css selector",
#                          download_button_css_selector)
#
#         files <- list.files(pattern = ".csv$")
#         file.rename(files, gsub("2018\\(.*\\)", arrest_year$value[arrest_year_val],
#                                 files))
#       }
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
#       for (ASR_year_val in 1:length(ASR_year$text)) {
#         ASR_year$elements[[ASR_year_val]]$clickElement()
#         Sys.sleep(5)
#         for (ASR_crime_val in 1:length(ASR_crime$text)) {
#           ASR_crime$elements[[ASR_crime_val]]$clickElement()
#           Sys.sleep(10)
#         }
#           crime <- ASR_crime$text[ASR_crime_val]
#           crime <- tolower(gsub(" |-", "_", crime))
#           crime <- gsub("_+", "_", crime)
#
#           # VA0205SP00
#           # Manslaughter
#           # Rape
#           # Sex Offenses
#           # Burglary
#           # Curfew
#           # Suspcicion
#           # Vagrancy
#           # Gambling - Bookmaking
#           # Gambling - Numbers and lottery
#           # Human trafficking - commercial sex acts
#           # Human trafficking - involuntary servitude
#           # Prostitution and commercialized vice
#           # Prostitution and commercialized vice - assisting
#           # Prostitution and commercialized vice - prostitution
#           # Prostitution and commercialized vice - purchasing
#
#           # AK0010100
#           # Manslaughter
#           # Gambling - all other
#           # Gambling - numbers and lottery
#           # Human trafficking - commercial sex acts
#           # Human trafficking - involuntary servitude
#           # Prostitution and commercialized vice - assisting
#
#
#
#           # Male arrests by age
#           selenium_clicker(remDr, using = "xpath",
#                            "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[1]/div/div/div/basic-table/div/button")
#           Sys.sleep(1)
#           # Female arrests by age
#           selenium_clicker(remDr, using = "xpath",
#                            "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[2]/div/div/div/basic-table/div/button")
#           Sys.sleep(1)
#           # Arrests by race
#           selenium_clicker(remDr, using = "xpath",
#                            "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div/div/basic-table/div/button")
#           Sys.sleep(1)
#           # Arrests by sex
#           selenium_clicker(remDr, using = "xpath",
#                            "/html/body/ui-view/div[2]/div[2]/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div/div/stack-table/div/div[2]/button")
#           Sys.sleep(1)
#
#           files <- list.files(pattern = ".csv$")
#           files <- files[grep("^all", files, invert = TRUE)]
#           file.rename(files, gsub("2018",
#                                   ASR_year$value[ASR_year_val],
#                                   files))
#           files <- list.files(pattern = ".csv$")
#           files <- files[grep("^all", files, invert = TRUE)]
#           file.rename(files, paste0(crime, "_", files))
#
#         }
#       }
#
#
#
#
#     }
#   }
#
#   files <- list.files(pattern = ".csv$")
#   if (page_name == "crime") {
#     file.rename(files, gsub(agency_name, ori, files))
#   } else if (page_name %in% c("pe", "arrest")) {
#     file.rename(files, paste0(ori, "_", files))
#   }
#   files <- list.files(pattern = ".csv$")
#   file.copy(files, "C:/Users/user/Desktop/cde")
#   file.remove(files)
#
#   message(i)
# }
#
