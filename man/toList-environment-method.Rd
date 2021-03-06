% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{toList,environment-method}
\alias{toList,environment-method}
\alias{toList-env-method}
\title{To List (env)}
\usage{
\S4method{toList}{environment}(input, strict = FALSE, ...)
}
\arguments{
\item{input}{\code{\link{environment}}.}

\item{strict}{\code{\link{logical}}.
\code{TRUE}:
\code{FALSE}:}

\item{...}{Further arguments to be passed to subsequent functions/methods.}
}
\value{
\code{\link{list}}. Nested object structure.
}
\description{
See generic: \code{\link[nestr]{toList}}
}
\examples{
\dontrun{

##------------------------------------------------------------------------------  
## Names //
##------------------------------------------------------------------------------

input <- new.env()
setNested("europe/germany/berlin", value = 1, where = input, gap = TRUE)
setNested("europe/germany/hamburg", value = 2, where = input)
setNested("europe/germany/munich", value = 3, where = input)
setNested("america/usa/wisconsin/madison", value = 1, where = input, gap = TRUE)
setNested("south.america", value = 1, where = input)

toList(input = input)
res <- fromList(toList(input), where = new.env())
ls(res)

##------------------------------------------------------------------------------  
## No names //
##------------------------------------------------------------------------------

input <- new.env()
setNested("[1]/id", value = 1, where = input, gap = TRUE)
setNested("[1]/name", value = "abc", where = input, gap = TRUE)
setNested("[2]/id", value = "2", where = input, gap = TRUE)
setNested("[2]/name", value = "def", where = input, gap = TRUE)
setNested("[2]/address", value = "asdfasdf", where = input, gap = TRUE)

toList(input)
res <- fromList(toList(input), where = new.env())
ls(res)

##------------------------------------------------------------------------------  
## Mixed //
##------------------------------------------------------------------------------

input <- new.env()
setNested("[1]/id", value = 1, where = input, gap = TRUE)
setNested("[1]/name", value = "abc", where = input, gap = TRUE)
setNested("[2]/id", value = "2", where = input, gap = TRUE)
setNested("[2]/name", value = "def", where = input, gap = TRUE)
setNested("[2]/address", value = "asdfasdf", where = input, gap = TRUE)
setNested("john_doe/id", value = "2", where = input, gap = TRUE)
setNested("john_doe/name", value = "john doe", where = input, gap = TRUE)
setNested("john_doe/address", value = "asdfasdf", where = input, gap = TRUE)

toList(input)
res <- fromList(toList(input), where = new.env())
ls(res)

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
   \link[nestr]{toList}
}
}

