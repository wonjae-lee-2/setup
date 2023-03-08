project_folder <- c(Sys.getenv("PROJECT_FOLDER"))
package_list <- c("sparklyr", "devtools") # https://cloud.r-project.org/web/packages/sparklyr/index.html

renv::activate(project = project_folder)
options(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/jammy/latest"))
install.packages("remotes")
remotes::install_cran(package_list)