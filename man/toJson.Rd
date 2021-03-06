% Generated by roxygen2 (4.0.2): do not edit by hand
\name{toJson}
\alias{toJson}
\title{To JSON (generic)}
\usage{
toJson(input, strict = FALSE, ...)
}
\arguments{
\item{input}{\strong{Signature argument}.
Object containing JSON input.}

\item{strict}{\code{\link{logical}}.
\code{TRUE}:
\code{FALSE}:}

\item{Further}{arguments passed along to subsequent functions.
In particular:
\code{\link[jsonlite]{toJson}}.}
}
\description{
Retrieves value from a nested object structure based on a path-like
\code{input} with the last ID component being the actual object name that contains
the value.
}
\section{Path-like identifiers}{


Values for \code{id} are expected to be of structure \code{a/b/c/.../z},
i.e. path-like identifiers using a slash as separator.
The identifier is transformed to \code{a$b$c$...$z} and then in turn to a
valid \emph{get} or \code{assign} expression
(i.e. \code{a$b$c$...$z} and \code{a$b$c$...$z <- value}).
Of course, "atomic" paths (e.g. only \code{a}) are also valid.
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

toJson(input = input)
res <- fromJson(toJson(input), where = new.env())
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

toJson(input)
res <- fromJson(toJson(input), where = new.env())
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

toJson(input)
res <- fromJson(toJson(input), where = new.env())
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
  	\link[nestr]{toJson-env-method}
}
}

