% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{setNested,character,ANY,environment-method}
\alias{setNested,character,ANY,environment-method}
\alias{setNested-char-any-char-method}
\title{Set Nested (char-any-env)}
\usage{
\S4method{setNested}{character,ANY,environment}(id, value,
  where = parent.frame(), fail_value = NULL, force = FALSE, gap = TRUE,
  must_exist = FALSE, reactive = FALSE, return_status = TRUE,
  strict = c(0, 1, 2), typed = FALSE, ...)
}
\arguments{
\item{id}{\code{\link{character}}.}

\item{value}{\code{\link{ANY}}.}

\item{where}{\code{\link{environment}}.}

\item{fail_value}{\code{\link{ANY}}.
Value that is returned if assignment failed and \code{return_status = FALSE}.}

\item{force}{\code{\link{logical}}.
\code{TRUE}: when \code{dirname(id)} points to a \emph{leaf} instead of a
\emph{branch} (i.e. \code{dirname(id)} is not an \code{environment}),
overwrite it to turn it into a branch and vice versa when \code{id} points
to a branch that is to be transformed into a leaf;
\code{FALSE}: either return with \code{fail_value} or throw error in such cases
(depending on value of \code{strict});}

\item{gap}{\code{\link{logical}}.
\code{TRUE}: when \code{dirname(id)} points to a non-existing parent
branch or if there are any missing branches in the nested structure,
then auto-create all missing branches;
\code{FALSE}: either return with \code{fail_value} or throw a condition
     in such cases (depending on \code{strict});
Default: \code{TRUE} as this seems to be most practical/convenient for
actual applications.}

\item{must_exist}{\code{\link{logical}}.
\code{TRUE}: \code{id} pointing to a non-existing component either results
in return value \code{fail_value} or triggers a condition
(depending on \code{strict});
\code{FALSE}: object value that \code{id} points to is set.}

\item{reactive}{\code{\link{logical}}.
\code{TRUE}: set reactive object value via
\code{\link[nestr]{setReactive}} or \code{\link[nestr]{setShinyReactive}}.
\code{FALSE}: set regular/non-reactive object value.
Note that if \code{value = reactiveExpression()}, \code{reactive} is
automatically set to \code{TRUE}.}

\item{return_status}{\code{\link{logical}}.
     \code{TRUE}: return status (\code{TRUE} for successful assignment,
         \code{FALSE} for failed assignment);
\code{FALSE}: return actual assignment value (\code{value}) or
\code{fail_value}.}

\item{strict}{\code{\link{logical}}.
     Controls what happens when \code{id} points to a non-existing component:
\itemize{
         \item{0: }{ignore and return \code{FALSE} to signal that the
             assignment process was not successful or \code{fail_value} depending
             on the value of \code{return_status}}
         \item{1: }{ignore and with warning and return \code{FALSE}}
         \item{2: }{ignore and with error}
   }}

\item{typed}{\code{\link{logical}}.
\code{TRUE}: create an implicitly typed component;
\code{FALSE}: create a regular component.}
}
\value{
\code{\link{logical}}. \code{TRUE}.
}
\description{
See generic: \code{\link[nestr]{setNested}}
}
\examples{
\dontrun{

##------------------------------------------------------------------------------
## Basics //
##------------------------------------------------------------------------------

## Simple name/ID //
setNested(id = "test", value = TRUE)
getNested(id = "test")

## Path-like name/ID //
setNested(id = "test/a", value = TRUE, strict = 2)
## --> note that currently `test` is a leaf, not a branch
setNested(id = "test/a", value = TRUE, force = TRUE)
## --> `test` needs to be transformed from a "leaf"
## to a "branch" component (i.e. an environment); `force = TRUE` 
## takes care of that

getNested(id = "test")
## --> branch
ls(getNested(id = "test"))
getNested(id = "test/a")
## --> leaf

## Must exist //
setNested(id = "test/b", value = TRUE, must_exist = TRUE)
try(setNested(id = "test/b", value = TRUE, must_exist = TRUE, strict = 2))

## Typed //
setNested(id = "test/c", value = "hello world!", typed = TRUE)
setNested(id = "test/c", value = 1:3)
## --> wrong class, but `strict_set = 0` --> disregarded without warning or error
getNested(id = "test/c")
## --> still `hello world!` because `value = 1:3` had wrong class

setNested(id = "test/c", value = "hello world!", typed = TRUE, strict_set = 1)
try(setNested(id = "test/c", value = 1:3))
## --> warning and no assignment
getNested(id = "test/c")
## --> still `hello world!`

setNested(id = "test/c", value = "hello world!", typed = TRUE, strict_set = 2)
try(setNested(id = "test/c", value = 1:3))
## --> error
getNested(id = "test/c")
## --> still `hello world!`

setNested(id = "test/a", value = "something else")
## --> correct class --> value changed 
getNested(id = "test/a")
  
## Clean up //
rm(test)

##------------------------------------------------------------------------------
## Different `where` //
##------------------------------------------------------------------------------

where <- new.env()
setNested(id = "a/b/c", value = 10, where = where)
getNested(id = "a/b/c", where = where)
identical(getNested(id = "a/b/c", where = where), where$a$b$c)

## Clean up //
rm(where)

##------------------------------------------------------------------------------
## Return value //
##------------------------------------------------------------------------------

(setNested(id = "test", value = 10, return_status = FALSE))
## --> return value is `10` instead of `TRUE`
getNested(id = "test")

## Constellations that lead to failed assignment //
(setNested(id = "a/b", value = 10, gap = FALSE, return_status = FALSE))
## --> returns `NULL` as `fail_value = NULL`
getNested(id = "a/b")
## --> returns `NULL` as component does not exist and `default = NULL`
getNested(id = "a/b", default = "does not exist")
## --> returns `"does not exist"`

(setNested(id = "a/b", value = 10, gap = FALSE, 
  return_status = FALSE, fail_value = NA))
## --> returns `NA` as `fail_value = NA`
getNested(id = "a/b")
## --> returns `NULL` as component does not exist and `default = NULL`

##------------------------------------------------------------------------------
## Numerical names/IDs //
##------------------------------------------------------------------------------

setNested(id = "20140101", value = TRUE)
"20140101" \%in\% ls(all.names = TRUE)
getNested(id = "20140101")

## Clean up //
rm("20140101")

##------------------------------------------------------------------------------
## Branch gaps //
##------------------------------------------------------------------------------
  
setNested(id = "a/b/c/d", value = TRUE, gap = FALSE)
try(setNested(id = "a/b/c/d", value = TRUE, gap = FALSE, strict = 2))
## --> branch gap: branches a, b and c do not exist yet

## Closing the gap //
setNested(id = "a/b/c/d", value = TRUE)

## Inspect //
ls()
ls(getNested(id = "a"))
ls(getNested(id = "a/b"))
ls(getNested(id = "a/b/c"))
getNested(id = "a/b/c/d")

## Clean up //
rm(a)

##------------------------------------------------------------------------------
## Forcing leafs to branches //
##------------------------------------------------------------------------------
  
setNested(id = "a", value = "hello world!")
setNested(id = "a/b", value = 10)
try(setNested(id = "a/b", value = 10, strict = 2))
## --> currently, `a` is leaf instead of a branch (environment):
getNested(id = "a")

## Forcing leaf into a branch //
setNested(id = "a/b", value = 10, force = TRUE)
ls(getNested(id = "a"))
## --> branch 
getNested(id = "a/b")
## --> leaf

## Clean up //
rm(a)

##------------------------------------------------------------------------------
## Forcing branches to leafs //
##------------------------------------------------------------------------------

setNested(id = "a/b", value = 10)
setNested(id = "a", value = 10)
try(setNested(id = "a", value = 10, strict = 2)
## --> currently, `a` is a branch that contains leafs --> structural 
## inconsistency and therefore blocked until `force = TRUE`

## Forcing a branch into a leaf //
## That means all potentially existing leafs of that branch are lost!
setNested(id = "a", value = 10, force = TRUE)
getNested(id = "a")
## --> leaf 

## Clean up //
rm(a)

##------------------------------------------------------------------------------
## Reactive object values //
##------------------------------------------------------------------------------

setNested(id = "dirs/root", value = getwd(), reactive = TRUE)
setNested(
  id = "dirs/my_dir", 
  value = reactiveExpression(
    file.path(getNested(id = "dirs/root", where = parent.frame(7)), "my_dir")
  )
)
## --> `dirs/my_dir` should always dependent on of `dirs/root`
## --> note that you can ommit `reactive = TRUE` when `value = reactiveExpression(...)`
## --> Issue #1: need to specify `where = parent.frame(7)`

getNested(id = "dirs/root")
getNested(id = "dirs/my_dir")

## Changing via `setNested()` //
setNested(id = "dirs/root", value = tempdir())
getNested(id = "dirs/root")
getNested(id = "dirs/my_dir")

## When changed manually //
dirs$root <- "c:/temp"
dirs$root
dirs$my_dir

## Trying to change reactive observer //
setNested(id = "dirs/my_dir", value = TRUE)
getNested(id = "dirs/my_dir")
## --> has no effect; warning and error behavior can be 
## controlled via `strict_set`

## Clean up //
rm(dirs)

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
   \link[nestr]{setNested}
}
}

