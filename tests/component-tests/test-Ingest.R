context("component test for Ingest interface")

test_that("Ingest fulfils its datasets assumptions", {
    expect_class(db <- Ingest$new(path = tempdir()), "Ingest")
    expect_an_empty_data.frame(db$historical_data)
    expect_an_empty_data.frame(db$new_data)
    expect_an_empty_data.frame(db$submission_sample)
})

