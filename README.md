# Rjira
Friendly JIRA REST API wrapper in R

The 0.2.* version of this packages is an extension of https://github.com/awalker89/Rjira
written by Alexander Walker and splits off of his version 0.1.1

This package is create to work on the API version 2 of Atlassian Jira REST API

## Installation

To install package, use
- git clone, to get a local copy into a folder RJIRA_FOLDER
- devtools::install(RJIRA_FOLDER), to install the package to your R installation, and
- library(RJira), to load the package into your R session.

## Usage

At the moment, the most convenient way to connect to a JIRA instance is:

```
library(Rjira)
options("jira_user" = "your username")
options("jira_password" = rstudioapi::askForPassword("Jira password"))
options("jira_url" = "https://url_to_your_jira_instance.com")
options("jira_project" = "set a project default here")
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

## Roadmap

- Might like to add oauth soon
- Might like to add automated depagination soon
- Might want the change the placement of the default values
- Write vignettes


## License
GPL-3 as being inherited by the A. Walker version.