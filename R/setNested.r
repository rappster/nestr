#' @title
#' Set Nested (generic)
#'
#' @description 
#' Creates a nested object structure based on a path-like \code{id} with the 
#' last ID component being the actual object name that \code{value} is assigned 
#' to.
#' 
#' @template path-like-ids
#'   	
#' @param id \strong{Signature argument}.
#'    Object containing path-like ID information.
#' @param value \strong{Signature argument}.
#'    Object containing value information.
#' @param where \strong{Signature argument}.
#'    Object containing location information.
#' @param fail_value \code{\link{ANY}}.
#' 		Value that is returned if assignment failed and \code{return_status = FALSE}.
#' @param gap \code{\link{logical}}. 
#'    \code{TRUE}: when \code{dirname(id)} points to a non-existing parent
#'    branch or if there are any missing branches in the nested structure, 
#'    then auto-create all missing branches; 
#'    \code{FALSE}: either return with \code{fail_value} or throw a condition 
#' 		in such cases (depending on \code{strict}); 
#'    Default: \code{TRUE} as this seems to be most practical/convenient for 
#'    actual applications.  
#' @param force \code{\link{logical}}. 
#'    \code{TRUE}: when \code{dirname(id)} points to a \emph{leaf} instead of a 
#'    \emph{branch} (i.e. \code{dirname(id)} is not an \code{environment}), 
#'    overwrite it to turn it into a branch and vice versa when \code{id} points
#'    to a branch that is to be transformed into a leaf;
#'    \code{FALSE}: either return with \code{fail_value} or throw error in such cases
#'    (depending on value of \code{strict}); 
#' @param must_exist \code{\link{logical}}. 
#'    \code{TRUE}: \code{id} pointing to a non-existing component either results 
#'    in return value \code{fail_value} or triggers a condition
#'    (depending on \code{strict}); 
#'    \code{FALSE}: object value that \code{id} points to is set.
#' @param reactive \code{\link{logical}}. 
#'    \code{TRUE}: set reactive object value via 
#'    \code{\link[nestr]{setReactive}} or \code{\link[nestr]{setShinyReactive}}.
#'    \code{FALSE}: set regular/non-reactive object value.
#'    Note that if \code{value = reactiveExpression()}, \code{reactive} is 
#'    automatically set to \code{TRUE}.
#' @param return_status \code{\link{logical}}.
#' 		\code{TRUE}: return status (\code{TRUE} for successful assignment, 
#' 			\code{FALSE} for failed assignment);
#'    \code{FALSE}: return actual assignment value (\code{value}) or 
#'    \code{fail_value}.
#' @param strict \code{\link{logical}}.
#' 		Controls what happens when \code{id} points to a non-existing component:
#'    \itemize{
#' 			\item{0: }{ignore and return \code{FALSE} to signal that the 
#' 				assignment process was not successful or \code{fail_value} depending
#' 				on the value of \code{return_status}} 
#' 			\item{1: }{ignore and with warning and return \code{FALSE}}
#' 			\item{2: }{ignore and with error}
#'   	}
#' @param typed \code{\link{logical}}. 
#'    \code{TRUE}: create an implicitly typed component; 
#'    \code{FALSE}: create a regular component.
#' @param Further arguments to be passed along to subsequent functions.
#'    In particular: 
#'    \itemize{
#'      \item{\code{\link[nestr]{setShinyReactive}}}
#'      \item{\code{\link[typr]{setTyped}}}
#'    }
#' @example inst/examples/setNested.r
#' @seealso \code{
#'   	\link[nestr]{setNested-char-any-char-method},
#'     \link[nestr]{getNested},
#'     \link[nestr]{rmNested}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "setNested",
  signature = c(
    "id",
    "value",
    "where"
  ),
  def = function(
    id,
    value,
    where = parent.frame(),
    fail_value = NULL,
    force = FALSE,
    gap = TRUE,
    must_exist = FALSE, 
    reactive = FALSE,
    return_status = TRUE,
    strict = c(0, 1, 2),
    typed = FALSE,
    ...
  ) {
    standardGeneric("setNested")       
  }
)

#' @title
#' Set Nested (char-any-miss)
#'
#' @description 
#' See generic: \code{\link[nestr]{setNested}}
#'      
#' @inheritParams setNested
#' @param id \code{\link{character}}.
#' @param value \code{\link{ANY}}.
#' @param where \code{\link{missing}}.
#' @return See method
#'    \code{\link{setNested-char-any-char-method}}.
#' @example inst/examples/setNested.r
#' @seealso \code{
#'    \link[nestr]{setNested}
#' }
#' @template author
#' @template references
#' @aliases setNested-char-any-miss-method
#' @export
setMethod(
  f = "setNested", 
  signature = signature(
    id = "character",
    value = "ANY",
    where = "missing"
  ), 
  definition = function(
    id,
    value,
    where,
    fail_value,
    force,
    gap,
    must_exist,
    reactive,
    return_status,
    strict,
    typed,
    ...
  ) {
    
  setNested(
    id = id,
    value = value,
    where = where,
    fail_value = fail_value,
    force = force,
    gap = gap,
    must_exist = must_exist,
    reactive = reactive,
    return_status = return_status,
    strict = strict,
    typed = typed,
    ...
  )    
    
  }
)

#' @title
#' Set Nested (char-any-env)
#'
#' @description 
#' See generic: \code{\link[nestr]{setNested}}
#'   	 
#' @inheritParams setNested
#' @param id \code{\link{character}}.
#' @param value \code{\link{ANY}}.
#' @param where \code{\link{environment}}.
#' @return \code{\link{logical}}. \code{TRUE}.
#' @example inst/examples/setNested.r
#' @seealso \code{
#'    \link[nestr]{setNested}
#' }
#' @template author
#' @template references
#' @aliases setNested-char-any-char-method
#' @import reactr
#' @import typr
#' @export
setMethod(
  f = "setNested", 
  signature = signature(
    id = "character",
    value = "ANY",
    where = "environment"
  ), 
  definition = function(
    id,
    value,
    where,
    fail_value,
    force,
    gap,
    must_exist,
    reactive,
    return_status,
    strict,
    typed,
    ...
  ) {
    
  ## Argument checks //
  strict <- as.numeric(match.arg(as.character(strict), 
    as.character(c(0, 1, 2))))    
   
  ## Return value initialization //
  out <- TRUE
  
  ## Actual container/environment //
  container <- where
  envir_name <- "container"
  
  if (inherits(value, "ReactiveExpression")) {
    reactive <- TRUE
  }
  
  ## Direct parent check //
  id_branch <- dirname(id)
  if (!grepl("^\\./", id) && id_branch == ".") {
    branch_value <- container
  } else {
    branch_value <- tryCatch(
      getNested(id = id_branch, where = where, strict = 0),
      error = function(cond) {
        NULL
      }
    )
  }

  ## Handling branch gaps //
  if (is.null(branch_value)) {
    if (gap) {
      ## Check how much to fill //
      id_branch_spl <- unlist(strsplit(id_branch, split = "/"))
      id_branch_tree <- NULL
      expr_get <- NULL
      expr_set <- NULL
      for (ii in 1:length(id_branch_spl)) {
        expr_get <- c(expr_get, 
          paste0(envir_name, "[[\"", paste(id_branch_spl[1:ii], collapse = "\"]][[\""),
             "\"]]"))
        expr_set <- c(expr_set, 
          paste0(envir_name, "[[\"", paste(id_branch_spl[1:ii], collapse = "\"]][[\""),
          "\"]] <- new.env()"))
        id_branch_tree <- c(id_branch_tree, paste(id_branch_spl[1:ii], collapse = "/"))
      }
      
      ## Determine component types //
      ## * yes --> branch
      ## * no --> leaf or not existing
      ## * error --> error
      idx <- sapply(expr_get, function(ii) {
        tryCatch({
          tmp <- switch(
            as.character(inherits(eval(parse(text = ii)), "environment")),
            "TRUE" = "yes",
            "FALSE" = "no"
          )},
          error = function(cond) {
            "error"
          }
        )
      }) 

      ## Invalid branch(es) //
      if (any(idx == "no") & any(idx == "error")) {
        idx_no <- which(idx == "no")
        if (length(idx_no)) {
          if (force) {
          ## Ensure that leafs are transformed to branches //            
            setNested(
              id = id_branch_tree[idx_no],
              value = new.env(),
              where = where,
              strict = 0
            )
            
            ## Update `idx` and `expr_set` //
            idx <- idx[-idx_no]
            expr_set <- expr_set[-idx_no]
            
            ## Remove error entry //
            idx[which(idx == "error")] <- "no"
          } else {
            if (strict == 0) {
              out <- FALSE
            } else if (strict == 1) {
              conditionr::signalCondition(
                condition = "InvalidBranchConstellation",
                msg = c(
                  Reason = "parent branch is not an environment",
                  ID = id,
                  "ID branch" = id_branch_tree[idx_no]
                ),
                ns = "nestr",
                type = "warning"
              )
              out <- FALSE
            } else if (strict == 2) {
              conditionr::signalCondition(
                condition = "InvalidBranchConstellation",
                msg = c(
                  Reason = "parent branch is not an environment",
                  ID = id,
                  "ID branch" = id_branch_tree[idx_no]
                ),
                ns = "nestr",
                type = "error"
              )  
            }
          }
        }
      }
      
      ## Close gap for not-yet-existing branch(es) //
      idx_no <- which(idx == "no")
      if (out) {
        if (length(idx_no)) {
          run_scope <- idx_no[1]:length(expr_set)
#         } else {
#           run_scope <- 1:length(expr_set)
#         }
        
#         if (length(run_scope)) {
          sapply(run_scope, function(ii) {
            eval(parse(text = expr_set[ii]))
          })  
          branch_value <- getNested(id = id_branch, 
            where = where, strict = 0)
        }
      }
    } else {
      if (strict == 0) {
        out <- FALSE
      } else if (strict == 1) {
        conditionr::signalCondition(
          condition = "InvalidBranchConstellation",
          msg = c(
            Reason = "branch gap",
            ID = id
          ),
          ns = "nestr",
          type = "warning"
        )
        out <- FALSE
      } else if (strict == 2) {
        conditionr::signalCondition(
          condition = "InvalidBranchConstellation",
          msg = c(
            Reason = "branch gap",
            ID = id
          ),
          ns = "nestr",
          type = "error"
        )
      }
    }
  }

  ## Early exit //
  if (!out) {
    return(if (return_status) FALSE else fail_value)
  }

  ## Leaf to branch (parent branch is not an environment) //
  if (!inherits(branch_value, "environment")) {
    if (force) {
    ## Transform to branch //
      expr_set <- paste0(envir_name, "$", gsub("/", 
        "$", id_branch), " <- new.env()")
      
      ## This also updates `branch_value` //
      branch_value <- eval(parse(text = expr_set))
    } else {
      if (strict == 0) {
        out <- FALSE
      } else if (strict == 1) {
        conditionr::signalCondition(
          condition = "InvalidBranchConstellation",
          msg = c(
            Reason = "parent branch is not an environment",
            ID = id,
            "ID branch" = id_branch,
            "Class branch" = class(branch_value)
          ),
          ns = "nestr",
          type = "warning"
        )
        out <- FALSE
      } else if (strict == 2) {
        conditionr::signalCondition(
          condition = "InvalidBranchConstellation",
          msg = c(
            Reason = "parent branch is not an environment",
            ID = id,
            "ID branch" = id_branch,
            "Class branch" = class(branch_value)
          ),
          ns = "nestr",
          type = "error"
        )
      }
    }
  }

  ## Early exit //
  if (!out) {
    return(if (return_status) FALSE else fail_value)
  }

  ## Branch into a leaf //
  if (  exists(basename(id), branch_value, inherits = FALSE) && 
        inherits(get(basename(id), branch_value, inherits = FALSE), "environment")
## TODO: issue #2
## The actual `get()` for class lookup might cost too much in certain situations
## Find out if there are better ways to "just get the class info" or if there 
## is any other way to handle this part more efficiently
  ) {
    if (!force) {
      if (strict == 0) {
        out <- FALSE
      } else if (strict == 1) {
        conditionr::signalCondition(
          condition = "InvalidBranchConstellation",
          msg = c(
            Reason = "trying to turn a branch into a leaf",
            "ID branch" = id
          ),
          ns = "nestr",
          type = "warning"
        )
        out <- FALSE
      } else if (strict == 2) {
        conditionr::signalCondition(
          condition = "InvalidBranchConstellation",
          msg = c(
            Reason = "trying to turn a branch into a leaf",
            "ID branch" = id
          ),
          ns = "nestr",
          type = "error"
        )
      }
    }
  }

  ## Early exit //
  if (!out) {
    return(if (return_status) FALSE else fail_value)
  }

  ## Must exist //
  if (must_exist) {
    if (!exists(basename(id), envir = branch_value, inherits = FALSE)) {
      if (strict == 0) {
        out <- FALSE
      } else if (strict == 1) {
        conditionr::signalCondition(
          condition = "StructurePrerequisitesNotMet",
          msg = c(
            Reason = "leaf does not exist yet",
            ID = id
          ),
          ns = "nestr",
          type = "warning"
        )
        out <- FALSE
      } else if (strict == 2) {
        conditionr::signalCondition(
          condition = "StructurePrerequisitesNotMet",
          msg = c(
            Reason = "leaf does not exist yet",
            ID = id
          ),
          ns = "nestr",
          type = "error"
        )
      }
    }
  }

  ## Early exit //
  if (!out) {
    return(if (return_status) FALSE else fail_value)
  }

  ## Auto-check if reactive //
  ## This significantly speeds up the assignment process for reactive *sources* 
  ## that already exist as `setShinyReactive()` does not need to be called again
  reactive_exist <- isReactive(id = basename(id), where = branch_value)
  
  ## This takes care that reactive observers will always updated when this 
  ## function is run:
  is_reactive_value <- inherits(value, "ReactiveExpression")
  
  ## Actual assignment //
  if (!reactive || reactive_exist && !typed && !is_reactive_value) {  
    if (!typed) {
      path <- paste0("[[\"", gsub("/", "\"]][[\"", id), "\"]]")
      expr <- paste0(envir_name, path, " <- value")
      eval(parse(text = expr))  
    } else {  
      setTyped(id = basename(id), value = value, 
        where = branch_value, strict = strict, ...)
    }
  } else {
    setShinyReactive(id = basename(id), value = value, 
      where = branch_value, typed = typed, ...)
  }

  return(
    if (!out) {
      if (return_status) FALSE else fail_value
    } else {
      if (return_status) TRUE else value
    }
  )
  
  }
)
