context("component test for Ingest object")

test_that("Ingest fulfils its datasets assumptions", {
    expect_class(db <- IngestDTO(), "Ingest")
    expect_a_non_empty_data.frame(db$historical_data)
    expect_a_non_empty_data.frame(db$new_data)
    expect_class(db$submission_sample, "data.frame")
})
