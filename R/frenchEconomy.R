
#' Run R-Shiny dashboard
#'
#' @examples
#' \donttest{
#' # run R-Shiny dashboard
#' frenchEconomy()
#' }
#' @export
frenchEconomy <- function() {
  appDir <- system.file("shiny", "frenchEconomy", package = "frenchEconomy")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `frenchEconomy`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
