% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{rmNested,character,missing-method}
\alias{rmNested,character,missing-method}
\alias{rmNested-char-miss-method}
\title{Remove Nested (char-miss)}
\usage{
\S4method{rmNested}{character,missing}(id, where = parent.frame(),
  strict = c(0, 1, 2), ...)
}
\arguments{
\item{id}{\code{\link{character}}.}

\item{where}{\code{\link{missing}}.}

\item{strict}{\code{\link{logical}}.
     Controls what happens when \code{id} points to a non-existing component:
\itemize{
         \item{0: }{ignore and return \code{FALSE} to signal that the
             assignment process was not successful or \code{fail_value} depending
             on the value of \code{return_status}}
         \item{1: }{ignore and with warning and return \code{FALSE}}
         \item{2: }{ignore and with error}
   }}

\item{...}{Further arguments to be passed to subsequent functions/methods.}
}
\value{
See method
   \code{\link[nestr]{rmNested-char-env-method}}
}
\description{
See generic: \code{\link[nestr]{rmNested}}
}
\examples{
\dontrun{

##------------------------------------------------------------------------------
## Default `where` //
##------------------------------------------------------------------------------

setNested(id = "a", value = TRUE)
exists("a", environment(), inherits = FALSE)
rmNested(id = "a")
exists("a", environment(), inherits = FALSE)

setNested(id = "a/b/c", value = 10, gap = TRUE)
exists("c", environment()$a$b, inherits = FALSE)
rmNested(id = "a/b/c")
exists("c", environment()$a$b, inherits = FALSE)

## Clean up //
rm(a)

##------------------------------------------------------------------------------
## Different `where` // 
##------------------------------------------------------------------------------

where <- new.env()
setNested(id = "a/b/c", value = 10, where = where, gap = TRUE)
rmNested(id = "a/b/c", where = where)
exists("c", where$a$b, inherits = FALSE)

## Clean up //
rm(where)
  
##------------------------------------------------------------------------------
## Strictness //
##------------------------------------------------------------------------------

rmNested(id = "a")
try(rmNested(id = "a", strict = 1))
try(rmNested(id = "a", strict = 2))

rmNested(id = "a/b/c")
try(rmNested(id = "a/b/c", strict = 1))
try(rmNested(id = "a/b/c", strict = 2))

rmNested(id = character()))
try(rmNested(id = character(), strict = 1))
try(rmNested(id = character(), strict = 2))
    
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
   \link[nestr]{rmNested}
}
}

