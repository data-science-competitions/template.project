#' @title Instantiate the Ingest Interface
#'
#' @description Instantiating the Ingest Interface results with a Data Transfer
#'   Object (DTO).
#'
#' @param path (`character`) A path to a folder where the raw data files
#'   are/will-be stored.
#'
#' @return (`Ingest`) An implementing of the `Ingest` interface.
#'
#' @export
#'
#' @section Further Reading:
#' * \href{https://docs.microsoft.com/en-us/azure/data-explorer/ingest-data-overview}{What is data ingestion?}
#' * \href{https://en.wikipedia.org/wiki/Data_transfer_object}{What is data transfer object?}
#'
IngestDTO <- function(path = getOption("path_dropzone", default = tempdir())){

    Ingest <- R6::R6Class(
        classname = "Ingest",
        public = list(
            ## Public Variables
            ## Public Methods
            initialize = function(path)
            {
                message("Ingesting Data")
                private$.path <- path
                private$pull_data()
                private$import_data()
            }),

        private = list(
            ## Private Variables
            .path = character(0),
            .historical_data = data.frame(),
            .new_data = data.frame(),
            .submission_sample = data.frame(),
            ## Private Methods
            pull_data = function() .pull_data(private),
            import_data = function() .import_data(private)
        ),

        active = list(
            historical_data = function() private$.historical_data,
            new_data = function() private$.new_data,
            submission_sample = function() private$.submission_sample
        )
    )#end Ingest

    return(Ingest$new(path))

}#end IngestDTO

# Private Methods: High-level Functions ----------------------------------------
.pull_data <- function(private){
    path <- private$.path
    dir.create(path, showWarnings = FALSE, recursive = TRUE)

    sources <- c()
    targets <- c()

    for(k in seq_along(sources)){
        .download_missing_files(sources[[k]], targets[[k]])
    }

    invisible(private)
}

.import_data <- function(private){
    invisible(private)
}

# Private Methods: Low-level Functions -----------------------------------------
.download_missing_files <- function(source, target){
    if(identical(file.exists(target), FALSE))
        utils::download.file(source, target)
}
