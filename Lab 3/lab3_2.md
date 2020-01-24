---
title: "Tidyverse: `select()`, pipes ` %>%`, and `mutate()`"
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
1. Use the functions of dplyr (filter, select, arrange) to organize and sort data frames.  
2. Use `mutate()` to calculate a new column from existing columns.  

## Review
In the last lab you were introduced to the tidyverse and the core function `filter()`. Filter allows us to separate variables with specific attributes of interest from large, complex data. `filter()` works by looking through rows, but what about columns? We need the new function `select()` to separate columns of interest. As you may expect, we will use `filter()` and `select()` together to focus on the variables and values of interest.  

## Load the tidyverse

```r
library("tidyverse")
```

## Load the fish scale data

```r
fish <- readr::read_csv("data/Gaeta_etal_CLC_data.csv")
```


```r
names(fish)
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```

## dplyr: select()
Select allows you to build a new data frame by selecting your variable(s) of interest. Our fish data has six variables, but this should give you some ideas especially when you have a large data frames with lots of variables.  

What if we are only interested in lakeid and scalelength.

```r
select(fish, lakeid, scalelength)
```

```
## # A tibble: 4,033 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # <U+2026> with 4,023 more rows
```

The - operator is useful in select. It allows us to select everything except the specified variables.

```r
select(fish, -fish_id, -annnumber, -length, -radii_length_mm)
```

```
## # A tibble: 4,033 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # <U+2026> with 4,023 more rows
```

For very large data frames with lots of variables, `select()` utilizes lots of different operators to make things easier. Let's say we are only interested in the variables that deal with length.

```r
select(fish, contains("length"))
```

```
## # A tibble: 4,033 x 3
##    length radii_length_mm scalelength
##     <dbl>           <dbl>       <dbl>
##  1    167            2.70        2.70
##  2    167            2.04        2.70
##  3    167            1.31        2.70
##  4    175            3.02        3.02
##  5    175            2.67        3.02
##  6    175            2.14        3.02
##  7    175            1.23        3.02
##  8    194            3.34        3.34
##  9    194            2.97        3.34
## 10    194            2.29        3.34
## # <U+2026> with 4,023 more rows
```

Some additional options to select columns based on a specific criteria include:  
1. ends_with() = Select columns that end with a character string  
2. contains() = Select columns that contain a character string  
3. matches() = Select columns that match a regular expression  
4. one_of() = Select columns names that are from a group of names  

## Practice
1. What are the names of the columns in the `fish` data?

```r
colnames(fish)
```

```
## [1] "lakeid"          "fish_id"         "annnumber"       "length"         
## [5] "radii_length_mm" "scalelength"
```

2. We are only interested in the variables `lakeid`, `length`, and `scalelength`. Use `select()` to build a new dataframe focused on these variables.

```r
select(fish, lakeid, length, scalelength)
```

```
## # A tibble: 4,033 x 3
##    lakeid length scalelength
##    <chr>   <dbl>       <dbl>
##  1 AL        167        2.70
##  2 AL        167        2.70
##  3 AL        167        2.70
##  4 AL        175        3.02
##  5 AL        175        3.02
##  6 AL        175        3.02
##  7 AL        175        3.02
##  8 AL        194        3.34
##  9 AL        194        3.34
## 10 AL        194        3.34
## # <U+2026> with 4,023 more rows
```

3. Repeat #2 above using the `-` operator.  

```r
select(fish, -fish_id, -annnumber, -radii_length_mm)
```

```
## # A tibble: 4,033 x 3
##    lakeid length scalelength
##    <chr>   <dbl>       <dbl>
##  1 AL        167        2.70
##  2 AL        167        2.70
##  3 AL        167        2.70
##  4 AL        175        3.02
##  5 AL        175        3.02
##  6 AL        175        3.02
##  7 AL        175        3.02
##  8 AL        194        3.34
##  9 AL        194        3.34
## 10 AL        194        3.34
## # <U+2026> with 4,023 more rows
```

## dplyr: Can we combine filter() and select()?
Absolutely. This is one of the strengths of the tidyverse, it uses the same grammar to specify commands.

```r
fish2 <- select(fish, lakeid, scalelength)
filter(fish2, lakeid == "AL")
```

```
## # A tibble: 383 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # <U+2026> with 373 more rows
```

## dplyr: Pipes %>% 
The code above works fine but there is a more efficient way. We need to learn pipes `%>%`. Pipes allow you to feed the output from one function to the input of another function. We are going to use pipes from here on to keep things cleaner. (command+shift+m)

```r
fish %>%
  select(lakeid, scalelength) %>%
  filter(lakeid == "AL")
```

```
## # A tibble: 383 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # <U+2026> with 373 more rows
```

## Practice
1. Build a dataframe focused on the lakes `AL` and `AR` and looking at radii length between 2 and 4 only. Use pipes!  

```r
fish %>% 
  select(lakeid, radii_length_mm) %>% 
  filter(lakeid == "AL" | lakeid == "AR") %>% 
  filter(between(radii_length_mm,2,4)) %>% 
  arrange(desc(radii_length_mm))
```

```
## # A tibble: 253 x 2
##    lakeid radii_length_mm
##    <chr>            <dbl>
##  1 AR                4.00
##  2 AR                3.99
##  3 AR                3.99
##  4 AR                3.98
##  5 AR                3.98
##  6 AR                3.96
##  7 AR                3.94
##  8 AR                3.94
##  9 AR                3.94
## 10 AL                3.94
## # <U+2026> with 243 more rows
```

## dplyr: arrange()
The `arrange()` command is a bit like a sort command in excel.

```r
fish %>% 
  arrange(scalelength)
```

```
## # A tibble: 4,033 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 WS         151 EDGE          58           0.628       0.628
##  2 WS         153 EDGE          78           0.637       0.637
##  3 LSG         59 EDGE          64           0.773       0.773
##  4 WS         152 EDGE          74           0.832       0.832
##  5 LSG         58 EDGE          92           1.15        1.15 
##  6 WS         155 EDGE         128           1.41        1.41 
##  7 WS         155 2            128           1.16        1.41 
##  8 WS         155 1            128           0.579       1.41 
##  9 BO         391 EDGE         107           1.43        1.43 
## 10 BO         391 1            107           0.695       1.43 
## # <U+2026> with 4,023 more rows
```

To sort in decreasing order, wrap the variable name in `desc()`.

```r
fish %>% 
  arrange(desc(scalelength))
```

```
## # A tibble: 4,033 x 6
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
## # <U+2026> with 4,023 more rows
```

`arrange()` can be very helpful in combination with the other functions.

```r
fish %>% 
  select(lakeid, length, fish_id, scalelength) %>% 
  filter(lakeid=="AL") %>% 
  arrange(fish_id)
```

```
## # A tibble: 383 x 4
##    lakeid length fish_id scalelength
##    <chr>   <dbl>   <dbl>       <dbl>
##  1 AL        167     299        2.70
##  2 AL        167     299        2.70
##  3 AL        167     299        2.70
##  4 AL        175     300        3.02
##  5 AL        175     300        3.02
##  6 AL        175     300        3.02
##  7 AL        175     300        3.02
##  8 AL        194     301        3.34
##  9 AL        194     301        3.34
## 10 AL        194     301        3.34
## # <U+2026> with 373 more rows
```

## dplyr: mutate()  
Mutate allows us to create a new variable from existing variables in our data frame. Let's convert the length variable from cm to inches and create a new variable called length_in.  

```r
fish %>% 
  mutate(length_in = length * 0.394) %>% 
  select(fish_id, length, length_in)
```

```
## # A tibble: 4,033 x 3
##    fish_id length length_in
##      <dbl>  <dbl>     <dbl>
##  1     299    167      65.8
##  2     299    167      65.8
##  3     299    167      65.8
##  4     300    175      69.0
##  5     300    175      69.0
##  6     300    175      69.0
##  7     300    175      69.0
##  8     301    194      76.4
##  9     301    194      76.4
## 10     301    194      76.4
## # <U+2026> with 4,023 more rows
```

Note that if we had called our new variable length, R would overwrite the old variable. 

## Practice
1. Use `mutate()` to calculate the half length of each fish: length_half = length/2. Select only fish_id, length, and length_half, use pipes.

```r
fish %>% 
  mutate(length_half = length/2) %>% 
  select(fish_id, length, length_half) %>% 
  arrange(desc(length_half))
```

```
## # A tibble: 4,033 x 3
##    fish_id length length_half
##      <dbl>  <dbl>       <dbl>
##  1     328    420         210
##  2     328    420         210
##  3     328    420         210
##  4     328    420         210
##  5     328    420         210
##  6     328    420         210
##  7     328    420         210
##  8     328    420         210
##  9     328    420         210
## 10     328    420         210
## # <U+2026> with 4,023 more rows
```

## That's it, let's take a break!   

-->[Home](https://jmledford3115.github.io/datascibiol/)
