/usr/local/bin/R CMD BATCH document.R
/usr/local/bin/R CMD build ../../
/usr/local/bin/R CMD check --as-cran statfi_0.9.84.tar.gz
/usr/local/bin/R CMD INSTALL statfi_0.9.84.tar.gz

