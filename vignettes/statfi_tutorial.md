<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

Statistics Finland (Tilastokeskus) R tools
===========

This R package provides tools to access open data from [Statistics
Finland](http://www.stat.fi/tup/tilastotietokannat/index_fi.html),
including about 3000 data sets from [Statistics
Finland](http://www.stat.fi/org/lainsaadanto/avoin_data.html). Part of
[rOpenGov](http://ropengov.github.io).

[Geospatial data of Statistics Finland](http://www.stat.fi/tup/rajapintapalvelut/index_en.html) is available via the [gisfin](https://github.com/ropengov/gisfin/) package.

Tools for the new [PX-Web API] of Statistics Finland are available via the [pxweb](https://github.com/ropengov/pxweb/) package.

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
## [1] "Asuntokunnat koon ja asunnon talotyypin mukaan 1985-2014"                                 
## [2] "Asuntokunnat ja asuntoväestö asuntokunnan koon, huoneluvun ja talotyypin mukaan 2005-2014"
## [3] "Asuntokunnat ja asuntoväestö asumisväljyyden mukaan 1989-2014"                            
## [4] "Asuntokunnat koon, vanhimman iän ja sukupuolen sekä talotyypin mukaan 2005-2014"          
## [5] "Asuntokunnat ja asuntoväestö asuntokunnan koon ja hallintaperusteen mukaan 2005-2013"     
## [6] "Asunnot (lkm) talotyypin, käytössäolon ja rakennusvuoden mukaan 31.12.2014"
```

```r
# Investigate the first entry in StatFi data
print(datasets.statfi[1,])
```

```
##                                                                  File
## 1 http://pxweb2.stat.fi/database/StatFin/asu/asas/010_asas_tau_101.px
##      size          created          updated variables
## 1 1302632 2012-02-13 12:27 2015-05-26 07:30         4
##                  tablesize     type LANGUAGE
## 1 (318x8x5) x 30 = 381600  Maksuton       fi
##                                                                  TITLE
## 1 Asuntokunnat muuttujina Alue, Asuntokunnan koko, Talotyyppi ja Vuosi
##                                                DESCRIPTION
## 1 Asuntokunnat koon ja asunnon talotyypin mukaan 1985-2014
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
## Error in df[1:3, ]: object of type 'closure' is not subsettable
```


### <a name="statfi"></a>Statistics Finland (municipality information)

Source: [Tilastokeskus](http://pxweb2.stat.fi/Database/Kuntien%20perustiedot/Kuntien%20perustiedot/Kuntaportaali.px)


```r
# Download Statfi municipality data
municipality.info.statfi <- get_municipality_info_statfi()

# List available information fields for municipalities
names(municipality.info.statfi)
```

```
##  [1] "Alue"                                                                                                   
##  [2] "Maapinta-ala, km2 1.1.2013"                                                                             
##  [3] "Taajama-aste, % 1.1.2012"                                                                               
##  [4] "Väkiluku 31.12.2013"                                                                                    
##  [5] "Väkiluvun muutos, % 2012 - 2013"                                                                        
##  [6] "0-14 -vuotiaiden osuus väestöstä, % 31.12.2013"                                                         
##  [7] "15-64 -vuotiaiden osuus väestöstä, % 31.12.2013"                                                        
##  [8] "65 vuotta täyttäneiden osuus väestöstä, % 31.12.2013"                                                   
##  [9] "Ruotsinkielisten osuus väestöstä, % 31.12.2013"                                                         
## [10] "Ulkomaiden kansalaisten osuus väestöstä, % 31.12.2013"                                                  
## [11] "Kuntien välinen muuttovoitto/-tappio, henkilöä 2013"                                                    
## [12] "Syntyneiden enemmyys, henkilöä 2013"                                                                    
## [13] "Perheiden lukumäärä 31.12.2013"                                                                         
## [14] "Valtionveronalaiset tulot, euroa/tulonsaaja  2011"                                                      
## [15] "Asuntokuntien lukumäärä 31.12.2013"                                                                     
## [16] "Vuokra-asunnossa asuvien asuntokuntien osuus, % 31.12.2013"                                             
## [17] "Rivi- ja pientaloissa asuvien asuntokuntien osuus asuntokunnista, % 31.12.2013"                         
## [18] "Kesämökkien lukumäärä 31.12.2013"                                                                       
## [19] "Vähintään keskiasteen tutkinnon suorittaneiden osuus 15 vuotta täyttäneistä, % 31.12.2013"              
## [20] "Korkea-asteen tutkinnon suorittaneiden osuus 15 vuotta täyttäneistä, % 31.12.2013"                      
## [21] "Kunnassa olevien työpaikkojen lukumäärä 31.12.2012"                                                     
## [22] "Työllisten osuus 18-74-vuotiaista, % 31.12.2012"                                                        
## [23] "Työttömyysaste, % 31.12.2012"                                                                           
## [24] "Kunnassa asuvan työllisen työvoiman määrä 31.12.2012"                                                   
## [25] "Asuinkunnassaan työssäkäyvien osuus työllisestä työvoimasta, % 31.12. 2011"                             
## [26] "Alkutuotannon työpaikkojen osuus, % 31.12.2012"                                                         
## [27] "Jalostuksen työpaikkojen osuus, % 31.12.2012"                                                           
## [28] "Palvelujen työpaikkojen osuus, % 31.12.2012"                                                            
## [29] "Toimialaltaan tuntemattomien työpaikkojen osuus, % 31.12.2012"                                          
## [30] "Taloudellinen huoltosuhde, työvoiman ulkopuolella tai työttömänä olevat yhtä työllistä kohti 31.12.2012"
## [31] "Eläkkeellä olevien osuus väestöstä, % 31.12.2012"                                                       
## [32] "Yritystoimipaikkojen lukumäärä 2012"                                                                    
## [33] "Kunta"
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
## R version 3.2.0 (2015-04-16)
## Platform: x86_64-unknown-linux-gnu (64-bit)
## Running under: Ubuntu 15.04
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
##  [1] statfi_0.9.84      pxR_0.40.0         plyr_1.8.3        
##  [4] RJSONIO_1.3-0      stringr_1.0.0      sorvi_0.7.25      
##  [7] reshape2_1.4.1     dplyr_0.4.2        reshape_0.8.5     
## [10] knitr_1.10.5       scimapClient_0.2.1
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.11.6        magrittr_1.5       MASS_7.3-40       
##  [4] munsell_0.4.2      colorspace_1.2-6   R6_2.0.1          
##  [7] tools_3.2.0        parallel_3.2.0     grid_3.2.0        
## [10] gtable_0.1.2       DBI_0.3.1          assertthat_0.1    
## [13] digest_0.6.8       RColorBrewer_1.1-2 ggplot2_1.0.1     
## [16] formatR_1.2        evaluate_0.7       stringi_0.4-1     
## [19] scales_0.2.5       XML_3.98-1.2       proto_0.3-10
```
