<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

Statistics Finland (Tilastokeskus) R tools
===========

This R package provides tools to access open data from [Statistics
Finland](http://www.stat.fi/tup/tilastotietokannat/index_fi.html),
including about 3000 data sets from [Statistics
Finland](http://www.stat.fi/org/lainsaadanto/avoin_data.html),
[Eurostat](http://pxweb2.stat.fi/Database/Eurostat/databasetree_fi.asp),
and other [international
statistics](http://pxweb2.stat.fi/Database/Kansainvalisen_tiedon_tietokanta/databasetree_fi.asp)). This R package is part of the [rOpenGov](http://ropengov.github.io)
project.

The listings of [Statistics Finland (StatFi), Eurostat and
International
statistics](http://www.stat.fi/org/lainsaadanto/avoin_data.html) are
available for browsing in PCAxis, CSV and XML format:

 * StatFi [PCAxis](http://pxweb2.stat.fi/database/StatFin/databasetree_fi.asp) [CSV](http://pxweb2.stat.fi/database/StatFin/StatFin_rap_csv.csv) [XML](http://pxweb2.stat.fi/database/StatFin/StatFin_rap_xml.csv)  
 * Eurostat [PCAxis](http://pxweb2.stat.fi/Database/Eurostat/databasetree_fi.asp) [CSV](http://pxweb2.stat.fi/database/StatFin/StatFin_rap.csv)  
 * International statistics [PC Axis](http://pxweb2.stat.fi/Database/Kansainvalisen_tiedon_tietokanta/databasetree_fi.asp)


## Installation

Release version for general use:


```r
install.packages("statfi")
library(statfi)
```


Development version (potentially unstable):


```r
install.packages("devtools")
library(devtools)
install_github("statfi", "ropengov")
library(statfi)
```



### Browsing the data

You can download these listings in R as follows:


```r
# Load the library
library(statfi)

# Statistics Finland open data listing
datasets.statfi <- list_statfi_files()

# Eurostat open data listing
datasets.eurostat <- list_eurostat_files()

# International statistics open data listing Listing not available for R
# (but the data sets are!); browse manually at:
# http://pxweb2.stat.fi/Database/Kansainvalisen_tiedon_tietokanta/databasetree_fi.asp

# Descriptions of the first entries
head(datasets.statfi$DESCRIPTION)
```

```
## [1] "Asuntokunnat koon ja asunnon talotyypin mukaan 1985-2012"                                 
## [2] "Asuntokunnat ja asuntoväestö asuntokunnan koon, huoneluvun ja talotyypin mukaan 2005-2012"
## [3] "Asuntokunnat ja asuntoväestö asumisväljyyden mukaan 1989-2012"                            
## [4] "Asuntokunnat koon, vanhimman iän ja sukupuolen sekä talotyypin mukaan 2005-2012"          
## [5] "Asuntokunnat ja asuntoväestö asuntokunnan koon ja hallintaperusteen mukaan 2005-2012"     
## [6] "Asunnot (lkm) talotyypin, käytössäolon ja rakennusvuoden mukaan 31.12.2012"
```

```r

# Investigate the first entry in StatFi data
print(datasets.statfi[1, ])
```

```
##                                                                  File
## 1 http://pxweb2.stat.fi/database/StatFin/asu/asas/010_asas_tau_101.px
##      size          created          updated variables
## 1 1230502 2012-02-13 12:27 2013-05-22 08:10         4
##                  tablesize     type LANGUAGE
## 1 (321x8x5) x 28 = 359520  Maksuton       fi
##                                                                  TITLE
## 1 Asuntokunnat muuttujina Alue, Asuntokunnan koko, Talotyyppi ja Vuosi
##                                                DESCRIPTION
## 1 Asuntokunnat koon ja asunnon talotyypin mukaan 1985-2012
```


## Retrieving the data

Retrieve data from Statfi by defining URL of the data set. For the
listing of available data sets and their corresponding URLs, see
above.


```r
library(statfi)

# Define URL (see list_statfi_files() and list_eurostat_files())
url <- "http://pxweb2.stat.fi/Database/StatFin/tul/tvt/2009/120_tvt_2009_2011-02-18_tau_112_fi.px"

# Get the data
df <- get_statfi(url)
df[1:3, ]
```

```
##                           Tiedot    Kunta Vuosi     dat
## 1                    Tulonsaajia Koko maa  2005 4314900
## 2 Veronalaiset tulot keskimäärin Koko maa  2005   21695
## 3   Veronalaiset tulot, mediaani Koko maa  2005   17793
```



## Licensing and Citations

### Citing the Data

Regarding the data, kindly cite Statfi with a link to
[http://www.statfi.fi](http://www.statfi.fi/) and/or
[Eurostat](http://epp.eurostat.ec.europa.eu/portal/page/portal/statistics/search_database)
accordingly. We are grateful to Statistics Finland open data
personnell for their support during the R package development.

### Citing the R tools

This work can be freely used, modified and distributed under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD\_licenses). Kindly cite the
R package as 'Leo Lahti, Juuso Parkkinen ja Joona Lehtomäki (C)
2010-2014. statfi R package. URL: http://ropengov.github.io/statfi'.


### Session info

This tutorial was created with


```r
sessionInfo()
```

```
## R version 3.0.2 (2013-09-25)
## Platform: x86_64-pc-linux-gnu (64-bit)
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.5      statfi_0.9.02  pxR_0.29       stringr_0.6.2 
## [5] roxygen2_3.1.0 devtools_1.4.1
## 
## loaded via a namespace (and not attached):
##  [1] brew_1.0-6      codetools_0.2-8 digest_0.6.4    evaluate_0.5.1 
##  [5] formatR_0.10    httr_0.2        memoise_0.1     parallel_3.0.2 
##  [9] Rcpp_0.11.0     RCurl_1.95-4.1  tools_3.0.2     whisker_0.3-3
```

