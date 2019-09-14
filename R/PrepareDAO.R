#' @title Instantiate the Prepare Interface
#'
#' @description Data preprocessing is a data mining technique that involves
#'   transforming raw data into an understandable format
#'
#' @return (`Prepare`) An interface that defines an abstract type that contains
#'   no data but defines behaviours as method signatures.
#'
#' @export
#'
#' @family Data Pipeline
#'
#' @docType class
#' @format \code{\link[R6]{R6Class}} object.
#' @keywords data
PrepareDAO <- R6::R6Class(
    classname = "PrepareDAO",
    inherit = Prepare,
    cloneable = FALSE,
    lock_objects = FALSE,
    private = list(
        # Private Variables ----------------------------------------------------
        .ingest = "IngestDAO",

        # Private Methods ------------------------------------------------------
        import_data.frames_from_Ingest = function() .import_data.frames_from_Ingest(private),
        cast_data = function() .cast_data(private),
        clean_data = function() .clean_data(private),
        transform_data = function() .transform_data(private),
        enrich_data = function() .enrich_data(private)
    ),

    active = list(
        historical_data = function() private$.historical_data,
        new_data = function() private$.new_data,
        submission_format = function() private$.submission_format
    )
)#end PrepareDAO

# Private Methods: High-level Functions ----------------------------------------
#' @title Cast Data
#' @description Convert variables types
#' @noRd
.cast_data <- function(private){
    invisible(private)
}

#' @title Clean Data
#' @description Apply cleaning operations on the data:
#' 1. Remove duplicates
#' @noRd
.clean_data <- function(private){
    .drop_duplicates <- function(.data){
        .data %>% dplyr::distinct()
    }

    for(element in names(private$.ingest)){
        if(is.data.frame(private$.ingest[[element]])){
            private[[paste0(".", element)]] <-
                private[[paste0(".", element)]] %>%
                .drop_duplicates()
        }
    }

    invisible(private)
}

#' @title Transform Data
#' @description Apply transformations
#' @noRd
.transform_data <- function(private){
    invisible(private)
}


#' @title Enrich Data
#' @description Craft new features
#' @noRd
.enrich_data <- function(private){
    invisible(private)
}
