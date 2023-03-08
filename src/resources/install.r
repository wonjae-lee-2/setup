package_list <- c("sparklyr", "devtools") # https://cloud.r-project.org/web/packages/sparklyr/index.html

renv::activate()
options(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/jammy/latest"))
install.packages("remotes")
remotes::install_cran(package_list)