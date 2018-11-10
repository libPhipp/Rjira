

.onLoad <- function(libname, pkgname){
  
  ## Set default options
  
  opts <- c( "jira_url" = '"/jira"'
             ,"jira_verbose" = "FALSE"
             
  )
  
  for (i in setdiff(names(opts),names(options()))){  ## makes sure we don't overwrite existing options
    # print(paste("options(",i,"=",opts[i],")",sep=""))
    eval(parse(text=paste("options(",i,"=",opts[i],")",sep="")))
  }
  
  
}

.onUnload <- function(libname, pkgname){
  # might want to assure that we do not leave any side effects
  if(!is.null(getOption("jira_url", default = NULL))){
   options("jira_url" = NULL)
  }

  if(!is.null(getOption("jira_user", default = NULL))){
   options("jira_user" = NULL)
  }

  if(!is.null(getOption("jira_password", default = NULL))){
   options("jira_password" = NULL)
  }

  if(!is.null(getOption("jira_verbose", default = NULL))){
   options("jira_verbose" = NULL)
  }
}


