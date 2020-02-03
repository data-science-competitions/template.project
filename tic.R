library(tic)
DESCRIPTION <- readLines("DESCRIPTION")
Date <- trimws(gsub("Date:", "", DESCRIPTION[grepl("Date:", DESCRIPTION)]))
if(length(Date) == 1) options(repos = paste0("https://mran.microsoft.com/snapshot/", Date))
if(length(Date) != 1) options(repos = "https://cloud.r-project.org")
invisible(sapply(list.files("./.app/tic", full.names = TRUE), source))

# Stage : Before Install -------------------------------------------------------
get_stage("before_install") %>%
    add_step(step_run_code(print(Sys.getenv())))

# Stage: Install ---------------------------------------------------------------
get_stage("install") %>%
    add_step(step_install_cran("devtools")) %>%
    add_step(step_install_deps())

# Stage: Script ----------------------------------------------------------------
get_stage("script") %>%
    add_step(step_run_code(devtools::document())) %>%
    add_step(step_build_and_check(job_name = ci_get_job_name())) %>%
    add_step(step_run_test_suite(job_name = ci_get_job_name())) %>%
    add_step(step_deploy(job_name = ci_get_job_name()))

# Stage: After Failure ---------------------------------------------------------
get_stage("after_failure") %>%
    add_step(step_run_code(sessioninfo::session_info(include_base = FALSE)))
