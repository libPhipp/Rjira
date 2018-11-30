context("Getter functions")

test_that("get_issues test max_results",{
  
  con <- jira(scheme = "https", host = 'localhost')
  expect_error(get_issues(con, max_results=-2), "max_results.*")
  expect_error(get_issues(con, max_results="V"), "max_results.*")
})

test_that("get_issues test con",{
  
  expect_error(get_issues(max_results=2, start_at = 2), "Argument \"con\"")
})