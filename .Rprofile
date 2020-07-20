# First -------------------------------------------------------------------
.First <- function(){
    if(identical(Sys.getenv("CI"), "true")) return()

    # Helpers -----------------------------------------------------------------
    assign(".Rprofile", new.env(), envir = globalenv())

    .Rprofile$run_docker <- function(){
        # Write script
        path_script <- tempfile("system-", fileext = ".R")
        writeLines("
        source('./R/Docker.R')
        source('./R/DockerCompose.R')
        #Docker$new()$remove_dangling_images()$show_images()
        docker <- DockerCompose$new()$restart()
        ", path_script)

        # Run script in a separate job
        invisible(rstudioapi::jobRunScript(
            path = path_script,
            name = paste("Spinning-up", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container"),
            workingDir = ".",
            importEnv = FALSE,
            exportEnv = ""
        ))
    }

    # Programming Logic -------------------------------------------------------
    pkgs <- c("usethis", "devtools", "magrittr")
    invisible(sapply(pkgs, require, warn.conflicts = FALSE, character.only = TRUE))
}

# Last --------------------------------------------------------------------
.Last <- function(){
    if(identical(Sys.getenv("CI"), "true")) return()
    try(system('docker-compose down'))
}


