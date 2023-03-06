project_folder <- c(Sys.getenv("PROJECT_FOLDER"))
linux_codename <- c(Sys.getenv("LINUX_CODENAME"))
rspm_url <- paste("https://packagemanager.posit.co/cran/__linux__/", linux_codename, "/latest", sep = "")
package_list <- c("sparklyr") # https://cloud.r-project.org/web/packages/sparklyr/index.html

options(repos = c(CRAN = rspm_url)) # https://packagemanager.posit.co/client/#/repos/2/overview
dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
install.packages("renv") # https://cloud.r-project.org/web/packages/renv/index.html
renv::init(project = project_folder, bare = TRUE)
renv::install(packages = package_list)
renv::snapshot(type = "all")
