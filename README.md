# Rjira
Friendly JIRA REST API wrapper in R

This package is an extension of https://github.com/awalker89/Rjira
written by Alexander Walker and splits off of his version 0.1.1

This package is created to work on the API version 2 of Atlassian Jira REST API

## Installation

To install the package, use
- devtools::install_github("libPhipp/Rjira", ref="dev"), and
- library(RJira), to load the package into your R session.

## Usage

At the moment, the most convenient way to connect to a JIRA instance is:

```

library(Rjira)
jira <- jira(scheme = "https", host = 'localhost', user='username', pass='secret')
jira %>% get_projects() %>% 
         select(...) %>% 
         mutate(...)

```

## Changes
- Version 0.2.1
  - The project has switches from RJSONIO to jsonlite. A few of the reasons are shown e.g. here:
    (https://rstudio-pubs-static.s3.amazonaws.com/31702_9c22e3d1a0c44968a4a1f9656f1800ab.html)
    Moreover, jsonlite is now also used to parse JIRA responses and not only requests.

  - Added testing of this package using testthat  

  - Added .onUnload to remove possible side effects

  - The API support has been extended to supply
    - maxResults
    - startAt
    
- Version 0.2.2    

  - get_issues now has an automated depagination

  - default values for user/password/project/... are now stored in a connection object
  
  
## Roadmap

- Might like to add oauth soon
- Write vignettes


## License
GPL-3 as being inherited by the A. Walker version.