nestr
======

Nested object structures

## Installation

```
require("devtools")
devtools::install_github("Rappster/conditionr")
devtools::install_github("Rappster/reactr")
devtools::install_github("Rappster/typr")
devtools::install_github("Rappster/nestr")
require("nestr")
```
## Purpose

The package provides an extendable interface to conveniently create nested object structures based on environments. 

Object values can be set and retrieved based on path-like names/identifiers (e.g. `output/print/type = "pdf"` will be translated into the following nested environment structure: `output$print$type` with the value being`"pdf"`). 

Also, it allows to specification of reactive nested object structures, i.e. objects that are dynamically linked to other objects and thus automatically stay synced.

Furthermore, the package provides means to transform nested environment structures to nested lists and JSON objects and vice versa.

## Vignettes

None so far

----------

## Managing nested object structures

### Create

```
setNested(id = "a/b/c", value = 10)
## --> structure: `environment()$a$b$c`; value: `10`
```

Strictness:

```
try(setNested(id = "a", value = 10, strict = 1))
try(setNested(id = "x_1/x_2", value = 10, gap = FALSE, strict = 1))
try(setNested(id = "x_1/x_2", value = 10, gap = FALSE, strict = 2))
```

### Retrieve

```
ls(getNested(id = "a"))
## --> branch (i.e. environment)
ls(getNested(id = "a/b"))
## --> branch (i.e. environment)
getNested(id = "a/b/c")
## --> leaf (i.e. non-environment value; actual value of interest)
```

### Return value

```
(setNested(id = "test", value = 10, return_status = FALSE))
## --> return value is `10` instead of `TRUE`
getNested(id = "test")
```
These constellations lead to failed assignments:

```
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
```

### Check existence 

```
##------------------------------------------------------------------------------
## Basics //
##------------------------------------------------------------------------------

setNested(id = "test", value = TRUE)
existsNested(id = "test")

setNested(id = "a/b/c", value = 10)
existsNested(id = "a")
existsNested(id = "a/b")
existsNested(id = "a/b/c")
existsNested(id = "a/b/c/d")

existsNested(id = "c")
existsNested(id = "c/d/e")
  
##------------------------------------------------------------------------------
## Strictness levels //
##------------------------------------------------------------------------------

## Empty ID //
existsNested(id = character())
try(existsNested(id = character(), strict = 1))
try(existsNested(id = character(), strict = 2))

## Not-existing //  
existsNested(id = "c/d/e")
try(existsNested(id = "c/d/e", strict = 1))
try(existsNested(id = "c/d/e", strict = 2))

##------------------------------------------------------------------------------
## Explicit `where` //
##------------------------------------------------------------------------------

where <- new.env()
setNested(id = "a/b/c", value = 10, where = where)
existsNested(id = "a/b/c", where = where)
existsNested(id = "a/b/c/d", where = where)
existsNested(id = "c/d/e", where = where)
```

### Remove

```
getNested(id = "a/b/c")
## --> exists
rmNested(id = "a/b/c")
getNested(id = "a/b/c")
## --> successfully removed
getNested(id = "a/b/c")
## --> `NULL` as component does not exist and `default = NULL`
getNested(id = "a/b/c", strict = 2)
## --> error as component does not exist
```
Strictness:

```
rmNested(id = "a")
try(rmNested(id = "a", strict = 1))
try(rmNested(id = "a", strict = 2))

rmNested(id = "a/b/c")
try(rmNested(id = "a/b/c", strict = 1))
try(rmNested(id = "a/b/c", strict = 2))

rmNested(id = character()))
try(rmNested(id = character(), strict = 1))
try(rmNested(id = character(), strict = 2))
```

### Transforming nested object structures

### To list

```
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
```

### From list

```
##------------------------------------------------------------------------------
## In parent frame //
##------------------------------------------------------------------------------  

input <- list(
  europe = list(germany = list(berlin = 1, hamburg = 2, munich = 3)),
  america = list(usa = list(wisconsin = list(madison = 1))),
  south.america = 1,
  as.list(1:3)
)

res <- fromList(input = input)
res
ls(res)
ls(europe)
ls(europe$germany)
getNested("europe/germany/berlin")

ls(res$"[4]")
getNested("[4]/[1]")
getNested("[4]/[2]")
getNested("[4]/[3]")

##------------------------------------------------------------------------------
## In custom environment //
##------------------------------------------------------------------------------  

input <- list(
  europe = list(germany = list(berlin = 1, hamburg = 2, munich = 3)),
  america = list(usa = list(wisconsin = list(madison = 1))),
  south.america = 1,
  as.list(1:3)
)

where <- new.env()
res <- fromList(input = input, where = where)
identical(res, where)

## A bit more convenient //
where <- fromList(input = input, where = new.env())

ls(where$europe)
ls(where$europe$germany)
getNested("where/europe/germany/berlin")
getNested("europe/germany/berlin", where = where)

ls(where$"[4]")
getNested("[4]/[1]", where = where)
getNested("[4]/[2]", where = where)
getNested("[4]/[3]", where = where)
```

### To JSON

```
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
```

### From JSON

```
##------------------------------------------------------------------------------
## data frame/simple/from file/parent frame //
##------------------------------------------------------------------------------
  
rm(list = ls(all.names = TRUE), envir = environment())
input <- jsonlite::toJSON(mtcars, pretty = TRUE)
input

res <- fromJson(input = input)
all(colnames(input) %in% ls(res))
identical(as.numeric(am), mtcars$am)

##------------------------------------------------------------------------------
## data frame/simple/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/orgs"
tmp <- jsonlite::fromJSON(input)

res <- fromJson(input = input)
all(colnames(tmp) %in% ls(res))

avatar_url

##------------------------------------------------------------------------------
## data frame/simple/from URL/custom environment //
##------------------------------------------------------------------------------

input <- "https://api.github.com/users/hadley/orgs"
tmp <- jsonlite::fromJSON(input)

where <- fromJson(input = input, where = new.env())
all(colnames(tmp) %in% ls(where)))

where$avatar_url

##------------------------------------------------------------------------------
## data frame/nested/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/repos"
tmp <- jsonlite::fromJSON(input)

res <- fromJson(input = input)
all(colnames(tmp) %in% ls(res))

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
all(colnames(tmp) %in% ls(res))

owner.type
id

##------------------------------------------------------------------------------
## list/simple nesting/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/orgs"
res <- fromJson(input = input, simplifyDataFrame = FALSE)
all(paste0("[", 1:6, "]") %in% ls(res))

environment()[["[1]"]]$avatar_url

##------------------------------------------------------------------------------
## list/complex nesting/from URL/parent frame //
##------------------------------------------------------------------------------

rm(list = ls(all.names = TRUE), envir = environment())
input <- "https://api.github.com/users/hadley/repos"
tmp <- jsonlite::fromJSON(input)

res <- fromJson(input = input, simplifyDataFrame = FALSE)
all(paste0("[", 1:30, "]") %in% ls(res)))

environment()[["[1]"]]$owner
environment()[["[1]"]]$owner$type

##------------------------------------------------------------------------------
## list/simple nesting/from URL/custom environment //
##------------------------------------------------------------------------------

input <- "https://api.github.com/users/hadley/orgs"
where <- fromJson(input = input, where = new.env(), simplifyDataFrame = FALSE)
all(paste0("[", 1:3, "]") %in% ls(where))

where[["[1]"]]$avatar_url

##------------------------------------------------------------------------------
## list/complex nesting/from URL/custom environment //
##------------------------------------------------------------------------------

input <- "https://api.github.com/users/hadley/repos"
where <- fromJson(input = input, where = new.env(), simplifyDataFrame = FALSE)
all(paste0("[", 1:30, "]") %in% ls(where))

where[["[1]"]]$owner
where[["[1]"]]$owner$type
```