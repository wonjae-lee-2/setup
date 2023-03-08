project_folder <- c(Sys.getenv("PROJECT_FOLDER"))

dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
install.packages("renv", repos = "https://cloud.r-project.org/") # https://cloud.r-project.org/web/packages/renv/index.html
renv::init(project = project_folder, bare = TRUE)
