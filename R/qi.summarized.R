#' Constructor for QI Summarized Class
#' This class takes an arbitrary number of the _same_ type of 
#' quantities of interest labels them, then
#' merges them into one simple printable block. In particular,
#' this class determines which print function to use based on the
#' the type and size od data to be passed to the print function.
#' @param title a character-string specifying the title of the QI
#' @param x a list of summarized quantities of interest
#' @param ... additional quantities of interest (the parameter that
#'            titles these will be used as the name of the data.frame
#' @return the list of QI's (invisibly)
#' @author Matt Owen \email{mowen@@iq.harvard.edu}
qi.summarize <- function (title, x, ...) {
  qis <- append(x, list(...))

  attr(qis, 'title') <- title

  class(qis) <- 'qi.summarized'

  for (key in names(qis)) {
    val <- x[[key]]

    if (is.matrix(val))
      next

    qis[[key]] <- matrix(val, nrow=1, ncol=length(val))
  }

  nrows <- Map(nrow, qis)

  if (all(nrows == 1))
    attr(qis, 'print') <- 'matrix'

  else
    attr(qis, 'print') <- 'list'

  invisible(qis)
}

#' Print Method for Summarized Quantities of Interest
#' @usage \method{print}{qi.summarized}(x, \dots)
#' @S3method print qi.summarized
#' @param x a 'summarized.qi' object
#' @param ... parameters to be passed to the specific print functions
#' @return x (invisibly)
#' @author Matt Owen \email{mowen@@iq.harvard.edu}
#' @seealso \link{special_print_MATRIX} and
#'   \link{special_print_LIST}
print.qi.summarized <- function (x, ...) {

  if (attr(x, 'print') == 'matrix')
    .print.qi.summarized.MATRIX(x, ...)

  else if (attr(x, 'print') == 'list')
    .print.qi.summarized.LIST(x, ...)

  else
    print(x, ...)
}

#' Method for Printing Summarized QI's in a Matrix Form
#' @name special_print_MATRIX
#' @aliases special_print_MATRIX .print.qi.summarized.MATRIX
#' @note This function is used internall by Zelig
#' @param x a 'summarized.qi' object
#' @param ... additional parameters
#' @return x (invisibly)
#' @author Matt Owen \email{mowen@@iq.harvard.edu}
.print.qi.summarized.MATRIX <- function (x, ...) {
  m <- matrix(NA, 0, 0)

  for (key in names(x)) {
    m <- .bind(m, x[[key]])
  }

  rownames(m) <- names(x)

  cat(attr(x, 'title'), "\n")
  print(m, ...)

  invisible(x)
}

#' Method for Printing Summarized QI's in a List Form
#' @name special_print_LIST
#' @aliases special_print_LIST .print.qi.summarized.LIST
#' @note This function is used internall by Zelig
#' @param x a 'summarized.qi' object
#' @param ... additional parameters to be used by the 'print.matrix' method
#' @return x (invisibly)
#' @author Matt Owen \email{mowen@@iq.harvard.edu}
.print.qi.summarized.LIST <- function (x, ...) {

  cat(attr(x, 'title'), "\n\n")

  for (key in names(x)) {
    cat('imputed data =  ', key, "\n")
    print(x[[key]], ...)
    cat("\n")
  }
  
  invisible(x)
}
