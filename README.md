[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.574927.svg)](https://doi.org/10.5281/zenodo.574927)

README
======

The `romim` package can be used to query the OMIM database; it relies on the [OMIM API](https://www.omim.org/help/api). Installing this package requires the `devtools` package.

```r
install.packages("devtools")
library("devtools")

install_github('davetang/romim')
library(romim)

help(package = "romim")
```

# Usage

You will need a valid API key; request for access on the [OMIM API page](http://www.omim.org/api/).

```r
library(romim)
# Loading required package: XML

# not a real key
set_key('AAAAAAAAAAAAAAAAAAAAAA')
omim_result <- get_omim(147920, geneMap = TRUE)

get_gene(omim_result)
# [1] "KMT2D, MLL2, ALR, KABUK1"
get_title(omim_result)
# [1] "KABUKI SYNDROME 1; KABUK1"

# a list of OMIM IDs
my_list <- list(100070,100100,100300,100600,100800,100820,101000,101200,101400,101600)
my_list_omim <- sapply(my_list, get_omim)
sapply(my_list_omim, get_title)
#  [1] "AORTIC ANEURYSM, FAMILIAL ABDOMINAL, 1; AAA1"
#  [2] "PRUNE BELLY SYNDROME; PBS"                   
#  [3] "ADAMS-OLIVER SYNDROME 1; AOS1"               
#  [4] "ACANTHOSIS NIGRICANS"                        
#  [5] "ACHONDROPLASIA; ACH"                         
#  [6] "ACHOO SYNDROME"                              
#  [7] "NEUROFIBROMATOSIS, TYPE II; NF2"             
#  [8] "APERT SYNDROME"                              
#  [9] "SAETHRE-CHOTZEN SYNDROME; SCS"               
# [10] "PFEIFFER SYNDROME"

# search OMIM disorders associated with a gene of interest
my_list <- gene_to_omim('TTN')
my_list_omim <- sapply(my_list, get_omim)
sapply(my_list_omim, get_title)
                                                     604145                                                      613765 
                       "CARDIOMYOPATHY, DILATED, 1G; CMD1G"            "CARDIOMYOPATHY, FAMILIAL HYPERTROPHIC, 9; CMH9" 
                                                     608807                                                      611705 
         "MUSCULAR DYSTROPHY, LIMB-GIRDLE, TYPE 2J; LGMD2J"   "MYOPATHY, EARLY-ONSET, WITH FATAL CARDIOMYOPATHY; EOMFC" 
                                                     603689                                                      600334 
"HEREDITARY MYOPATHY WITH EARLY RESPIRATORY FAILURE; HMERF"                   "TIBIAL MUSCULAR DYSTROPHY, TARDIVE; TMD"

# obtain OMIM IDs from a Phenotypic Series ID
phenotypic_series('PS213600')
[1] "606656" "213600" "615007" "615483" "616413"

# search OMIM using free text
my_search <- search_phenotype("Waardenburg Shah syndrome")
omim_list <- sapply(my_search, get_omim, geneMap = TRUE)
sapply(omim_list, get_title)
                                                                                                             609136 
"PERIPHERAL DEMYELINATING NEUROPATHY, CENTRAL DYSMYELINATION, WAARDENBURG SYNDROME, AND HIRSCHSPRUNG DISEASE; PCWH" 
                                                                                                             277580 
                                                                              "WAARDENBURG SYNDROME, TYPE 4A; WS4A" 
                                                                                                             600501 
                                                                                             "ABCD SYNDROME; ABCDS" 
                                                                                                             142623 
                                                                "HIRSCHSPRUNG DISEASE, SUSCEPTIBILITY TO, 1; HSCR1" 
                                                                                                             193500 
                                                                                "WAARDENBURG SYNDROME, TYPE 1; WS1" 
                                                                                                             193510 
                                                                              "WAARDENBURG SYNDROME, TYPE 2A; WS2A" 
                                                                                                             613265 
                                                                              "WAARDENBURG SYNDROME, TYPE 4B; WS4B" 
                                                                                                             613266 
                                                                              "WAARDENBURG SYNDROME, TYPE 4C; WS4C" 
                                                                                                             148820 
                                                                                "WAARDENBURG SYNDROME, TYPE 3; WS3"
```

# How to modify package

The functions are in the `R` directory and you can modify them as you please. If you modify the documentation in these files, you will need to run document(); see below.

```bash
ls -1 R
gene_to_omim.R
get_gene.R
get_inheritance.R
get_omim.R
get_pheno_key.R
get_title.R
phenotypic_series.R
search_phenotype.R
set_key.R
```

To add more functions, create an `.R` file inside the `R` directory; the file should follow the [Roxygen process](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html). For example:

```r
#' Set API key
#'
#' This function sets the API key
#' 
#' @param key Your API key
#' @keywords key
#' @export
#' @examples
#' my_key <- set_key('aAS5ASdf35jasdnadsfj') # not a real key

set_key <- function(key){
  my_key <<- paste('apiKey=', key, sep='')
}
```

After you have added the file (or modified the original files), you'll need to run document().

```r
library(roxygen2)
library(devtools)

# change this to where you cloned the repo
setwd('~/github/romim/')
document()
```

# Further reading

See my [this blog post](http://davetang.org/muse/2015/03/17/getting-started-with-the-omim-api/) for more information on the OMIM API. For more information on creating R packages, see [this blog post](http://davetang.org/muse/2015/02/04/bed-granges/).

# Contact

Email me at davetang dot org (no spaces).

