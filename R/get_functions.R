



#' @name get_projects
#' @title Get all projects
#' @param jira_url base JIRA url
#' @param jira_user username for authentication
#' @param jira_password password for authentication
#' @param verbose FALSE
#' @return TODO
#' @export
#' @seealso \code{\link{search_url}}
#' @examples
#' get_projects()
get_projects <- function(con){
  stopifnot(is.Rjiracon(con))
  
  res <- jira_get(url = project_url(con), con)
  
  if(http_type(res) == "application/json"){
    res <- jsonlite::fromJSON(content(res, as = "text"))
  } else{
    warning("Returning the response object - mime type was not application/json")
  }
  
  return(res)
  
}



#' @name get_issues
#' @title Get all issues matching the parameters
#' @param con the RjiraConnection object
#' @param user user to search for
#' @param max_results maximal number of results to be returned by Jira
#' @return deserialised JSON issues data frame
#' @export
#' @seealso \code{\link{search_url}}
#' @examples
#' 
#' \dontrun{
#' 
#' con <- jira(scheme = "https", host = 'localhost')
#' get_issues(con,user = "admin")
#' 
#' issues <- get_issues(project = "ADM", issue = "ADM-6")
#' 
#' ## Get list of issues assigned to user
#' res <- get_issues(user = "admin" , project_key = "ACME")
#' 
#' ## Issues of admin in all projects
#' res <- get_issues(user = "admin")
#' 
#' ## All issues in project ACME
#' res <- get_issues(project_key = "ACME")
#' 
#' }
#' 
#' 
get_issues <- function(con
                       , user = NULL
                       , max_results = 50
                       , start_at = 0
                       , content = NULL
                       , project_key = NULL
                       ){
  
  
  #### Parameter VALIDATION
  stopifnot(is.Rjiracon(con))
  
  if(!is.numeric(max_results) | max_results < 0){
    stop("max_results has to be a positive integer.")
  }

  if(!is.numeric(start_at)){
    start_at <- 0
  }
  #### END OF VALIDATION
    
  url <- search_url(con)
  if(!is.null(content)){
    # validate content perhaps. It may be
    #
    # *all - include all fields
    # *navigable - include just navigable fields
    # summary,comment - include just the summary and comments
    # -comment - include everything except comments (the default is *all for get-issue)
    # *all,-comment - include everything except comments

    url <- paste0(url, sprintf('fields="%s"&', content))
  }

  if(!is.null(project_key)){
    url <- paste0(url, sprintf('jql=project="%s"', project_key))
    if(!is.null(user))
      url <- paste(url, sprintf('AND assignee="%s"', user))
  
  }else if(!is.null(user)){
    url <- paste0(url, sprintf('jql=assignee="%s"', project_key))
  }


  # we have to use the pagination to be sure. The maxResults parameter has been limited 
  # and the number of returned issues may be even lower than requested, depending on Jira
  # backend configuration.

  #loop in all issues 
  result <- data.frame()
  repeat{
  
    res <- jira_get(url = paste0(url, sprintf('&startAt=%i&maxResults=%i', start_at + nrow(result), max_results - nrow(result))), 
                    con)
    if(http_type(res) == "application/json"){
      response <- jsonlite::fromJSON(content(res, as = "text"))
      total <- response$total
      result <- rbind(result,response$issues)
    } else{
      stop("Response mime type was not application/json")
    }
  
    #do-while condition:
    if(nrow(result) >= min(max_results, total - start_at)) break
    if(start_at > total) break
  } # end of repreat

  return(result)
  
}


