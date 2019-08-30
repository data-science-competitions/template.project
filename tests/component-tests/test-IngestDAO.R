context("component test for IngestDAO")

testthat::setup({
    assign("test_env", testthat::test_env(), envir = parent.frame())
    test_env$path <- tempdir()
})

test_that("IngestDAO implements its interface method signatures", {
    attach(test_env)
    expect_class(test_env$obj <- IngestDAO$new(path = path), "Ingest")

})

test_that("IngestDAO gives access to specific data tables", {
    attach(test_env)
    expect_a_non_empty_data.frame(obj$historical_data)
    expect_a_non_empty_data.frame(obj$new_data)
    expect_a_non_empty_data.frame(obj$submission_format)
})

testthat::teardown(test_env <- NULL)
