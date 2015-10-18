% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/script.R
\name{add_watcher}
\alias{add_watcher}
\title{Add a watched to an existing issue}
\usage{
add_watcher(issue_id, user, jira_url = getOption("jira_url"),
  jira_user = getOption("jira_user"),
  jira_password = getOption("jira_password"),
  verbose = getOption("jira_verbose"))
}
\arguments{
\item{jira_url}{base url to JIRA. Defaults to 'jira/'}

\item{jira_user}{username for authentication}

\item{jira_password}{password for authentication}

\item{verbose}{FALSE}
}
\value{
POST results
}
\description{
Add a watched to an existing issue
}
