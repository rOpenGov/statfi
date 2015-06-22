#' Get information of Finnish municipalities from Statistics Finland 2013 
#  (C) Tilastokeskus 2013 http://www.stat.fi/tup/atilastotietokannat/index.html
#' 
#' @param verbose verbose 
#' @param ... Arguments to be passed

#' @return A data frame with municipality data
#' @export 
#' @importFrom pxR read.px
#' @importFrom reshape cast
#' @importFrom sorvi convert_municipality_names
#'
#' @references
#' See citation("statfo") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples \dontrun{df <- get_municipality_info_statfi()}
#' @keywords utilities

get_municipality_info_statfi <- function (verbose = TRUE, ...) {

  url <- "http://pxweb2.stat.fi/Database/Kuntien%20perustiedot/Kuntien%20perustiedot/Kuntaportaali.px"
  message(paste("Downloading data from", url))

  # FIXME: merge GetPopulationRegister function in here

  # Get municipality information from Tilastokeskus
  px <- read.px(url)
  
  df <- as.data.frame(px) 
  # read.csv(url, encoding = "latin1", as.is = T, colClasses = 'character', sep = ";"); 

  if (verbose) { message("Cleaning up municipality names") }
  # FIXME: scandinavic characters cause error in Windows systems, find solution
  df$Alue <- sapply(strsplit(as.character(df[[grep("Alueluokitus", names(df))]]), " - "), function (x) {x[[1]]})

  if (verbose) {message("Converting to wide format")}
  df <- cast(df[, c("Alue", "Tunnusluku", "value")], Alue ~ Tunnusluku) 

  df[, "Alue"] <- convert_municipality_names(df[, "Alue"])

  df$Alue <- factor(df$Alue)
  df$Kunta <- factor(df$Alue)
  rownames(df) <- as.character(df[["Alue"]])

  # FIXME at higher level: Kunta is factor but Maakunta is character and 
  # UTF-8 does not seem to be working with Maakunta field
  rownames(df) <- df$Kunta

  # Order municipalities alphabetically
  df <- df[sort(rownames(df)), ]

  df

}

#' List the open data files available from Statistics Finland
#' 
#' Arguments:
#'  @param format "px", "csv", "xml" depending on the desired format of the data files
#'
#' Returns:
#'  @return table
#'
#' @export
#' @references
#' See citation("statfi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples df <- list_statfi_files()
#' @keywords utilities

list_statfi_files <- function (format = "px") {

  if (format == "px") {
    url <- "http://pxweb2.stat.fi/database/StatFin/StatFin_rap.csv"
  } else {  
    url <- paste("http://pxweb2.stat.fi/database/StatFin/StatFin_rap_", format, ".csv", sep = "")
  }

  message(paste("Downloading", url))
  d <- try(read.csv(url, sep = ";", encoding = "latin1"))
  if (length(grep("^Error", d)) == 1) {warning(paste("No files available at", url)); return(character(0))}

  tab <- apply(d, 2, function (x) {iconv(x, from = "latin1", to = "utf-8")})
  tab <- as.data.frame(tab)

  tab$File <- as.character(tab$File)
  tab$size <- as.numeric(as.character(tab$size)) 
  tab$created <- as.character(tab$created) 
  tab$updated <- as.character(tab$updated) 
  tab$tablesize <- as.character(tab$tablesize) 
  tab$TITLE <- as.character(tab$TITLE)
  tab$DESCRIPTION <- as.character(tab$DESCRIPTION)

  tab

}


#' List the open data files available from Eurostat
#' 
#' Arguments:
#'  @param ... Arguments to be passed
#'
#' Returns:
#'  @return table
#'
#' @export
#' @references
#' See citation("statfi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # df <- list_eurostat_files()
#' @keywords utilities

list_eurostat_files <- function (...) {

  url <- "http://pxweb2.stat.fi/database/StatFin/StatFin_rap.csv"

  message(paste("Downloading", url))
  d <- try(read.csv(url, sep = ";", encoding = "latin1"))
  if (length(grep("^Error", d)) == 1) {warning(paste("No files available at", url)); return(character(0))}

  tab <- apply(d, 2, function (x) {iconv(x, from = "latin1", to = "utf-8")})
  tab <- as.data.frame(tab)

  tab$File <- as.character(tab$File)
  tab$size <- as.numeric(as.character(tab$size)) 
  tab$created <- as.character(tab$created) 
  tab$updated <- as.character(tab$updated) 
  tab$variables <- as.numeric(tab$variables)
  tab$tablesize <- as.character(tab$tablesize) 
  tab$TITLE <- as.character(tab$TITLE)
  tab$DESCRIPTION <- as.character(tab$DESCRIPTION)

  tab

}




#' Get PC Axis data with custom preprocessing for PC Axis 
#' files from Statistics Finland (Tilastokeskus) http://www.stat.fi/
#'
#' Arguments:
#'  @param url or local file name of the StatFi file
#'  @param format One of the following: "px", "csv", "xml". Specifies the desired format of the source file.
#'  @param verbose verbose
#'
#' Returns:
#'  @return data.frame
#'
#' @details If the reading of PX file fails, CSV is used instead.
#'
#' @export
#' @references
#' See citation("statfi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples \dontrun{px <- get_statfi("http://pxweb2.stat.fi/database/StatFin/vrm/synt/080_synt_tau_203.px")}
#' @keywords utilities

get_statfi <- function (url, format = "px", verbose = TRUE) {

  if (format == "px") {

    url <- gsub("\\.csv", "\\.px", url)
    url <- gsub("\\.xml", "\\.px", url)

    # If URL is given, read the data into PX object
    if (is_url(url)) {
      message(paste("Reading StatFi data from ", url))
      px <- read_px(url)
    }

    # Convert to data.frame 
    if (class(px) == "px") { 
      df <- as.data.frame(px) 
    }

  } else if (format == "xml") {

    warning("xml not yet implemented for statfi; using csv instead")

    url <- gsub("\\.px", "\\.csv", url)
    url <- gsub("\\.xml", "\\.csv", url)
    df <- read.csv(url, encoding = "latin1", as.is = T, colClasses = 'character', sep = ";"); 

  } else if (format == "csv") {

    # TODO
    url <- gsub("\\.px", "\\.csv", url)
    url <- gsub("\\.xml", "\\.csv", url)
    df <- read.csv(url, encoding = "latin1", as.is = T, colClasses = 'character', sep = ";"); 

  }

  # Some preprocessing for field names
  # TODO Improve! Also convert all to UTF8
  fields <- c("Alue", "Kunta")
  for (nam in intersect(fields, colnames(df))) {
    df[[nam]] <- sapply(df[[nam]], function (x) {strsplit(as.character(x), " - ")[[1]][[1]]})
  }    
  fields <- c("Vuosi")
  for (nam in intersect(fields, colnames(df))) {
    df[[nam]] <- as.numeric(as.character(df[[nam]]))
  }    

  df

}



