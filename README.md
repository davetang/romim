[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.574927.svg)](https://doi.org/10.5281/zenodo.574927)

README
======

The `romim` package can be used to query the OMIM database; it uses the [OMIM API](https://www.omim.org/help/api). You can install this package using [remotes](https://github.com/r-lib/remotes) or [devtools](https://github.com/r-lib/devtools); the `remotes` package is a lightweight replacement of the install functions in devtools.

```r
install.packages("remotes")
remotes::install_github('davetang/romim')

library(romim)
help(package = "romim")
```

# Usage

You will need a valid API key, which you can request for on the [OMIM API page](https://www.omim.org/api). Note that in order to apply for API access you need:

>  Access will not be granted without a valid institutional email address. Email addresses from generic email providers such as Gmail, Yahoo, Hotmail, Live, MSN, iCloud, 126.com, 163.com or qq.com will be automatically rejected.

Use `set_key` to use your API key.

```r
library(romim)
Loading required package: XML
Loading required package: magrittr
Loading required package: xml2

# not a real key
set_key('AAAAAAAAAAAAAAAAAAAAAA')
```

Use `get_omim` to retrieve an OMIM entry using a [MIM number](https://en.wikipedia.org/wiki/Online_Mendelian_Inheritance_in_Man#MIM_numbers).

```r
omim_result <- get_omim(147920, geneMap = TRUE)
```

There are several functions for parsing `omim_result`.

```r
get_gene(omim_result)
# [1] "KMT2D, MLL2, ALR, KABUK1"

get_title(omim_result)
# [1] "KABUKI SYNDROME 1; KABUK1"

get_inheritance(omim_result)
# [1] "Autosomal dominant"
```

Use the `sapply` function to query a list of OMIM numbers.

```r
# a list of OMIM IDs
my_list <- list(100070,100100,100300,100600,100800,100820,101000,101200,101400,101600)

my_list_omim <- sapply(my_list, get_omim)
sapply(my_list_omim, get_title)
# [1] "AORTIC ANEURYSM, FAMILIAL ABDOMINAL, 1; AAA1"
# [2] "PRUNE BELLY SYNDROME; PBS"                   
# [3] "ADAMS-OLIVER SYNDROME 1; AOS1"               
# [4] "ACANTHOSIS NIGRICANS"                        
# [5] "ACHONDROPLASIA; ACH"                         
# [6] "ACHOO SYNDROME"                              
# [7] "NEUROFIBROMATOSIS, TYPE II; NF2"             
# [8] "APERT SYNDROME"                              
# [9] "SAETHRE-CHOTZEN SYNDROME; SCS"               
# [10] "PFEIFFER SYNDROME"   
```

Search OMIM disorders associated with a gene of interest.

```r
my_list <- gene_to_omim('TTN')
my_list_omim <- sapply(my_list, get_omim)
sapply(my_list_omim, get_title)
#                                                             604145 
#                               "CARDIOMYOPATHY, DILATED, 1G; CMD1G" 
#                                                             613765 
#                   "CARDIOMYOPATHY, FAMILIAL HYPERTROPHIC, 9; CMH9" 
#                                                             608807 
# "MUSCULAR DYSTROPHY, LIMB-GIRDLE, AUTOSOMAL RECESSIVE 10; LGMDR10" 
#                                                             603689 
#  "MYOPATHY, MYOFIBRILLAR, 9, WITH EARLY RESPIRATORY FAILURE; MFM9" 
#                                                             611705 
#                                            "SALIH MYOPATHY; SALMY" 
#                                                             600334 
#                          "TIBIAL MUSCULAR DYSTROPHY, TARDIVE; TMD"
```

Obtain OMIM IDs from a Phenotypic Series ID.

```r
phenotypic_series('PS213600')
# [1] "213600" "615007" "615483" "616413" "618317" "618824"
```

Search OMIM using free text, which may be useful for searching for OMIM entries using keywords.

```r
my_search <- search_phenotype("Waardenburg Shah syndrome")
omim_list <- sapply(my_search, get_omim, geneMap = TRUE)
sapply(omim_list, get_title)
#                                                                                                              277580 
#                                                                               "WAARDENBURG SYNDROME, TYPE 4A; WS4A" 
#                                                                                                              609136 
# "PERIPHERAL DEMYELINATING NEUROPATHY, CENTRAL DYSMYELINATION, WAARDENBURG SYNDROME, AND HIRSCHSPRUNG DISEASE; PCWH" 
#                                                                                                              611584 
#                                                                               "WAARDENBURG SYNDROME, TYPE 2E; WS2E" 
#                                                                                                              613266 
#                                                                               "WAARDENBURG SYNDROME, TYPE 4C; WS4C" 
#                                                                                                              613712 
#                                                                 "HIRSCHSPRUNG DISEASE, SUSCEPTIBILITY TO, 4; HSCR4" 
#                                                                                                              209880 
#                                                                "CENTRAL HYPOVENTILATION SYNDROME, CONGENITAL; CCHS" 
#                                                                                                              613265 
#                                                                               "WAARDENBURG SYNDROME, TYPE 4B; WS4B" 
#                                                                                                              600155 
#                                                                 "HIRSCHSPRUNG DISEASE, SUSCEPTIBILITY TO, 2; HSCR2" 
#                                                                                                              600501 
#                                                                                              "ABCD SYNDROME; ABCDS" 
#                                                                                                              142623 
#                                                                 "HIRSCHSPRUNG DISEASE, SUSCEPTIBILITY TO, 1; HSCR1" 
#                                                                                                              148820 
#                                                                                 "WAARDENBURG SYNDROME, TYPE 3; WS3" 
#                                                                                                              193500 
#                                                                                 "WAARDENBURG SYNDROME, TYPE 1; WS1" 
#                                                                                                              193510 
#                                                                               "WAARDENBURG SYNDROME, TYPE 2A; WS2A" 
#                                                                                                              613884 
#                                                                                "CHROMOSOME 13q14 DELETION SYNDROME" 
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

Then (re-)install the package to see if everything works.

```r
setwd('..')
install("romim")
```

# Troubleshooting

The first version of `romim` stopped working when the `xmlParse` function from the `XML` package was updated. In the latest version of `romim` (1.0.1), `read_xml` from the `xml2` package is used to retrieve the results. The functions `get_omim`, `gene_to_omim`, `phenotypic_series`, and `search_phenotype` now includes a `show_query` parameter that will output the query. You can paste this output to your Internet browser for troubleshooting purposes, to see if any results are retrieved.

# Further reading

See my [this blog post](https://davetang.org/muse/2015/03/17/getting-started-with-the-omim-api/) for more information on the OMIM API. For more information on creating R packages, see [this blog post](https://davetang.org/muse/2015/02/04/bed-granges/).

# Contact

Email me at davetang dot org (no spaces).

