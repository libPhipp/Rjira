context("Helper functions")


test_that("issue_url",{
  
    con <- jira(scheme = "https", host = 'localhost')
    url <- issue_url(con)
    expect_equal("https://localhost:8080/rest/api/latest/issue/",url)
})

test_that("project_url",{
  
  con <- jira(scheme = "http", host = 'localhost')
  url <- project_url(con)
  expect_equal("http://localhost:8080/rest/api/latest/project/",url)
})

test_that("search_url",{
  
  con <- jira(scheme = "https", host = 'localhost', port = "443")
  url <- search_url(con)
  expect_equal("https://localhost:443/rest/api/latest/search?",url)
})