pkgload::load_all(export_all = FALSE, helpers = FALSE)
Docker$new()$kill_all_containers()$remove_dangling_images()

docker <- DockerCompose$new()
docker$restart()

# User name: rstudio
# Password: 1234
docker$browse_url("r-core")

