

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
  expect_equal(AK0010100_real$aggravated_assault_actual,
               AK0010100_agg_assault$aggravated_assault_actual)
  expect_equal(AK0010100_real$aggravated_assault_cleared,
               AK0010100_agg_assault$aggravated_assault_cleared)
  expect_equal(AK0010100_real$ori,
               AK0010100_agg_assault$ori)

  expect_equal(AK0010100_real$violent_crime_actual,
               AK0010100_violent$violent_crime_actual)
  expect_equal(AK0010100_real$violent_crime_cleared,
               AK0010100_violent$violent_crime_cleared)
})
