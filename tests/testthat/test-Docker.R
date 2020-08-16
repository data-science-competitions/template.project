context("unit test for Docker")

# Setup -------------------------------------------------------------------
testthat::setup({
    assign("session", testthat::test_env(), envir = parent.frame())
    session$path <- getwd()
    testthat::local_mock(
        system = function(...) message(""),
        browseURL = function(...) invisible(),
        .local_envir = session
    )
})

# General -----------------------------------------------------------------
test_that("Docker$new works", {
    expect_silent(docker <- Docker$new())
    expect_class(docker, "Docker")
    session$docker <- docker
})

# Public Methods ----------------------------------------------------------
test_that("Docker$new works", {
    docker <- session$docker
    expect_message(docker$show_running_containers())
    expect_message(docker$show_images())
    expect_message(docker$remove_dangling_images())
    expect_message(docker$kill_all_containers())
    expect_message(docker$kill_container("container_name"))
})
