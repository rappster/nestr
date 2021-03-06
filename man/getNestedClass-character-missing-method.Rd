% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{getNestedClass,character,missing-method}
\alias{getNestedClass,character,missing-method}
\alias{getNestedClass-char-miss-method}
\title{Get Nested (char-miss)}
\usage{
\S4method{getNestedClass}{character,missing}(id, where = parent.frame(),
  default = NULL, strict = c(0, 1, 2), ...)
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
   \code{\link[nestr]{getNestedClass-char-char-method}}
}
\description{
See generic: \code{\link[nestr]{getNestedClass}}
}
\examples{
\dontrun{

##------------------------------------------------------------------------------
## Basics //
##------------------------------------------------------------------------------

setNested(id = "test", value = TRUE)
getNestedClass(id = "test")

setNested(id = "a/b/c", value = 10)
getNestedClass(id = "a")
getNestedClass(id = "a/b")
getNestedClass(id = "a/b/c")
getNestedClass(id = "a/b/c/d")

getNestedClass(id = "c")
getNestedClass(id = "c/d/e")
  
##------------------------------------------------------------------------------
## Strictness levels //
##------------------------------------------------------------------------------

## Empty ID //
getNestedClass(id = character())
try(getNestedClass(id = character(), strict = 1))
try(getNestedClass(id = character(), strict = 2))

## Not-existing //  
getNestedClass(id = "c/d/e")
try(getNestedClass(id = "c/d/e", strict = 1))
try(getNestedClass(id = "c/d/e", strict = 2))

##------------------------------------------------------------------------------
## Explicit `where` //
##------------------------------------------------------------------------------

where <- new.env()
setNested(id = "a/b/c", value = 10, where = where)
getNestedClass(id = "a/b/c", where = where)
getNestedClass(id = "a/b/c/d", where = where)
getNestedClass(id = "c/d/e", where = where)

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
   \link[nestr]{getNestedClass}
}
}

