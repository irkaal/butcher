#' Butcher an object.
#'
#' Reduce the size of a model object so that it takes up less memory on
#' disk. Currently, the model object is stripped down to the point that
#' only the minimal components necessary for the \code{predict} function
#' to work remain. Future adjustments to this function will be needed to
#' avoid removal of model fit components to ensure it works with other
#' downstream functions.
#'
#' @param x A model object.
#' @param verbose Print information each time an axe method is executed.
#'  Notes how much memory is released and what functions are
#'  disabled. Default is \code{FALSE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object with new butcher subclass assignment.
#' @export
butcher <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- axe_call(x, verbose = FALSE, ...)
  x <- axe_ctrl(x, verbose = FALSE, ...)
  x <- axe_data(x, verbose = FALSE, ...)
  x <- axe_env(x, verbose = FALSE, ...)
  x <- axe_fitted(x, verbose = FALSE, ...)

  add_butcher_attributes(
    x,
    old,
    add_class = FALSE,
    verbose = verbose
  )
}

#' Axe a call.
#'
#' Replace the call object attached to modeling objects with a placeholder.
#'
#' @inheritParams butcher
#'
#' @return Model object without call attribute.
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_call")}
#'
#' @export
axe_call <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_call")
}

#' @export
axe_call.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe controls.
#'
#' Remove the controls from training attached to modeling objects.
#'
#' @inheritParams butcher
#'
#' @return Model object without control tuning parameters from training.
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_ctrl")}
#'
#' @export
axe_ctrl <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_ctrl")
}

#' @export
axe_ctrl.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe data.
#'
#' Remove the training data attached to modeling objects.
#'
#' @inheritParams butcher
#'
#' @return Model object without the training data
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_data")}
#'
#' @export
axe_data <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_data")
}

#' @export
axe_data.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}


#' Axe an environment.
#'
#' Remove the environment(s) attached to modeling objects as they are
#' not required in the downstream analysis pipeline. If found,
#' the environment is replaced with \code{rlang::base_env()}.
#'
#' @inheritParams butcher
#'
#' @return Model object with empty environments.
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_env")}
#'
#' @export
axe_env <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_env", object = x)
}

#' @export
axe_env.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe fitted values.
#'
#' Remove the fitted values attached to modeling objects.
#'
#' @inheritParams butcher
#'
#' @return Model object without the fitted values.
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_fitted")}
#'
#' @export
axe_fitted <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_fitted")
}

#' @export
axe_fitted.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

