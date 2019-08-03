context("component test for Ingest object")

test_that("Ingest fulfils its datasets assumptions", {
    expect_class(db <- IngestDTO(), "Ingest")
    expect_class(db$historical_data, "data.frame")
    expect_class(db$new_data, "data.frame")
    expect_class(db$submission_sample, "data.frame")
})
