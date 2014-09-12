<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

Statistics Finland (Tilastokeskus) R tools
===========

This R package provides tools to access open data from [Statistics
Finland](http://www.stat.fi/tup/tilastotietokannat/index_fi.html),
including about 3000 data sets from [Statistics
Finland](http://www.stat.fi/org/lainsaadanto/avoin_data.html). 

This R package is part of the [rOpenGov](http://ropengov.github.io)
project.


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


## Available data sets

The listings of [Statistics Finland (StatFi) open
data](http://www.stat.fi/org/lainsaadanto/avoin_data.html) are
available for browsing in PCAxis, CSV and XML format. These include
the following data collections:

 * StatFi [PCAxis](http://pxweb2.stat.fi/database/StatFin/databasetree_fi.asp) [CSV](http://pxweb2.stat.fi/database/StatFin/StatFin_rap_csv.csv) [XML](http://pxweb2.stat.fi/database/StatFin/StatFin_rap_xml.csv)  
 * Eurostat [PCAxis](http://pxweb2.stat.fi/Database/Eurostat/databasetree_fi.asp) [CSV](http://pxweb2.stat.fi/database/StatFin/StatFin_rap.csv)  
 * International statistics [PC Axis](http://pxweb2.stat.fi/Database/Kansainvalisen_tiedon_tietokanta/databasetree_fi.asp)

In summary, browse these listings to find the URL for your data set of
interest. Then use the get_statfi function to download the data in
R. For examples, see below.

### Listing the data sets in R

Download statfi open data listings in R as follows:


```r
# Load the library
library(statfi)

# Statistics Finland open data listing
datasets.statfi <- list_statfi_files()

# Descriptions of the first entries
head(datasets.statfi$DESCRIPTION)
```

```
## [1] "Asuntokunnat koon ja asunnon talotyypin mukaan 1985-2013"                                 
## [2] "Asuntokunnat ja asuntoväestö asuntokunnan koon, huoneluvun ja talotyypin mukaan 2005-2013"
## [3] "Asuntokunnat ja asuntoväestö asumisväljyyden mukaan 1989-2013"                            
## [4] "Asuntokunnat koon, vanhimman iän ja sukupuolen sekä talotyypin mukaan 2005-2013"          
## [5] "Asuntokunnat ja asuntoväestö asuntokunnan koon ja hallintaperusteen mukaan 2005-2012"     
## [6] "Asunnot (lkm) talotyypin, käytössäolon ja rakennusvuoden mukaan 31.12.2013"
```

```r
# Investigate the first entry in StatFi data
print(datasets.statfi[1,])
```

```
##                                                                  File
## 1 http://pxweb2.stat.fi/database/StatFin/asu/asas/010_asas_tau_101.px
##      size          created          updated variables
## 1 1271762 2012-02-13 12:27 2014-05-21 07:30         4
##                  tablesize     type LANGUAGE
## 1 (321x8x5) x 29 = 372360  Maksuton       fi
##                                                                  TITLE
## 1 Asuntokunnat muuttujina Alue, Asuntokunnan koko, Talotyyppi ja Vuosi
##                                                DESCRIPTION
## 1 Asuntokunnat koon ja asunnon talotyypin mukaan 1985-2013
```

This provides the list of statfi data sets. For other international
open statistics available via Statfi, [browse the data sets
manually](http://pxweb2.stat.fi/Database/Kansainvalisen_tiedon_tietokanta/databasetree_fi.asp)
to find the URL for your dataset of interest. For Eurostat data, we
recommend the [eurostat](http://github.com/ropengov/eurostat) R
package.


## Retrieving the data

Retrieve data from Statfi by defining URL of the data set. For the
listing of available data sets and their corresponding URLs, see
above.


```r
library(statfi)

# Define URL (see list_statfi_files() or browse manually as described above)
url <- "http://pxweb2.stat.fi/Database/StatFin/tul/tvt/2009/120_tvt_2009_2011-02-18_tau_112_fi.px"

# Download the data
df <- get_statfi(url)
df[1:3,]
```

```
##                           Tiedot    Kunta Vuosi     dat
## 1                    Tulonsaajia Koko maa  2005 4314900
## 2 Veronalaiset tulot keskimäärin Koko maa  2005   21695
## 3   Veronalaiset tulot, mediaani Koko maa  2005   17793
```


## Licensing and Citations

### Citing the Data

Regarding the data, kindly cite [Statfi](http://www.statfi.fi/). We
are grateful to Statistics Finland open data personnell for their
support during the R package development.

### Citing the R package

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
## R version 3.1.1 (2014-07-10)
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
## [1] knitr_1.6     statfi_0.9.82 pxR_0.40.0    plyr_1.8.1    RJSONIO_1.3-0
## [6] reshape2_1.4  stringr_0.6.2 devtools_1.5 
## 
## loaded via a namespace (and not attached):
##  [1] digest_0.6.4   evaluate_0.5.5 formatR_0.10   httr_0.4      
##  [5] memoise_0.2.1  parallel_3.1.1 Rcpp_0.11.2    RCurl_1.95-4.3
##  [9] roxygen2_4.0.1 tools_3.1.1    whisker_0.4
```
