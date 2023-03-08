package_list <- c("renv", "devtools", "sparklyr")

dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)
.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))
install.packages("pak", repos = sprintf(
  "https://r-lib.github.io/p/pak/stable/%s/%s/%s",
  .Platform$pkgType,
  R.Version()$os,
  R.Version()$arch
))
pak::pkg_install(package_list)
