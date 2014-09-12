/usr/bin/R CMD BATCH document.R
/usr/bin/R CMD build ../../
/usr/bin/R CMD check --as-cran statfi_0.9.82.tar.gz
/usr/bin/R CMD INSTALL statfi_0.9.82.tar.gz

