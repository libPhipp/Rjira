



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
get_projects <- function(jira_url = getOption("jira_url")
                         , jira_user = getOption("jira_user")
                         , jira_password = getOption("jira_password")
                         , verbose = getOption("jira_verbose")){
  
  if(is.null(jira_url))
    stop("jira_url is NULL")
  
  project_url <- paste(jira_url, "rest/api/2/project", sep = "/")
  res <- jira_get(url = project_url, user = jira_user, password = jira_password, verbose = verbose)
  
  if(http_type(res) == "application/json"){
    res <- jsonlite::fromJSON(content(res, as = "text"))
  } else{
    warning("Returning the response object - mime type was not application/json")
  }
  
  return(res)
  
  
}



#' @name get_issues
#' @title Get issues assigned to a user
#' @param user user to search for
#' @param jira_url base JIRA url
#' @param jira_user username for authentication
#' @param jira_password password for authentication
#' @return character vector of issues
#' @export
#' @seealso \code{\link{search_url}}
#' @examples
#' 
#' \dontrun{
#' 
#' get_issues(user = "admin")
#' 
#' issues <- get_issues(project = "ADM", issue = "ADM-6", verbose = T)
#' 
#' ## Get list of issues assigned to user
#' res <- get_issues(user = "admin" , project_key = getOption("jira_project"))
#' sapply(res, "[[", "id")
#' sapply(res, "[[", "key")
#' 
#' ## All projects
#' res <- get_issues(user = "admin" , project_key = NULL)
#' 
#' }
#' 
#' 
get_issues <- function(user = NULL
                       , max_results = NULL
                       , start_at = NULL
                       , content = NULL
                       , project_key = getOption("jira_project")
                       , jira_url = getOption("jira_url")
                       , jira_user = getOption("jira_user")
                       , jira_password = getOption("jira_password")
                       , verbose = getOption("jira_verbose")){
  
  if(is.null(jira_url))
    stop('jira_url is NULL. See getOption("jira_url")')
  
  if(is.null(jira_user))
    stop("jira_user is NULL")
  
  if(is.null(jira_password))
    stop("jira_password is NULL")

  
  url <- search_url(jira_url = jira_url)
  if(!is.null(content)){
    #validate content perhaps. It may be
    #
    #*all - include all fields
    #*navigable - include just navigable fields
    #summary,comment - include just the summary and comments
    #-comment - include everything except comments (the default is *all for get-issue)
    #*all,-comment - include everything except comments

    url <- paste0(url, sprintf('fields="%s"&', content))
  }

  if(!is.null(project_key)){
    url <- paste0(url, sprintf('jql=project="%s"', project_key))
    if(!is.null(user))
      url <- paste(url, sprintf('AND assignee="%s"', user))
  
  }else if(!is.null(user)){
    url <- paste0(url, sprintf('jql=assignee="%s"', project_key))
  }

  if(!is.numeric(start_at)){
    start_at <- 0
  }
  
  if(!is.null(max_results)){
    if(!is.numeric(max_results)){
      stop("max_results has to be a positive integer.")
    } else {
      if(max_results > 50 ){
        #we have to use the pagination to be sure. The maxResults parameter has been limited 
        #and maybe even partially deactiveated by jira.

        #if max_results if > some-threshold we'll have to loop here
        url <- paste0(url, sprintf('&startAt=%i&maxResults=%i', start_at, max_results))

        res <- jira_get(url = url, user = jira_user, password = jira_password, verbose = verbose)
        if(http_type(res) == "application/json"){
          res <- jsonlite::fromJSON(content(res, as = "text"))
          warning(paste("Received", res$maxResults,"of total", res$total, "issues."))
          res <- res$issues
        } else{
          warning("Returning the response object - mime type was not application/json")
        }
      }
    }
  } else {
    #the 'max_results is not set' case
      
    res <- jira_get(url = url, user = jira_user, password = jira_password, verbose = verbose)
    if(http_type(res) == "application/json"){
      res <- jsonlite::fromJSON(content(res, as = "text"))
      res <- res$issues
    } else{
      warning("Returning the response object - mime type was not application/json")
    }

  }

  
  return(res)
  
}


