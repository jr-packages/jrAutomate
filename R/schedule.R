#' The famous Jumping Rivers Scheduler
#'
#' A simple schedular that runs \code{rmarkdown::render()}, the number
#' of times equal to \code{reports}. The time interval between calls
#' is given by \code{time_between}
#' @param rmd_name A Rmd file
#' @param repeats An integer. The number of times to call \code{render}
#' @param time_between The time (in seconds) between renders
#' @param params Parameters to be passed to the render script
#' @export
scheduler = function(rmd_name,
                     repeats = 5,
                     time_between = 5,
                     params = NULL) {
  if (!file.exists(rmd_name))
    stop(paste0("Can't find the file: ", rmd_name), call. = FALSE)

  if (time_between < 0)
    stop("The time between must be positive.", call. = FALSE)

  if (time_between > 10)
    warning("The time_between is greater 10 seconds. You may be here a while")

  if (repeats < 1) stop("Repeats must be greater than 0", call. = FALSE)

  for (i in 1:repeats) {
    message("Running render: (", i, " of ", repeats, ")")
    if (i == 1) rmarkdown::render(rmd_name, params = params)
    else rmarkdown::render(rmd_name, params = params, quiet = TRUE)
    Sys.sleep(time_between)
  }
  message("Finished schedule. Thanks for using the Jumping Rivers scheduler.")
}
