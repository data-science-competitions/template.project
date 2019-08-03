#' @title Instantiate the Ingest Interface
#'
#' @param path (`character`) A path to a folder where the raw data files
#'   are/will-be stored.
#'
#' @return (`Ingest`) An implementing of the `Ingest` interface.
#'
#' @export
#'
#' @family Data Pipeline
#'
#' @seealso \link{Ingest}
#'
#' @section Further Reading:
#' * \href{https://docs.microsoft.com/en-us/azure/data-explorer/ingest-data-overview}{What is data ingestion?}
#' * \href{https://en.wikipedia.org/wiki/Data_access_object}{What is data access object?}
#'
IngestDAO <- R6::R6Class(
    classname = "IngestDAO",
    inherit = Ingest,
    private = list(
        # Private Variables ------------------------------------------------
        .path = character(0),
        .historical_data = data.frame(),
        .new_data = data.frame(),
        .submission_sample = data.frame(),

        # Private Methods --------------------------------------------------
        #' Pull data from external sources
        pull_data = function() .pull_data(private),
        #' Make the data available for query
        import_data = function() .import_data(private)
    ),

    active = list(
        historical_data = function() private$.historical_data,
        new_data = function() private$.new_data,
        submission_sample = function() private$.submission_sample
    )
)#end Ingest


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

    private$.historical_data <- mtcars[1:22,]
    private$.new_data <- mtcars[23:32,]
    private$.submission_sample <- data.frame(UID = rownames( private$.new_data))

    invisible(private)
}

# Private Methods: Low-level Functions -----------------------------------------
.download_missing_files <- function(source, target){
    if(identical(file.exists(target), FALSE))
        utils::download.file(source, target)
}
