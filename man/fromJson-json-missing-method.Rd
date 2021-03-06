% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{fromJson,json,missing-method}
\alias{fromJson,json,missing-method}
\alias{fromJson-json-miss-method}
\title{From JSON (json-miss)}
\usage{
\S4method{fromJson}{json,missing}(input, where = parent.frame(),
  strict = FALSE, ...)
}
\arguments{
\item{input}{\code{\link{json}}.}

\item{where}{\code{\link{missing}}.}

\item{strict}{\code{\link{logical}}.
\code{TRUE}:
\code{FALSE}:}
}
\value{
See method
		\code{\link[nestr]{fromJson-json-env-method}}.
}
\description{
See generic: \code{\link[nestr]{fromJson}}
}
\examples{
\dontrun{
  
##------------------------------------------------------------------------------
## data frame/simple/from file/parent frame //
##------------------------------------------------------------------------------
  
rm(list = ls(all.names = TRUE), envir = environment())
input <- jsonlite::toJSON(mtcars, pretty = TRUE)
input

res <- fromJson(input = input)
all(colnames(input) \%in\% ls(res))
identical(as.numeric(am), mtcars$am)

##------------------------------------------------------------------------------
## data frame/simple/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/orgs"
tmp <- jsonlite::fromJSON(input)

res <- fromJson(input = input)
all(colnames(tmp) \%in\% ls(res))

avatar_url

##------------------------------------------------------------------------------
## data frame/simple/from URL/custom environment //
##------------------------------------------------------------------------------

input <- "https://api.github.com/users/hadley/orgs"
tmp <- jsonlite::fromJSON(input)

where <- fromJson(input = input, where = new.env())
all(colnames(tmp) \%in\% ls(where)))

where$avatar_url

##------------------------------------------------------------------------------
## data frame/nested/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/repos"
tmp <- jsonlite::fromJSON(input)

res <- fromJson(input = input)
all(colnames(tmp) \%in\% ls(res))

id
owner

##------------------------------------------------------------------------------
## data frame/nested but flattened/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/repos"
tmp <- jsonlite::fromJSON(input, flatten = TRUE)
colnames(tmp)

res <- fromJson(input = input, flatten = TRUE)
all(colnames(tmp) \%in\% ls(res))

owner.type
id

##------------------------------------------------------------------------------
## list/simple nesting/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/orgs"
res <- fromJson(input = input, simplifyDataFrame = FALSE)
all(paste0("[", 1:6, "]") \%in\% ls(res))

environment()[["[1]"]]$avatar_url

##------------------------------------------------------------------------------
## list/complex nesting/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/repos"
tmp <- jsonlite::fromJSON(input)

res <- fromJson(input = input, simplifyDataFrame = FALSE)
all(paste0("[", 1:30, "]") \%in\% ls(res)))

environment()[["[1]"]]$owner
environment()[["[1]"]]$owner$type

##------------------------------------------------------------------------------
## list/simple nesting/from URL/custom environment //
##------------------------------------------------------------------------------

input <- "https://api.github.com/users/hadley/orgs"
where <- fromJson(input = input, where = new.env(), simplifyDataFrame = FALSE)
all(paste0("[", 1:3, "]") \%in\% ls(where))

where[["[1]"]]$avatar_url

##------------------------------------------------------------------------------
## list/complex nesting/from URL/custom environment //
##------------------------------------------------------------------------------

input <- "https://api.github.com/users/hadley/repos"
where <- fromJson(input = input, where = new.env(), simplifyDataFrame = FALSE)
all(paste0("[", 1:30, "]") \%in\% ls(where))

where[["[1]"]]$owner
where[["[1]"]]$owner$type

}
}
\author{
Janko Thyson \email{janko.thyson@rappster.de}
}
\references{
\url{http://github.com/Rappster/nestr}
}
\seealso{
\code{
   \link[nestr]{fromJson}
}
}

