#' @name jira
#' @title Connect to a jira instance
#' @param jira_url base url to jira. Defaults to 'jira/'
#' @export
#' @examples
#' jira()
jira <- function(scheme = c("http", "https"),
                               host = "localhost",
                               port = 8080,
                               user = "user",
                               pass = "pass",
                               project = "/",
                               verbose = FALSE,
                               curl_options = NULL){


  #try to detect some obvious inconsistencies here


  #send a test-GET and evaluate response

  # create list of server connection details
  jira_conn_detail <-
    list(
      scheme = match.arg(scheme, c("http", "https")),
      host = host,
      port = port,
      user = user,
      auth = authenticate(user = user, password = pass, "basic"),
      verbose = verbose,
      config = curl_options
  )
  invisible(jira_conn_detail)

}

#' @name search_url
#' @title Get jira search url
#' @param jira_url base url to jira. Defaults to 'jira/'
#' @return string
#' @export
#' @examples
#' search_url()
search_url <-  function(con){
  
  search_url <- modify_url("",scheme=con$scheme, hostname = con$host,port = con$port, path = "rest/api/latest/search?")
  
  return(search_url)
  
}




#' @name issue_url
#' @title Get jira issue url
#' @param jira_url base url to jira. Defaults to 'jira/'
#' @return string
#' @export
#' @examples
#' issue_url()
issue_url <- function(con){
  
  issue_url <- modify_url("",scheme=con$scheme, hostname = con$host,port = con$port, path = "rest/api/latest/issue/")
  
  return(issue_url)
  
}

#' @name project_url
#' @title Get jira project url
#' @param jira_url base url to jira. Defaults to 'jira/'
#' @return string
#' @export
#' @examples
#' issue_url()
project_url <- function(con){
  
  project_url <- modify_url("",scheme=con$scheme, hostname = con$host,port = con$port, path = "rest/api/2/project")
  
  return(project_url)
  
}




jira_get <- function(url = url, con){
  
  res <- GET(url = url,
             con$auth,
             add_headers("Content-Type" = "application/json"),
             verbose(data_out = con$verbose, data_in = con$verbose, info = con$verbose)
  )
  
  return(res)
}





jira_post <- function(body, url, con){
  
  POST(url = url,
       body = jsonlite::toJSON(body),
       con$auth,
       add_headers("Content-Type" = "application/json"),
       verbose(data_out = con$verbose, data_in = con$verbose, info = con$verbose)
  )
  
}




