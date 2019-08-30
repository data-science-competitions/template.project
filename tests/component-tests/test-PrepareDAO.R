context("component test for PrepareDAO")

testthat::setup({
    assign("test_env", testthat::test_env(), envir = parent.frame())
})

test_that("PrepareDAO implements its interface method signatures", {
    attach(test_env)
    expect_class(test_env$obj <- PrepareDAO$new(), "Prepare")
})

test_that("PrepareDAO gives access to specific data tables", {
    attach(test_env)
    expect_a_non_empty_data.frame(obj$historical_data)
    expect_a_non_empty_data.frame(obj$new_data)
    expect_a_non_empty_data.frame(obj$submission_format)
})

testthat::teardown(test_env <- NULL)
