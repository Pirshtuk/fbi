

test_that("state-level estimates works", {
  # Removes arson column and state number column
  expect_equal(get_estimated_crime(state_abb = "CA")[, -c(3, 16)],
               ca_estimate_crime)
  expect_equal(get_estimated_crime(state_abb = "PA")[, -c(3, 16)],
               pa_estimate_crime)
  expect_equal(get_estimated_crime(state_abb = "OH")[, -c(3, 16)],
               oh_estimate_crime)
  expect_equal(get_estimated_crime(state_abb = "ME")[, -c(3, 16)],
               me_estimate_crime)
  expect_equal(get_estimated_crime(state_abb = "NY")[, -c(3, 16)],
               ny_estimate_crime)
  expect_equal(get_estimated_crime(state_abb = "WY")[, -c(3, 16)],
               wy_estimate_crime)
  expect_equal(get_estimated_crime(state_abb = "DC")[, -c(3, 16)],
               dc_estimate_crime)
})


test_that("agency-level ucr data works", {

  expect_equal(AL0210200_real[, ucr_matching_columns],
               read.csv_system_file('AL0210200_combined.csv'))
  expect_equal(AR0230600_real[, ucr_matching_columns],
               read.csv_system_file('AR0230600_combined.csv'))
  expect_equal(AR0600500_real[, ucr_matching_columns],
               read.csv_system_file('AR0600500_combined.csv'))
  expect_equal(AZ0072300_real[, ucr_matching_columns],
               read.csv_system_file('AZ0072300_combined.csv'))
  expect_equal(CA0190000_real[, ucr_matching_columns],
               read.csv_system_file('CA0190000_combined.csv'))
  expect_equal(CA0194200_real[, ucr_matching_columns],
               read.csv_system_file('CA0194200_combined.csv'))
  expect_equal(CA0250000_real[, ucr_matching_columns],
               read.csv_system_file('CA0250000_combined.csv'))
  expect_equal(CA0371100_real[, ucr_matching_columns],
               read.csv_system_file('CA0371100_combined.csv'))
  expect_equal(CA0380100_real[, ucr_matching_columns],
               read.csv_system_file('CA0380100_combined.csv'))
  expect_equal(CA0401300_real[, ucr_matching_columns],
               read.csv_system_file('CA0401300_combined.csv'))
  expect_equal(CA0421200_real[, ucr_matching_columns],
               read.csv_system_file('CA0421200_combined.csv'))
  expect_equal(CA0431300_real[, ucr_matching_columns],
               read.csv_system_file('CA0431300_combined.csv'))
  expect_equal(CA0470500_real[, ucr_matching_columns],
               read.csv_system_file('CA0470500_combined.csv'))
  expect_equal(CO0020100_real[, ucr_matching_columns],
               read.csv_system_file('CO0020100_combined.csv'))
  expect_equal(CT0000200_real[, ucr_matching_columns],
               read.csv_system_file('CT0000200_combined.csv'))
  expect_equal(FL0130000_real[, ucr_matching_columns],
               read.csv_system_file('FL0130000_combined.csv'))
  expect_equal(FL0160200_real[, ucr_matching_columns],
               read.csv_system_file('FL0160200_combined.csv'))
  expect_equal(FL0229000_real[, ucr_matching_columns],
               read.csv_system_file('FL0229000_combined.csv'))
  expect_equal(FL0290000_real[, ucr_matching_columns],
               read.csv_system_file('FL0290000_combined.csv'))
  expect_equal(FL0350800_real[, ucr_matching_columns],
               read.csv_system_file('FL0350800_combined.csv'))
  expect_equal(GA1440000_real[, ucr_matching_columns],
               read.csv_system_file('GA1440000_combined.csv'))
  expect_equal(GA1560100_real[, ucr_matching_columns],
               read.csv_system_file('GA1560100_combined.csv'))
  expect_equal(HI0020000_real[, ucr_matching_columns],
               read.csv_system_file('HI0020000_combined.csv'))
  expect_equal(IA0690100_real[, ucr_matching_columns],
               read.csv_system_file('IA0690100_combined.csv'))
  expect_equal(IL0460000_real[, ucr_matching_columns],
               read.csv_system_file('IL0460000_combined.csv'))
  expect_equal(IL0630400_real[, ucr_matching_columns],
               read.csv_system_file('IL0630400_combined.csv'))
  expect_equal(IL0901900_real[, ucr_matching_columns],
               read.csv_system_file('IL0901900_combined.csv'))
  expect_equal(ILCPD0000_real[, ucr_matching_columns],
               read.csv_system_file('ILCPD0000_combined.csv'))
  expect_equal(IN0200200_real[, ucr_matching_columns],
               read.csv_system_file('IN0200200_combined.csv'))
  expect_equal(IN0410800_real[, ucr_matching_columns],
               read.csv_system_file('IN0410800_combined.csv'))
  expect_equal(IN0420100_real[, ucr_matching_columns],
               read.csv_system_file('IN0420100_combined.csv'))
  expect_equal(IN0490400_real[, ucr_matching_columns],
               read.csv_system_file('IN0490400_combined.csv'))
  expect_equal(INIPD0000_real[, ucr_matching_columns],
               read.csv_system_file('INIPD0000_combined.csv'))
  expect_equal(KY0420700_real[, ucr_matching_columns],
               read.csv_system_file('KY0420700_combined.csv'))
  expect_equal(LA0190100_real[, ucr_matching_columns],
               read.csv_system_file('LA0190100_combined.csv'))
  expect_equal(MA0090700_real[, ucr_matching_columns],
               read.csv_system_file('MA0090700_combined.csv'))
  expect_equal(MD0160400_real[, ucr_matching_columns],
               read.csv_system_file('MD0160400_combined.csv'))
  expect_equal(MN0730600_real[, ucr_matching_columns],
               read.csv_system_file('MN0730600_combined.csv'))
  expect_equal(MO0956200_real[, ucr_matching_columns],
               read.csv_system_file('MO0956200_combined.csv'))
  expect_equal(MS0020000_real[, ucr_matching_columns],
               read.csv_system_file('MS0020000_combined.csv'))
  expect_equal(MS0250000_real[, ucr_matching_columns],
               read.csv_system_file('MS0250000_combined.csv'))
  expect_equal(NB0710000_real[, ucr_matching_columns],
               read.csv_system_file('NB0710000_combined.csv'))
  expect_equal(NBNSP2000_real[, ucr_matching_columns],
               read.csv_system_file('NBNSP2000_combined.csv'))
  expect_equal(NC0030000_real[, ucr_matching_columns],
               read.csv_system_file('NC0030000_combined.csv'))
  expect_equal(NC0460200_real[, ucr_matching_columns],
               read.csv_system_file('NC0460200_combined.csv'))
  expect_equal(NC0600100_real[, ucr_matching_columns],
               read.csv_system_file('NC0600100_combined.csv'))
  expect_equal(NC0670300_real[, ucr_matching_columns],
               read.csv_system_file('NC0670300_combined.csv'))
  expect_equal(NH008010X_real[, ucr_matching_columns],
               read.csv_system_file('NH008010X_combined.csv'))
  expect_equal(NJ0024600_real[, ucr_matching_columns],
               read.csv_system_file('NJ0024600_combined.csv'))
  expect_equal(NJ0121300_real[, ucr_matching_columns],
               read.csv_system_file('NJ0121300_combined.csv'))
  expect_equal(NJ0151400_real[, ucr_matching_columns],
               read.csv_system_file('NJ0151400_combined.csv'))
  expect_equal(NV0020100_real[, ucr_matching_columns],
               read.csv_system_file('NV0020100_combined.csv'))
  expect_equal(NY0290000_real[, ucr_matching_columns],
               read.csv_system_file('NY0290000_combined.csv'))
  expect_equal(NY0303000_real[, ucr_matching_columns],
               read.csv_system_file('NY0303000_combined.csv'))
  expect_equal(NY0350200_real[, ucr_matching_columns],
               read.csv_system_file('NY0350200_combined.csv'))
  expect_equal(NY0510100_real[, ucr_matching_columns],
               read.csv_system_file('NY0510100_combined.csv'))
  expect_equal(NY0513600_real[, ucr_matching_columns],
               read.csv_system_file('NY0513600_combined.csv'))
  expect_equal(NY0560100_real[, ucr_matching_columns],
               read.csv_system_file('NY0560100_combined.csv'))
  expect_equal(OH0350400_real[, ucr_matching_columns],
               read.csv_system_file('OH0350400_combined.csv'))
  expect_equal(OH0451300_real[, ucr_matching_columns],
               read.csv_system_file('OH0451300_combined.csv'))
  expect_equal(OH0691100_real[, ucr_matching_columns],
               read.csv_system_file('OH0691100_combined.csv'))
  expect_equal(OK0170100_real[, ucr_matching_columns],
               read.csv_system_file('OK0170100_combined.csv'))
  expect_equal(OR0030900_real[, ucr_matching_columns],
               read.csv_system_file('OR0030900_combined.csv'))
  expect_equal(PA0060500_real[, ucr_matching_columns],
               read.csv_system_file('PA0060500_combined.csv'))
  expect_equal(PA0115800_real[, ucr_matching_columns],
               read.csv_system_file('PA0115800_combined.csv'))
  expect_equal(PA0360700_real[, ucr_matching_columns],
               read.csv_system_file('PA0360700_combined.csv'))
  expect_equal(PA0406500_real[, ucr_matching_columns],
               read.csv_system_file('PA0406500_combined.csv'))
  expect_equal(PAPEP0000_real[, ucr_matching_columns],
               read.csv_system_file('PAPEP0000_combined.csv'))
  expect_equal(SC014FC00_real[, ucr_matching_columns],
               read.csv_system_file('SC014FC00_combined.csv'))
  expect_equal(SC0231000_real[, ucr_matching_columns],
               read.csv_system_file('SC0231000_combined.csv'))
  expect_equal(SC041SP00_real[, ucr_matching_columns],
               read.csv_system_file('SC041SP00_combined.csv'))
  expect_equal(SD0620200_real[, ucr_matching_columns],
               read.csv_system_file('SD0620200_combined.csv'))
  expect_equal(TN0570000_real[, ucr_matching_columns],
               read.csv_system_file('TN0570000_combined.csv'))
  expect_equal(TX0151100_real[, ucr_matching_columns],
               read.csv_system_file('TX0151100_combined.csv'))
  expect_equal(TX0610600_real[, ucr_matching_columns],
               read.csv_system_file('TX0610600_combined.csv'))
  expect_equal(TX0770100_real[, ucr_matching_columns],
               read.csv_system_file('TX0770100_combined.csv'))
  expect_equal(TX1010000_real[, ucr_matching_columns],
               read.csv_system_file('TX1010000_combined.csv'))
  expect_equal(TX1016100_real[, ucr_matching_columns],
               read.csv_system_file('TX1016100_combined.csv'))
  expect_equal(TX2270100_real[, ucr_matching_columns],
               read.csv_system_file('TX2270100_combined.csv'))
  expect_equal(TX2300300_real[, ucr_matching_columns],
               read.csv_system_file('TX2300300_combined.csv'))
  expect_equal(TX2490000_real[, ucr_matching_columns],
               read.csv_system_file('TX2490000_combined.csv'))
  expect_equal(TXDPD0000_real[, ucr_matching_columns],
               read.csv_system_file('TXDPD0000_combined.csv'))
  expect_equal(TXHPD0000_real[, ucr_matching_columns],
               read.csv_system_file('TXHPD0000_combined.csv'))
  expect_equal(TXSPD0000_real[, ucr_matching_columns],
               read.csv_system_file('TXSPD0000_combined.csv'))
  expect_equal(VA0290100_real[, ucr_matching_columns],
               read.csv_system_file('VA0290100_combined.csv'))
  expect_equal(VA0510100_real[, ucr_matching_columns],
               read.csv_system_file('VA0510100_combined.csv'))
  expect_equal(VA0820500_real[, ucr_matching_columns],
               read.csv_system_file('VA0820500_combined.csv'))
  expect_equal(WI0540800_real[, ucr_matching_columns],
               read.csv_system_file('WI0540800_combined.csv'))
  expect_equal(WV0060200_real[, ucr_matching_columns],
               read.csv_system_file('WV0060200_combined.csv'))
  expect_equal(WV0140500_real[, ucr_matching_columns],
               read.csv_system_file('WV0140500_combined.csv'))

})
