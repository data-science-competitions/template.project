#' Step: Install Package Dependencies
#'
#' Install the local package dependencies
#'
#' @family steps
#' @export
InstallDependencies <- R6::R6Class(
    "InstallDependencies", inherit = TicStep,
    public = list(
        run = function() {
            message("\n", rep("#",40), "\n", "## Installing Package Dependencies\n", rep("#",40))
            invisible(sapply(list.files("./.tic", full.names = TRUE), source, local = environment()))
            install_package("remotes")
            install_package("devtools")
            remotes::install_local(dependencies = TRUE, force = TRUE, upgrade = "always")
            devtools::uninstall()
        }
    )
)

step_install_package_dependencies <- function(){
    InstallDependencies$new()
}
