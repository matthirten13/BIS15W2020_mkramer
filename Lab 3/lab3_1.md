---
title: "Importing Data and Dplyr: `filter()`"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
    toc: yes
    toc_float: yes
  pdf_document:
    toc: yes
---

## Learning Goals
*At the end of this exercise, you will be able to:*    
1. Import .csv files as data frames using `read_csv()`.  
2. Use summary functions to explore the dimensions, structure, and contents of a data frame.  
3. Use the `filter()` command of dplyr to sort data frames.  

## Review
At this point, I expect that you have familiarity in RStudio, GitHub, and basic operations in R. You understand how to do arithmetic, assign values to objects, and work with vectors or data matrices. If you are confused or need some extra help, please [email me](mailto: jmledford@ucdavis.edu).  

## Load the tidyverse

```r
library("tidyverse")
```

## Data Frames
For the remainder of the course, we will work exclusively with data frames. Recall that data frames store multiple classes of data. Last time, you were shown how to build data frames using the `data.frame()` command. However, scientists often make their data available as supplementary material associated with a publication. As data scientists, we capitalize on this by importing data directly into R.  

## Importing Data
R allows us to import a wide variety of data types. The most common type of file is a .csv file which stands for comma separated values. Spreadsheets are often developed in Excel then saved as .csv files for use in R. There are packages that allow you to open excel files and many other formats directly but .csv is the most common.  

To import any file, first make sure that you are in the correct working directory. If you are not in the correct directory, R will not "see" the file.

```r
getwd()
```

```
## [1] "/Users/thirten/Desktop/BIS15W2020_mkramer/Lab 3"
```

## Load Fish Scale Data
Here we open a .csv file with data on fish scales. Since we are using the tidyverse, we open the file using `read_csv()`. `readr` is included in the tidyverse set of packages. We can specify the function and package with the `::` symbol. This becomes important if you have multiple packages loaded which contain functions with the same name. 

```r
fish <- readr::read_csv("data/Gaeta_etal_CLC_data.csv")
```

```
## Parsed with column specification:
## cols(
##   lakeid = col_character(),
##   fish_id = col_double(),
##   annnumber = col_character(),
##   length = col_double(),
##   radii_length_mm = col_double(),
##   scalelength = col_double()
## )
```

## Summary functions
Once data have been uploaded, you may want to get an idea of its contents and dimensions. This may seem self-evident for small files but this is a big help for large data files.

```r
nrow(fish) #the number of rows
```

```
## [1] 4033
```


```r
ncol(fish) #the number of columns
```

```
## [1] 6
```


```r
dim(fish) #total dimensions
```

```
## [1] 4033    6
```


```r
names(fish) #column names
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```

There are many other useful summary functions, all of which work a bit differently. I didn't try to make the joke about fish heads and tails on purpose, but here it is anyway.

```r
head(fish, n = 10) # print the first n rows of the data frame
```

```
## # A tibble: 10 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
```


```r
tail(fish, n = 10) # print the last n rows of the data frame
```

```
## # A tibble: 10 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 WS         180 10           403            8.15        11.0
##  2 WS         180 9            403            7.49        11.0
##  3 WS         180 8            403            6.97        11.0
##  4 WS         180 7            403            6.24        11.0
##  5 WS         180 6            403            5.41        11.0
##  6 WS         180 5            403            4.98        11.0
##  7 WS         180 4            403            4.22        11.0
##  8 WS         180 3            403            3.04        11.0
##  9 WS         180 2            403            2.03        11.0
## 10 WS         180 1            403            1.19        11.0
```

We can also click on the `fish` data frame in the Environment tab or type View(fish).

```r
#View(fish)
```

`summary()` and `str()` are classic functions used by many R programmers. `glimpse()` is part of the tidyverse.

```r
summary(fish)
```

```
##     lakeid             fish_id       annnumber             length     
##  Length:4033        Min.   :  1.0   Length:4033        Min.   : 58.0  
##  Class :character   1st Qu.:156.0   Class :character   1st Qu.:253.0  
##  Mode  :character   Median :267.0   Mode  :character   Median :299.0  
##                     Mean   :258.3                      Mean   :293.3  
##                     3rd Qu.:376.0                      3rd Qu.:342.0  
##                     Max.   :478.0                      Max.   :420.0  
##  radii_length_mm    scalelength     
##  Min.   : 0.4569   Min.   : 0.6282  
##  1st Qu.: 2.3252   1st Qu.: 4.2596  
##  Median : 3.5380   Median : 5.4062  
##  Mean   : 3.6589   Mean   : 5.3821  
##  3rd Qu.: 4.8229   3rd Qu.: 6.4145  
##  Max.   :11.0258   Max.   :11.0258
```


```r
str(fish)
```

```
## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame':	4033 obs. of  6 variables:
##  $ lakeid         : chr  "AL" "AL" "AL" "AL" ...
##  $ fish_id        : num  299 299 299 300 300 300 300 301 301 301 ...
##  $ annnumber      : chr  "EDGE" "2" "1" "EDGE" ...
##  $ length         : num  167 167 167 175 175 175 175 194 194 194 ...
##  $ radii_length_mm: num  2.7 2.04 1.31 3.02 2.67 ...
##  $ scalelength    : num  2.7 2.7 2.7 3.02 3.02 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   lakeid = col_character(),
##   ..   fish_id = col_double(),
##   ..   annnumber = col_character(),
##   ..   length = col_double(),
##   ..   radii_length_mm = col_double(),
##   ..   scalelength = col_double()
##   .. )
```


```r
glimpse(fish)
```

```
## Observations: 4,033
## Variables: 6
## $ lakeid          <chr> "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AL",<U+2026>
## $ fish_id         <dbl> 299, 299, 299, 300, 300, 300, 300, 301, 301, 301, 301<U+2026>
## $ annnumber       <chr> "EDGE", "2", "1", "EDGE", "3", "2", "1", "EDGE", "3",<U+2026>
## $ length          <dbl> 167, 167, 167, 175, 175, 175, 175, 194, 194, 194, 194<U+2026>
## $ radii_length_mm <dbl> 2.697443, 2.037518, 1.311795, 3.015477, 2.670733, 2.1<U+2026>
## $ scalelength     <dbl> 2.697443, 2.697443, 2.697443, 3.015477, 3.015477, 3.0<U+2026>
```

## Practice
1. Load the data `mammal_lifehistories_v2.csv` and place it into a new object called `mammals`.

```r
mammals <- readr::read_csv("data/mammal_lifehistories_v2.csv")
```

```
## Parsed with column specification:
## cols(
##   order = col_character(),
##   family = col_character(),
##   Genus = col_character(),
##   species = col_character(),
##   mass = col_double(),
##   gestation = col_double(),
##   newborn = col_double(),
##   weaning = col_double(),
##   `wean mass` = col_double(),
##   AFR = col_double(),
##   `max. life` = col_double(),
##   `litter size` = col_double(),
##   `litters/year` = col_double()
## )
```

2. Provide the dimensions of the data frame.

```r
dim(mammals)
```

```
## [1] 1440   13
```

3. Check the column names in the data frame. 

```r
colnames(mammals)
```

```
##  [1] "order"        "family"       "Genus"        "species"      "mass"        
##  [6] "gestation"    "newborn"      "weaning"      "wean mass"    "AFR"         
## [11] "max. life"    "litter size"  "litters/year"
```

4. Use `str()` to show the structure of the data frame and its individual columns; compare this to `glimpse()`. 

```r
str(mammals)
```

```
## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame':	1440 obs. of  13 variables:
##  $ order       : chr  "Artiodactyla" "Artiodactyla" "Artiodactyla" "Artiodactyla" ...
##  $ family      : chr  "Antilocapridae" "Bovidae" "Bovidae" "Bovidae" ...
##  $ Genus       : chr  "Antilocapra" "Addax" "Aepyceros" "Alcelaphus" ...
##  $ species     : chr  "americana" "nasomaculatus" "melampus" "buselaphus" ...
##  $ mass        : num  45375 182375 41480 150000 28500 ...
##  $ gestation   : num  8.13 9.39 6.35 7.9 6.8 5.08 5.72 5.5 8.93 9.14 ...
##  $ newborn     : num  3246 5480 5093 10167 -999 ...
##  $ weaning     : num  3 6.5 5.63 6.5 -999 ...
##  $ wean mass   : num  8900 -999 15900 -999 -999 ...
##  $ AFR         : num  13.5 27.3 16.7 23 -999 ...
##  $ max. life   : num  142 308 213 240 -999 251 228 255 300 324 ...
##  $ litter size : num  1.85 1 1 1 1 1.37 1 1 1 1 ...
##  $ litters/year: num  1 0.99 0.95 -999 -999 2 -999 1.89 1 1 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   order = col_character(),
##   ..   family = col_character(),
##   ..   Genus = col_character(),
##   ..   species = col_character(),
##   ..   mass = col_double(),
##   ..   gestation = col_double(),
##   ..   newborn = col_double(),
##   ..   weaning = col_double(),
##   ..   `wean mass` = col_double(),
##   ..   AFR = col_double(),
##   ..   `max. life` = col_double(),
##   ..   `litter size` = col_double(),
##   ..   `litters/year` = col_double()
##   .. )
```

```r
glimpse(mammals)
```

```
## Observations: 1,440
## Variables: 13
## $ order          <chr> "Artiodactyla", "Artiodactyla", "Artiodactyla", "Artio<U+2026>
## $ family         <chr> "Antilocapridae", "Bovidae", "Bovidae", "Bovidae", "Bo<U+2026>
## $ Genus          <chr> "Antilocapra", "Addax", "Aepyceros", "Alcelaphus", "Am<U+2026>
## $ species        <chr> "americana", "nasomaculatus", "melampus", "buselaphus"<U+2026>
## $ mass           <dbl> 45375.0, 182375.0, 41480.0, 150000.0, 28500.0, 55500.0<U+2026>
## $ gestation      <dbl> 8.13, 9.39, 6.35, 7.90, 6.80, 5.08, 5.72, 5.50, 8.93, <U+2026>
## $ newborn        <dbl> 3246.36, 5480.00, 5093.00, 10166.67, -999.00, 3810.00,<U+2026>
## $ weaning        <dbl> 3.00, 6.50, 5.63, 6.50, -999.00, 4.00, 4.04, 2.13, 10.<U+2026>
## $ `wean mass`    <dbl> 8900, -999, 15900, -999, -999, -999, -999, -999, 15750<U+2026>
## $ AFR            <dbl> 13.53, 27.27, 16.66, 23.02, -999.00, 14.89, 10.23, 20.<U+2026>
## $ `max. life`    <dbl> 142, 308, 213, 240, -999, 251, 228, 255, 300, 324, 300<U+2026>
## $ `litter size`  <dbl> 1.85, 1.00, 1.00, 1.00, 1.00, 1.37, 1.00, 1.00, 1.00, <U+2026>
## $ `litters/year` <dbl> 1.00, 0.99, 0.95, -999.00, -999.00, 2.00, -999.00, 1.8<U+2026>
```

5. Print out the first few rows of the data using the function `head()`.  

```r
head(mammals, n=5)
```

```
## # A tibble: 5 x 13
##   order family Genus species   mass gestation newborn weaning `wean mass`    AFR
##   <chr> <chr>  <chr> <chr>    <dbl>     <dbl>   <dbl>   <dbl>       <dbl>  <dbl>
## 1 Arti<U+2026> Antil<U+2026> Anti<U+2026> americ<U+2026>  45375      8.13   3246.    3           8900   13.5
## 2 Arti<U+2026> Bovid<U+2026> Addax nasoma<U+2026> 182375      9.39   5480     6.5         -999   27.3
## 3 Arti<U+2026> Bovid<U+2026> Aepy<U+2026> melamp<U+2026>  41480      6.35   5093     5.63       15900   16.7
## 4 Arti<U+2026> Bovid<U+2026> Alce<U+2026> busela<U+2026> 150000      7.9   10167.    6.5         -999   23.0
## 5 Arti<U+2026> Bovid<U+2026> Ammo<U+2026> clarkei  28500      6.8    -999  -999           -999 -999  
## # <U+2026> with 3 more variables: `max. life` <dbl>, `litter size` <dbl>,
## #   `litters/year` <dbl>
```

6. Print out the last few rows using the function `tail()`.

```r
tail(mammals, n=5)
```

```
## # A tibble: 5 x 13
##   order family Genus species  mass gestation newborn weaning `wean mass`    AFR
##   <chr> <chr>  <chr> <chr>   <dbl>     <dbl>   <dbl>   <dbl>       <dbl>  <dbl>
## 1 Xena<U+2026> Megal<U+2026> Chol<U+2026> hoffma<U+2026>  4750      9.41    387.    0.69        -999   30.1
## 2 Xena<U+2026> Megal<U+2026> Chol<U+2026> didact<U+2026>  6070      8.67    355.    2.5         -999   36  
## 3 Xena<U+2026> Myrme<U+2026> Cycl<U+2026> didact<U+2026>  5070      8.92   -999     5           -999 -999  
## 4 Xena<U+2026> Myrme<U+2026> Myrm<U+2026> tridac<U+2026> 28500      6.19   1491.    1.83        -999   39  
## 5 Xena<U+2026> Myrme<U+2026> Tama<U+2026> tetrad<U+2026>  5030      5.22   -999  -999           -999   12  
## # <U+2026> with 3 more variables: `max. life` <dbl>, `litter size` <dbl>,
## #   `litters/year` <dbl>
```

## Tidyverse
The [tidyverse](www.tidyverse.org) is a collection of packages that make workflows in R easier. The packages operate more intuitively than base R commands. Although not universal, the tidyverse has been adopted by many R users.  
![*Data Science Workflow in the Tidyverse.*](tidyverse1.png)  

## dplyr: filter()
A core package in the tidyverse is dplyr. This package allows you to transform your data in many different ways including filtering, subsetting, and reordering. Dplyr allows you to parse out data of interest from a larger data frame.  

The first command that we will learn is `filter()`. Filter allows you to subset observations in a data frame by their values. You should still have the fish data loaded, but if not then please re-load.  

```r
fish <- 
  readr::read_csv("data/Gaeta_etal_CLC_data.csv")
```

```
## Parsed with column specification:
## cols(
##   lakeid = col_character(),
##   fish_id = col_double(),
##   annnumber = col_character(),
##   length = col_double(),
##   radii_length_mm = col_double(),
##   scalelength = col_double()
## )
```

Let's say that we are interested only in the fish that occur in the lake labeled AL. We can use `filter()` to extract these observations to build a new data frame focused on our question.

```r
filter(fish, lakeid == "AL")
```

```
## # A tibble: 383 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # <U+2026> with 373 more rows
```

Similarly, if we are only interested in fish with a length greater than or equal to 350 we can use `filter()` to do this work.

```r
filter(fish, length >= 350)
```

```
## # A tibble: 890 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         306 EDGE         350            6.94        6.94
##  2 AL         306 10           350            6.46        6.94
##  3 AL         306 9            350            6.16        6.94
##  4 AL         306 8            350            5.88        6.94
##  5 AL         306 7            350            5.42        6.94
##  6 AL         306 6            350            4.90        6.94
##  7 AL         306 5            350            4.46        6.94
##  8 AL         306 4            350            3.75        6.94
##  9 AL         306 3            350            2.93        6.94
## 10 AL         306 2            350            2.14        6.94
## # <U+2026> with 880 more rows
```

Filtering allows all of the expected operators; i.e. >, >=, <, <=, != (not equal), and == (equal).  It also allows us to extract multiple values simultaneously.

```r
filter(fish, lakeid == "AL" & length > 350) #only the fish that have lakeid AL AND length >350
```

```
## # A tibble: 314 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         307 EDGE         353            7.55        7.55
##  2 AL         307 13           353            7.28        7.55
##  3 AL         307 12           353            6.98        7.55
##  4 AL         307 11           353            6.73        7.55
##  5 AL         307 10           353            6.48        7.55
##  6 AL         307 9            353            6.22        7.55
##  7 AL         307 8            353            5.92        7.55
##  8 AL         307 7            353            5.44        7.55
##  9 AL         307 6            353            5.06        7.55
## 10 AL         307 5            353            4.37        7.55
## # <U+2026> with 304 more rows
```

When we use the '&' above, we are asking for a specific filter: provide only those data for which both lakeid=AL AND length is greater than 350. Filter will use other operators, but always keep in mind that you are asking for something very specific.  

Rules: & is "and", | is "or", and ! is "not".  

Notice that the code below generates a data frame larger than the one above because it includes non AL lakes.

```r
filter(fish, lakeid == "AL" | length < 350)
```

```
## # A tibble: 3,468 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # <U+2026> with 3,458 more rows
```

If you want to filter multiple values in the same variable you can use the `%in%` operator. This is a useful way to simplify your code.

```r
filter(fish, length %in% c(167, 175))
```

```
## # A tibble: 18 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167           2.70         2.70
##  2 AL         299 2            167           2.04         2.70
##  3 AL         299 1            167           1.31         2.70
##  4 AL         300 EDGE         175           3.02         3.02
##  5 AL         300 3            175           2.67         3.02
##  6 AL         300 2            175           2.14         3.02
##  7 AL         300 1            175           1.23         3.02
##  8 BO         397 EDGE         175           2.67         2.67
##  9 BO         397 3            175           2.39         2.67
## 10 BO         397 2            175           1.59         2.67
## 11 BO         397 1            175           0.830        2.67
## 12 LSG         45 EDGE         175           3.21         3.21
## 13 LSG         45 3            175           2.92         3.21
## 14 LSG         45 2            175           2.44         3.21
## 15 LSG         45 1            175           1.60         3.21
## 16 RD         103 EDGE         167           2.80         2.80
## 17 RD         103 2            167           2.10         2.80
## 18 RD         103 1            167           1.31         2.80
```

But, be careful when reading the code like a human; why does this not work? How would you correct the problem?

```r
filter(fish, length == 167 & length == 175)
```

```
## # A tibble: 0 x 6
## # <U+2026> with 6 variables: lakeid <chr>, fish_id <dbl>, annnumber <chr>,
## #   length <dbl>, radii_length_mm <dbl>, scalelength <dbl>
```

## Practice
1. Filter the `fish` data to include the samples from lake `DY`.

```r
filter(fish, lakeid == "DY")
```

```
## # A tibble: 355 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 DY         359 EDGE         124           1.68         1.68
##  2 DY         359 2            124           1.35         1.68
##  3 DY         359 1            124           0.594        1.68
##  4 DY         360 EDGE         233           3.85         3.85
##  5 DY         360 6            233           3.34         3.85
##  6 DY         360 5            233           3.03         3.85
##  7 DY         360 4            233           2.60         3.85
##  8 DY         360 3            233           2.24         3.85
##  9 DY         360 2            233           1.71         3.85
## 10 DY         360 1            233           0.832        3.85
## # <U+2026> with 345 more rows
```


2. Filter the data to include all lakes except AL.

```r
filter(fish, lakeid != "AL")
```

```
## # A tibble: 3,650 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AR         269 EDGE         140            2.01        2.01
##  2 AR         269 1            140            1.48        2.01
##  3 AR         270 EDGE         193            2.66        2.66
##  4 AR         270 3            193            2.39        2.66
##  5 AR         270 2            193            2.03        2.66
##  6 AR         270 1            193            1.42        2.66
##  7 AR         271 EDGE         220            3.50        3.50
##  8 AR         271 5            220            3.13        3.50
##  9 AR         271 4            220            2.86        3.50
## 10 AR         271 3            220            2.63        3.50
## # <U+2026> with 3,640 more rows
```


3. Filter the data to include all lakes except AL and DY.

```r
filter(fish, lakeid != "AL" & lakeid != "DY")
```

```
## # A tibble: 3,295 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AR         269 EDGE         140            2.01        2.01
##  2 AR         269 1            140            1.48        2.01
##  3 AR         270 EDGE         193            2.66        2.66
##  4 AR         270 3            193            2.39        2.66
##  5 AR         270 2            193            2.03        2.66
##  6 AR         270 1            193            1.42        2.66
##  7 AR         271 EDGE         220            3.50        3.50
##  8 AR         271 5            220            3.13        3.50
##  9 AR         271 4            220            2.86        3.50
## 10 AR         271 3            220            2.63        3.50
## # <U+2026> with 3,285 more rows
```


4. Filter the data to include all fish with a scale length greater than or equal to 11.

```r
filter(fish, scalelength >= 11)
```

```
## # A tibble: 17 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 WS         180 EDGE         403           11.0         11.0
##  2 WS         180 16           403           10.6         11.0
##  3 WS         180 15           403           10.3         11.0
##  4 WS         180 14           403            9.93        11.0
##  5 WS         180 13           403            9.56        11.0
##  6 WS         180 12           403            9.17        11.0
##  7 WS         180 11           403            8.62        11.0
##  8 WS         180 10           403            8.15        11.0
##  9 WS         180 9            403            7.49        11.0
## 10 WS         180 8            403            6.97        11.0
## 11 WS         180 7            403            6.24        11.0
## 12 WS         180 6            403            5.41        11.0
## 13 WS         180 5            403            4.98        11.0
## 14 WS         180 4            403            4.22        11.0
## 15 WS         180 3            403            3.04        11.0
## 16 WS         180 2            403            2.03        11.0
## 17 WS         180 1            403            1.19        11.0
```


5. Filter the data to include fish only from lake AL and with a scalelength greater than or equal to 2 and less than or equal to 4.

```r
filter(fish, lakeid == "AL" & scalelength >= 2 & scalelength <= 4)
```

```
## # A tibble: 11 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## 11 AL         301 1            194            1.55        3.34
```


## That's it, let's take a break!   

-->[Home](https://jmledford3115.github.io/datascibiol/)
