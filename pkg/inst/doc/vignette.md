<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

Statistics Finland (Tilastokeskus) R tools
===========

This is the rOpenGov [statfi](http://ropengov.github.com/statfi) R
package to access data from [Statistics
Finland](http://www.stat.fi/org/lainsaadanto/avoin_data.html) and
[Eurostat]().


### Installation

Release version for general users:


```r
install.packages("statfi")
library(statfi)
```


Development version for developers:


```r
install.packages("devtools")
library(devtools)
install_github("statfi", "ropengov")
library(statfi)
```


Further installation and development instructions at the [home
page](http://ropengov.github.com/statfi). For further usage examples,
see [Louhos-blog](http://louhos.wordpress.com) and
[Datawiki](https://github.com/ropengov/statfi/wiki/Data), and
[takomo](https://github.com/louhos/takomo/tree/master/StatFi).


### Statistics Finland and Eurostat open data listing

The listing of [open data sets from Statistics Finland (StatFi) and
Eurostat](http://www.stat.fi/org/lainsaadanto/avoin_data.html) are
available for browsing:

 * [StatFi (CSV)](http://pxweb2.stat.fi/database/StatFin/StatFin_rap_csv.csv)
 * [StatFi (XML)](http://pxweb2.stat.fi/database/StatFin/StatFin_rap_xml.csv)
 * [Eurostat](http://pxweb2.stat.fi/database/StatFin/StatFin_rap.csv)

You can download these listings in R as follows:


```r
# Load the library
library(statfi)

# List the open data files available from Statistics Finland
datasets.statfi <- list_statfi_files()

# List the open data files available from Eurostat
datasets.eurostat <- list_eurostat_files()

# Investigate the first entry
print(datasets[1, ])
```

```
## Error: object 'datasets' not found
```

```r

# EuroStat data files, descriptions of the first entries
head(datasets.eurostat$DESCRIPTION)
```

```
## [1] "Asuntokunnat koon ja asunnon talotyypin mukaan 1985-2012"                                 
## [2] "Asuntokunnat ja asuntoväestö asuntokunnan koon, huoneluvun ja talotyypin mukaan 2005-2012"
## [3] "Asuntokunnat ja asuntoväestö asumisväljyyden mukaan 1989-2012"                            
## [4] "Asuntokunnat koon, vanhimman iän ja sukupuolen sekä talotyypin mukaan 2005-2012"          
## [5] "Asuntokunnat ja asuntoväestö asuntokunnan koon ja hallintaperusteen mukaan 2005-2012"     
## [6] "Asunnot (lkm) talotyypin, käytössäolon ja rakennusvuoden mukaan 31.12.2012"
```


### Median incomes in Finnish municipalities


```r
library(statfi)

# Define URL
url <- "http://pxweb2.stat.fi/Database/StatFin/tul/tvt/2009/120_tvt_2009_2011-02-18_tau_112_fi.px"

# Get the data
df <- get_statfi(url)
head(df)
```

```
##                                                           Tiedot    Kunta
## 1                                                    Tulonsaajia Koko maa
## 2                                 Veronalaiset tulot keskimäärin Koko maa
## 3                                   Veronalaiset tulot, mediaani Koko maa
## 4 Veronalaiset tulot ml. verovapaat osingot ja korot keskimäärin Koko maa
## 5   Veronalaiset tulot ml. verovapaat osingot ja korot, mediaani Koko maa
## 6                                         Ansiotulot keskimäärin Koko maa
##   Vuosi     dat
## 1  2005 4314900
## 2  2005   21695
## 3  2005   17793
## 4  2005   22110
## 5  2005   17910
## 6  2005   20375
```


### Visualization of PC Axis data

See also the example in [Louhos blog](https://louhos.wordpress.com/2011/10/19/tilastokeskuksen-pc-axis-muotoisten-aineistojen-visualisointi-suomen-kartalla/). 


```r
# Get Finnish municipality borders (C) Maanmittauslaitos 2011
# http://www.maanmittauslaitos.fi/aineistot-palvelut/digitaaliset-tuotteet/ilmaiset-aineistot/hankinta
sp <- LoadMML(data.id = "kunta1_p", resolution = "1_milj_Shape_etrs_shape")
```

```
## Error: could not find function "LoadMML"
```

```r

# Pick information from statfi data
mediaanitulo <- subset(df, Tiedot == "Veronalaiset tulot, mediaani" & Vuosi == 
    2009)

# Lisaa tiedot karttaobjektiin
sp@data$mediaanitulo <- mediaanitulo$dat[match(sp$Kunta.FI, mediaanitulo$Kunta)]
```

```
## Error: object 'sp' not found
```

```r
# Korvaa puuttuvat arvot nollalla
sp[["mediaanitulo"]][is.na(sp[["mediaanitulo"]])] <- 0
```

```
## Error: object 'sp' not found
```

```r

# Visualize
varname <- "mediaanitulo"
int <- max(abs(sp[[varname]]))
```

```
## Error: object 'sp' not found
```

```r
q <- PlotShape(sp, varname, type = "oneway", main = "Median income", at = seq(-1, 
    int, length = 11))
```

```
## Error: could not find function "PlotShape"
```



# Licensing and Citations

### Statistics Finland data

Cite Statfi and link to
[http://www.statfi.fi](http://www.statfi.fi/).

### statfi R package

This work can be freely used, modified and distributed under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD\_licenses). Kindly cite the
R package as 'Leo Lahti, Juuso Parkkinen ja Joona Lehtomäki
(2010-2013). statfi R package. URL:
http://ropengov.github.io/statfi)'.


### Session info


This vignette was created with


```r
sessionInfo()
```

```
## R version 3.0.1 (2013-05-16)
## Platform: x86_64-unknown-linux-gnu (64-bit)
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=C                 LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] statfi_0.9.01 pxR_0.29      stringr_0.6.2 knitr_1.2    
## 
## loaded via a namespace (and not attached):
## [1] digest_0.6.3   evaluate_0.4.3 formatR_0.7    tools_3.0.1
```

