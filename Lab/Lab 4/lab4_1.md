---
title: "Tidyr 1: Tidy data and `pivot_long()`"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
    toc: yes
    toc_float: yes
  pdf_document:
    toc: yes
---

> **For Big-Data Scientists, "Janitor Work" Is Key Hurdle to Insights.**  
> "Data scientists, according to interviews and expert estimates, spend from 50 percent to 80 percent of their time mired in the mundane labor of collecting and preparing data, before it can be explored for useful information."  
> [New York Times (2014)](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html)

## Learning Goals
*At the end of this exercise, you will be able to:*    
1. Explain the difference between tidy and messy data.  
2. Evaluate a dataset as tidy or messy.    
3. Use the `pivot_longer()` function of tidyr to transform data from wide to long format.  
4. Use `separate()` to split observations within a column.  

## Overview
The  quote sums above sums up much of the work in data science. Simply put, most of the data that you end up working with will be messy, disorganized, and not **tidy**. By the end of the course, you will learn multiple ways of wrangling messy data into tidy data that are ready for analysis.  

## Resources
- [tidyr `pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html)  
- [pivoting](https://cran.r-project.org/web/packages/tidyr/vignettes/pivot.html)  

## Load the tidyverse

```r
library(tidyverse)
```

## Tidy data
Most "wild" data that you will encounter are organized incorrectly for work in R and, as you might expect, the tools used to transform data are a core part of the tidyverse. I will attempt to summarize the most important points below, but you should read [chapter 12 of the data science text](https://r4ds.had.co.nz/tidy-data.html) for a more thorough explanation.  

`Tidy` data in the sense of the tidyverse follows three conventions:   
(1) each variable has its own column  
(2) each observation has its own row  
(3) each value has its own cell  

This is summarized in the image below. The package used to tidy data is called **tidyr** and is a core part of the tidyverse.  
![*Tidy Data.*](tidy-1.png)

## `pivot_longer()`  
Scientists frequently use spreadsheets that are organized to make data entry efficient. This is often referred to as **wide format**. Unfortunately, the wide format creates a problem because column names may actually represent values of a variable. The command `pivot_longer()` shifts data from wide to long format.   

Rules:  
+ `pivot_longer`(cols, names_to, values_to)
+ `cols` - Columns to pivot to longer format
+ `names_to` - Name of the new column; it will contain the column names of gathered columns as values
+ `values_to` - Name of the new column; it will contain the data stored in the values of gathered columns

## Example 1: column names are data
The following data show results from a drug trial with four treatments on six patients. The values represent resting heart rate.  

```r
heartrate <- readr::read_csv("data/heartrate.csv")
```

```
## Parsed with column specification:
## cols(
##   patient = col_character(),
##   a = col_double(),
##   b = col_double(),
##   c = col_double(),
##   d = col_double()
## )
```

```r
heartrate
```

```
## # A tibble: 6 x 5
##   patient      a     b     c     d
##   <chr>    <dbl> <dbl> <dbl> <dbl>
## 1 Margaret    72    74    80    68
## 2 Frank       84    84    88    76
## 3 Hawkeye     64    66    68    64
## 4 Trapper     60    58    64    58
## 5 Radar       74    72    78    70
## 6 Henry       88    87    88    72
```

Let's assess whether or not these data are tidy.  
(1) each variable has its own column  
*No. Some of the column names are actually variables (treatment a, b, c, or d).*  
(2) each observation has its own row  
*No. The observations are grouped in a single row by patient.*  
(3) each value has its own cell  
*Yes. There are no unusual combinations of data in each cell.*    

To fix this problem, we need to reshape the table to long format while keeping track of column names and values. We do this using `pivot_longer()`. Notice that the dimensions of the data frame change.  

```r
heartrate %>% 
  pivot_longer(-patient, #patient does not pivot
               names_to = "drug", 
               values_to = "heartrate"
               )
```

```
## # A tibble: 24 x 3
##    patient  drug  heartrate
##    <chr>    <chr>     <dbl>
##  1 Margaret a            72
##  2 Margaret b            74
##  3 Margaret c            80
##  4 Margaret d            68
##  5 Frank    a            84
##  6 Frank    b            84
##  7 Frank    c            88
##  8 Frank    d            76
##  9 Hawkeye  a            64
## 10 Hawkeye  b            66
## # <U+2026> with 14 more rows
```

## Practice
1. Import the file `relig_income.csv` and store it as a new object `relig_income`.  

```r
relig_income <- readr::read_csv("data/relig_income.csv")
```

```
## Parsed with column specification:
## cols(
##   religion = col_character(),
##   `<$10k` = col_double(),
##   `$10-20k` = col_double(),
##   `$20-30k` = col_double(),
##   `$30-40k` = col_double(),
##   `$40-50k` = col_double(),
##   `$50-75k` = col_double(),
##   `$75-100k` = col_double(),
##   `$100-150k` = col_double(),
##   `>150k` = col_double(),
##   `Don't know/refused` = col_double()
## )
```

```r
relig_income
```

```
## # A tibble: 18 x 11
##    religion `<$10k` `$10-20k` `$20-30k` `$30-40k` `$40-50k` `$50-75k` `$75-100k`
##    <chr>      <dbl>     <dbl>     <dbl>     <dbl>     <dbl>     <dbl>      <dbl>
##  1 "Agnost<U+2026>      27        34        60        81        76       137        122
##  2 "Atheis<U+2026>      12        27        37        52        35        70         73
##  3 "Buddhi<U+2026>      27        21        30        34        33        58         62
##  4 "Cathol<U+2026>     418       617       732       670       638      1116        949
##  5 "Don\u2<U+2026>      15        14        15        11        10        35         21
##  6 "Evange<U+2026>     575       869      1064       982       881      1486        949
##  7 "Hindu"        1         9         7         9        11        34         47
##  8 "Histor<U+2026>     228       244       236       238       197       223        131
##  9 "Jehova<U+2026>      20        27        24        24        21        30         15
## 10 "Jewish"      19        19        25        25        30        95         69
## 11 "Mainli<U+2026>     289       495       619       655       651      1107        939
## 12 "Mormon"      29        40        48        51        56       112         85
## 13 "Muslim"       6         7         9        10         9        23         16
## 14 "Orthod<U+2026>      13        17        23        32        32        47         38
## 15 "Other <U+2026>       9         7        11        13        13        14         18
## 16 "Other <U+2026>      20        33        40        46        49        63         46
## 17 "Other <U+2026>       5         2         3         4         2         7          3
## 18 "Unaffi<U+2026>     217       299       374       365       341       528        407
## # <U+2026> with 3 more variables: `$100-150k` <dbl>, `>150k` <dbl>, `Don't
## #   know/refused` <dbl>
```

2. Why are these data untidy?  
#Variabls used as column names
3. Use `pivot_longer()` to make the data tidy.  

```r
relig_income %>% 
  pivot_longer(-religion,
               names_to = "income",
               values_to = "num_people")
```

```
## # A tibble: 180 x 3
##    religion income             num_people
##    <chr>    <chr>                   <dbl>
##  1 Agnostic <$10k                      27
##  2 Agnostic $10-20k                    34
##  3 Agnostic $20-30k                    60
##  4 Agnostic $30-40k                    81
##  5 Agnostic $40-50k                    76
##  6 Agnostic $50-75k                   137
##  7 Agnostic $75-100k                  122
##  8 Agnostic $100-150k                 109
##  9 Agnostic >150k                      84
## 10 Agnostic Don't know/refused         96
## # <U+2026> with 170 more rows
```

## Example 2: some column names are data
Some (but not all) of the column names are data. We also have NA's.

```r
billboard <- readr::read_csv("data/billboard.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_double(),
##   artist = col_character(),
##   track = col_character(),
##   date.entered = col_date(format = ""),
##   wk66 = col_logical(),
##   wk67 = col_logical(),
##   wk68 = col_logical(),
##   wk69 = col_logical(),
##   wk70 = col_logical(),
##   wk71 = col_logical(),
##   wk72 = col_logical(),
##   wk73 = col_logical(),
##   wk74 = col_logical(),
##   wk75 = col_logical(),
##   wk76 = col_logical()
## )
```

```
## See spec(...) for full column specifications.
```

```r
billboard
```

```
## # A tibble: 317 x 79
##    artist track date.entered   wk1   wk2   wk3   wk4   wk5   wk6   wk7   wk8
##    <chr>  <chr> <date>       <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1 2 Pac  Baby<U+2026> 2000-02-26      87    82    72    77    87    94    99    NA
##  2 2Ge+h<U+2026> The <U+2026> 2000-09-02      91    87    92    NA    NA    NA    NA    NA
##  3 3 Doo<U+2026> Kryp<U+2026> 2000-04-08      81    70    68    67    66    57    54    53
##  4 3 Doo<U+2026> Loser 2000-10-21      76    76    72    69    67    65    55    59
##  5 504 B<U+2026> Wobb<U+2026> 2000-04-15      57    34    25    17    17    31    36    49
##  6 98^0   Give<U+2026> 2000-08-19      51    39    34    26    26    19     2     2
##  7 A*Tee<U+2026> Danc<U+2026> 2000-07-08      97    97    96    95   100    NA    NA    NA
##  8 Aaliy<U+2026> I Do<U+2026> 2000-01-29      84    62    51    41    38    35    35    38
##  9 Aaliy<U+2026> Try <U+2026> 2000-03-18      59    53    38    28    21    18    16    14
## 10 Adams<U+2026> Open<U+2026> 2000-08-26      76    76    74    69    68    67    61    58
## # <U+2026> with 307 more rows, and 68 more variables: wk9 <dbl>, wk10 <dbl>,
## #   wk11 <dbl>, wk12 <dbl>, wk13 <dbl>, wk14 <dbl>, wk15 <dbl>, wk16 <dbl>,
## #   wk17 <dbl>, wk18 <dbl>, wk19 <dbl>, wk20 <dbl>, wk21 <dbl>, wk22 <dbl>,
## #   wk23 <dbl>, wk24 <dbl>, wk25 <dbl>, wk26 <dbl>, wk27 <dbl>, wk28 <dbl>,
## #   wk29 <dbl>, wk30 <dbl>, wk31 <dbl>, wk32 <dbl>, wk33 <dbl>, wk34 <dbl>,
## #   wk35 <dbl>, wk36 <dbl>, wk37 <dbl>, wk38 <dbl>, wk39 <dbl>, wk40 <dbl>,
## #   wk41 <dbl>, wk42 <dbl>, wk43 <dbl>, wk44 <dbl>, wk45 <dbl>, wk46 <dbl>,
## #   wk47 <dbl>, wk48 <dbl>, wk49 <dbl>, wk50 <dbl>, wk51 <dbl>, wk52 <dbl>,
## #   wk53 <dbl>, wk54 <dbl>, wk55 <dbl>, wk56 <dbl>, wk57 <dbl>, wk58 <dbl>,
## #   wk59 <dbl>, wk60 <dbl>, wk61 <dbl>, wk62 <dbl>, wk63 <dbl>, wk64 <dbl>,
## #   wk65 <dbl>, wk66 <lgl>, wk67 <lgl>, wk68 <lgl>, wk69 <lgl>, wk70 <lgl>,
## #   wk71 <lgl>, wk72 <lgl>, wk73 <lgl>, wk74 <lgl>, wk75 <lgl>, wk76 <lgl>
```

Solution 1: specify a range of columns that you want to pivot.

```r
billboard2 <- 
  billboard %>% 
  pivot_longer(wk1:wk76, # a range of columns
               names_to = "week",
               values_to = "rank",
               values_drop_na = TRUE #this will drop the NA's
               )
billboard2
```

```
## # A tibble: 5,307 x 5
##    artist  track                   date.entered week   rank
##    <chr>   <chr>                   <date>       <chr> <dbl>
##  1 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk1      87
##  2 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk2      82
##  3 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk3      72
##  4 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk4      77
##  5 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk5      87
##  6 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk6      94
##  7 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk7      99
##  8 2Ge+her The Hardest Part Of ... 2000-09-02   wk1      91
##  9 2Ge+her The Hardest Part Of ... 2000-09-02   wk2      87
## 10 2Ge+her The Hardest Part Of ... 2000-09-02   wk3      92
## # <U+2026> with 5,297 more rows
```

Solution 2: OR, specify columns that you want to stay fixed.

```r
billboard3 <- 
  billboard %>% 
  pivot_longer(-c(artist, track, date.entered), #specific columns
               names_to = "week",
               values_to = "rank",
               values_drop_na = TRUE
               )
billboard3
```

```
## # A tibble: 5,307 x 5
##    artist  track                   date.entered week   rank
##    <chr>   <chr>                   <date>       <chr> <dbl>
##  1 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk1      87
##  2 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk2      82
##  3 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk3      72
##  4 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk4      77
##  5 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk5      87
##  6 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk6      94
##  7 2 Pac   Baby Don't Cry (Keep... 2000-02-26   wk7      99
##  8 2Ge+her The Hardest Part Of ... 2000-09-02   wk1      91
##  9 2Ge+her The Hardest Part Of ... 2000-09-02   wk2      87
## 10 2Ge+her The Hardest Part Of ... 2000-09-02   wk3      92
## # <U+2026> with 5,297 more rows
```

Solution 3: identify columns by a prefix, remove the prefix and all NA's.

```r
billboard %>% 
   pivot_longer(
   cols = starts_with("wk"),
   names_to = "week",
   names_prefix = "wk",
   values_to = "rank",
   values_drop_na = TRUE)
```

```
## # A tibble: 5,307 x 5
##    artist  track                   date.entered week   rank
##    <chr>   <chr>                   <date>       <chr> <dbl>
##  1 2 Pac   Baby Don't Cry (Keep... 2000-02-26   1        87
##  2 2 Pac   Baby Don't Cry (Keep... 2000-02-26   2        82
##  3 2 Pac   Baby Don't Cry (Keep... 2000-02-26   3        72
##  4 2 Pac   Baby Don't Cry (Keep... 2000-02-26   4        77
##  5 2 Pac   Baby Don't Cry (Keep... 2000-02-26   5        87
##  6 2 Pac   Baby Don't Cry (Keep... 2000-02-26   6        94
##  7 2 Pac   Baby Don't Cry (Keep... 2000-02-26   7        99
##  8 2Ge+her The Hardest Part Of ... 2000-09-02   1        91
##  9 2Ge+her The Hardest Part Of ... 2000-09-02   2        87
## 10 2Ge+her The Hardest Part Of ... 2000-09-02   3        92
## # <U+2026> with 5,297 more rows
```

## Practice  
1. Import `plant_data.csv` as a new object `plant_data`.  

```r
plant_data <- readr::read_csv("data/plant_data.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_double(),
##   genotype = col_character(),
##   water_sched_prog = col_character(),
##   greenhouse = col_character()
## )
```

```
## See spec(...) for full column specifications.
```

```r
plant_data
```

```
## # A tibble: 3 x 33
##   genotype water_sched_prog greenhouse  day1  day2  day3  day4  day5  day6  day7
##   <chr>    <chr>            <chr>      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 control  A                A761        21.7  19.9  20.7  19.4  20.2  19.2  20.6
## 2 mutant1  A                A761        24.3  24.9  25.2  25.3  27.4  25.5  25.4
## 3 mutant2  A                A761        20.7  21.3  21.3  22.5  19.8  21.4  21.9
## # <U+2026> with 23 more variables: day8 <dbl>, day9 <dbl>, day10 <dbl>, day11 <dbl>,
## #   day12 <dbl>, day13 <dbl>, day14 <dbl>, day15 <dbl>, day16 <dbl>,
## #   day17 <dbl>, day18 <dbl>, day19 <dbl>, day20 <dbl>, day21 <dbl>,
## #   day22 <dbl>, day23 <dbl>, day24 <dbl>, day25 <dbl>, day26 <dbl>,
## #   day27 <dbl>, day28 <dbl>, day29 <dbl>, day30 <dbl>
```

2. Why are these data not tidy?  
#Day should be treated as a variable
3. Use `pivot_longer()` to make the data tidy. Focus the data only on genotype, day, and measurement.  

```r
plant_data %>% 
  pivot_longer(
    cols = starts_with("day"),
    names_to = "Day",
    names_prefix = "day",
    values_to = "Number of Genetically Enchanced Cyborg Plants Spawned"
  )
```

```
## # A tibble: 90 x 5
##    genotype water_sched_prog greenhouse Day   `Number of Genetically Enchanced <U+2026>
##    <chr>    <chr>            <chr>      <chr>                              <dbl>
##  1 control  A                A761       1                                   21.7
##  2 control  A                A761       2                                   19.9
##  3 control  A                A761       3                                   20.7
##  4 control  A                A761       4                                   19.4
##  5 control  A                A761       5                                   20.2
##  6 control  A                A761       6                                   19.2
##  7 control  A                A761       7                                   20.6
##  8 control  A                A761       8                                   19.9
##  9 control  A                A761       9                                   19.2
## 10 control  A                A761       10                                  20.4
## # <U+2026> with 80 more rows
```

## Example 3: more than one variable in a column name
In this case, there are two observations in each column name.

```r
qpcr_untidy <- readr::read_csv("data/qpcr_untidy.csv")
```

```
## Parsed with column specification:
## cols(
##   gene = col_character(),
##   exp1_rep1 = col_double(),
##   exp1_rep2 = col_double(),
##   exp1_rep3 = col_double(),
##   exp2_rep1 = col_double(),
##   exp2_rep2 = col_double(),
##   exp2_rep3 = col_double(),
##   exp3_rep1 = col_double(),
##   exp3_rep2 = col_double(),
##   exp3_rep3 = col_double()
## )
```

```r
qpcr_untidy
```

```
## # A tibble: 5 x 10
##   gene  exp1_rep1 exp1_rep2 exp1_rep3 exp2_rep1 exp2_rep2 exp2_rep3 exp3_rep1
##   <chr>     <dbl>     <dbl>     <dbl>     <dbl>     <dbl>     <dbl>     <dbl>
## 1 A          21.7      19.8      20.7      18.3      20.4      17.6      20.6
## 2 B          24.3      24.8      25.2      26.0      29.9      26.4      25.4
## 3 C          20.7      21.5      21.3      25.5      18.7      22.3      21.9
## 4 D          26.9      28.0      27.7      33.1      24.3      28.9      28.5
## 5 E          25.0      22.7      23.8      21.1      23.4      20.2      23.7
## # <U+2026> with 2 more variables: exp3_rep2 <dbl>, exp3_rep3 <dbl>
```

`names_sep` helps pull these apart, but we still have "exp" and "rep" to deal with.  

```r
qpcr_untidy %>%
  pivot_longer(
    exp1_rep1:exp3_rep3,
    names_to = c("experiment", "replicate"),
    names_sep = "_",
    values_to = "mRNA_expression")
```

```
## # A tibble: 45 x 4
##    gene  experiment replicate mRNA_expression
##    <chr> <chr>      <chr>               <dbl>
##  1 A     exp1       rep1                 21.7
##  2 A     exp1       rep2                 19.8
##  3 A     exp1       rep3                 20.7
##  4 A     exp2       rep1                 18.3
##  5 A     exp2       rep2                 20.4
##  6 A     exp2       rep3                 17.6
##  7 A     exp3       rep1                 20.6
##  8 A     exp3       rep2                 19.9
##  9 A     exp3       rep3                 19.2
## 10 B     exp1       rep1                 24.3
## # <U+2026> with 35 more rows
```

## Example 4: more than one value or observation in a row
This is often caused by an entry error, but R will not be able to work with it unless the values are separated. This doesn't use `pivot_longer()` but is a common problem.  

```r
length_data <- readr::read_csv("data/length_data.csv")
```

```
## Parsed with column specification:
## cols(
##   sample = col_character(),
##   length = col_character()
## )
```

```r
length_data
```

```
## # A tibble: 5 x 2
##   sample length  
##   <chr>  <chr>   
## 1 A      34      
## 2 B      23;45;68
## 3 C      <NA>    
## 4 D      32;29;61
## 5 E      41
```


```r
length_data %>% 
  transform(length = str_split(length, ";")) %>%
  unnest(length)
```

```
## # A tibble: 9 x 2
##   sample length
##   <chr>  <chr> 
## 1 A      34    
## 2 B      23    
## 3 B      45    
## 4 B      68    
## 5 C      <NA>  
## 6 D      32    
## 7 D      29    
## 8 D      61    
## 9 E      41
```

## `separate()`
In our last example, we have the sex of each patient included with their name. Are these data tidy? No, there is more than one value per cell in the patient column and the columns a, b, c, d once again represent values.

```r
heartrate2 <- readr::read_csv("data/heartrate2.csv")
```

```
## Parsed with column specification:
## cols(
##   patient = col_character(),
##   a = col_double(),
##   b = col_double(),
##   c = col_double(),
##   d = col_double()
## )
```

```r
heartrate2
```

```
## # A tibble: 6 x 5
##   patient        a     b     c     d
##   <chr>      <dbl> <dbl> <dbl> <dbl>
## 1 Margaret_f    72    74    80    68
## 2 Frank_m       84    84    88    76
## 3 Hawkeye_m     64    66    68    64
## 4 Trapper_m     60    58    64    58
## 5 Radar_m       74    72    78    70
## 6 Henry_m       88    87    88    72
```

We need to start by separating the patient names from their sexes. `separate()` needs to know which column you want to split, the names of the new columns, and what to look for in terms of breaks in the data.

```r
heartrate2 %>% 
  separate(patient, into= c("patient", "sex"), sep = "_")
```

```
## # A tibble: 6 x 6
##   patient  sex       a     b     c     d
##   <chr>    <chr> <dbl> <dbl> <dbl> <dbl>
## 1 Margaret f        72    74    80    68
## 2 Frank    m        84    84    88    76
## 3 Hawkeye  m        64    66    68    64
## 4 Trapper  m        60    58    64    58
## 5 Radar    m        74    72    78    70
## 6 Henry    m        88    87    88    72
```

## Practice
1. Re-examine `heartrate2`. Use `separate()` for the sexes, `pivot_longer()` to tidy, and `arrange()` to organize by patient and drug. Store this as a new object `heartrate3`.  

```r
heartrate3 <-
  heartrate2 %>% 
  separate(patient, into=c("patient", "sex"), sep ="_") %>% 
  pivot_longer(
    -c(patient, sex),
    names_to = "drug",
    values_to = "heartrate"
  ) %>% 
  arrange(drug) %>% 
  arrange(patient)
heartrate3
```

```
## # A tibble: 24 x 4
##    patient sex   drug  heartrate
##    <chr>   <chr> <chr>     <dbl>
##  1 Frank   m     a            84
##  2 Frank   m     b            84
##  3 Frank   m     c            88
##  4 Frank   m     d            76
##  5 Hawkeye m     a            64
##  6 Hawkeye m     b            66
##  7 Hawkeye m     c            68
##  8 Hawkeye m     d            64
##  9 Henry   m     a            88
## 10 Henry   m     b            87
## # <U+2026> with 14 more rows
```

2. `unite()` is the opposite of separate(). Its syntax is straightforward. You only need to give a new column name and then list the columns to combine with a separation character.  Give it a try below by recombining patient and sex from `heartrate3`.  

## That's it, let's take a break!   

-->[Home](https://jmledford3115.github.io/datascibiol/)
