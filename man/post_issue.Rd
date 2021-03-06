% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/issue_class.R
\name{post_issue}
\alias{post_issue}
\title{post issue to JIRA}
\usage{
post_issue(issue, jira_url = getOption("jira_url"),
  jira_user = getOption("jira_user"),
  jira_password = getOption("jira_password"),
  verbose = getOption("jira_verbose"))
}
\arguments{
\item{issue}{An issue object}

\item{jira_url}{base url to JIRA. Defaults to 'jira/'}

\item{jira_user}{username for authentication}

\item{jira_password}{password for authentication}
}
\value{
POST results
}
\description{
post issue to JIRA
}
