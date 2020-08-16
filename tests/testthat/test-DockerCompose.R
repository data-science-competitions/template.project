context("unit test for DockerCompose")

# Setup -------------------------------------------------------------------
testthat::setup({
    assign("session", testthat::test_env(), envir = parent.frame())
    session$path_dir <- tempfile("testthat-")
    session$path_yml <- file.path(session$path_dir, "docker-compose.yml")
    testthat::local_mock(
        system = function(...) invisible(),
        browseURL = function(...) invisible(),
        .local_envir = session
    )

    # Generate docker-compose.yml
    content <- list()
    content$services$dummyservices <- list(
        image = "dummy_image",
        container_name = "dummy-container",
        ports = "5050:3838"
    )

    dir.create(session$path_dir, showWarnings = FALSE, recursive = TRUE)
    yaml::write_yaml(content, session$path_yml)
})

# General -----------------------------------------------------------------
test_that("DockerCompose$new works", {
    expect_error(docker <- DockerCompose$new(tempfile()))
    expect_silent(docker <- DockerCompose$new(session$path_yml))
    expect_class(docker, "DockerCompose")
    session$docker <- docker
})

# Accessor Methods --------------------------------------------------------
test_that("DockerCompose$get works", {
    session$docker -> docker
    expect_identical(docker$get("dummyservices", "ports"), "5050:3838")
})

# Create and Start Containers ---------------------------------------------
test_that("DockerCompose$start works with all services", {
    session$docker -> docker
    expect_class(docker$start(), "DockerCompose")
})

test_that("DockerCompose$start works with specific services", {
    session$docker -> docker
    expect_class(docker$start("dummyservices"), "DockerCompose")
})

test_that("DockerCompose$start prompts an error for unknown services", {
    session$docker -> docker
    expect_error(docker$start("unknown_service"))
})

# Stop and Remove Containers ----------------------------------------------
test_that("DockerCompose$stop works", {
    session$docker -> docker
    expect_class(docker$stop(), "DockerCompose")
})

# Restart Containers ------------------------------------------------------
test_that("DockerCompose$restart works", {
    session$docker -> docker
    expect_class(docker$restart(), "DockerCompose")
})

# Reset Containers --------------------------------------------------------
test_that("DockerCompose$reset works", {
    session$docker -> docker
    expect_class(docker$reset(), "DockerCompose")
})

# browseURL ---------------------------------------------------------------
test_that("DockerCompose$browse_url works", {
    session$docker -> docker
    expect_silent(docker$browse_url(service = "dummyservices", slug = "sample-apps"))
})


