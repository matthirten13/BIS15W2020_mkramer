---
title: "Data Visualization: `ggplot`"
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
1. Understand and apply the syntax of building plots using `ggplot2`.  
2. Build a boxplot using `ggplot2`.  
3. Build a scatterplot using `ggplot2`.  
4. Build a barplot using `ggplot2` and show the difference between `stat=count` and `stat=identity`.  

## Where have we been, and where are we going?
At this point you should feel comfortable working in RStudio and using dplyr and tidyr. You also know how to produce statistical summaries of data and deal with NA's. It is OK if you need to go back through the labs and find bits of code that work for you, but try and force yourself to originate new chunks.  

## Group Project
Meet with your group and decide on a data set that you will use for your project. Be prepared to discuss these data, where you found them, and what you hope to learn.  

##Resources
- [ggplot2 cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)

## Load the libraries

```r
library(tidyverse)
library(naniar)
```

## Grammar of Graphics
The ability to quickly produce and edit graphs and charts is a strength of R. These data visualizations are produced by the package `ggplot2` and it is a core part of the tidyverse. The syntax for using ggplot is specific and common to all of the plots. This is what Hadley Wickham calls a [Grammar of Graphics](http://vita.had.co.nz/papers/layered-grammar.pdf). The "gg" in `ggplot` stands for grammar of graphics.

## Philosophy
What makes a good chart? In my opinion a good chart is elegant in its simplicity. It provides a clean, clear visual of the data without being overwhelming to the reader. This can be hard to do and takes some careful thinking. Always keep in mind that the reader will almost never know the data as well as you do so you need to be mindful about presenting the facts.  

## Data Types
We first need to define some of the data types we will use to build plots.  

+ `discrete` quantitative data that only contains integers
+ `continuous` quantitative data that can take any numerical value
+ `categorical` qualitative data that can take on a limited number of values

## Basics
The syntax used by ggplot takes some practice to get used to, especially for customizing plots, but the basic elements are the same. It is helpful to think of plots as being built up in layers. In short, **plot= data + geom_ + aesthetics**.  

We start by calling the ggplot function, identifying the data, and specifying the axes. We then add the `geom` type to describe how we want our data represented. Each `geom_` works with specific types of data and R is capable of building plots of single variables, multiple variables, and even maps. Lastly, we add aesthetics.

ggplot works best with tidy data, so it is sometimes necessary to tidy data before plotting. We will start with tidy data for simplicity. 

## Example
To make things easy, let's start with some built in data.

```r
?iris
names(iris)
```

```
## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"
```

```r
glimpse(iris)
```

```
## Observations: 150
## Variables: 5
## $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9, 5.4, 4<U+2026>
## $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3<U+2026>
## $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5, 1.5, 1<U+2026>
## $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0<U+2026>
## $ Species      <fct> setosa, setosa, setosa, setosa, setosa, setosa, setosa, <U+2026>
```

To make a plot, we need to first specify the data and map the aesthetics. The aesthetics include how each variable in our dataset will be used. In the example below, I am using the aes() function to identify the x and y variables in the plot.

```r
ggplot(data = iris, mapping = aes(x = Species, y = Petal.Length))
```

![](lab5_2_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

Notice that we have a nice background, labeled axes, and even values of our variables- but no plot. This is because we need to tell ggplot how we want our data represented. This is called the geometry or `geom()`. There are many types of `geom`, see the ggplot [cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf).

Here we specify that we want a boxplot, indicated by `geom_boxplot()`.

```r
ggplot(data = iris, mapping = aes(x = Species, y = Petal.Length)) +
  geom_boxplot()
```

![](lab5_2_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

## Practice
1. Use the iris data to build a scatterplot that compares sepal length vs. sepal width. Use the cheatsheet or help to find the correct `geom_` for a scatterplot.

```r
ggplot(data = iris, aes(x = Species, y = Petal.Length)) +
  geom_violin()
```

![](lab5_2_files/figure-html/unnamed-chunk-5-1.png)<!-- -->


## Scatterplots, barplots, and boxplots
Now that we have a general idea of the syntax, let's start by working with two standard plots: 1) scatterplots and 2) barplots.

## Data
For the following examples, I am going to use data about vertebrate home range sizes.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  


```r
homerange <- 
  readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

## Practice
1. Does the homerange data have any NAs? Do a quick exploratory analysis of your choice below.

```r
homerange %>% 
  summarize(hr_nas = sum(is.na(homerange)))
```

```
## # A tibble: 1 x 1
##   hr_nas
##    <int>
## 1   2945
```


### 1. Scatter Plots
Scatter plots are good at revealing relationships that are not readily visible in the raw data. For now, we will not add regression lines or calculate any r^2^ values.  

In the case below, we are exploring whether or not there is a relationship between animal mass and homerange. We are using the log transformed values because there is a large difference in mass and homerange among the different species in the data.

```r
ggplot(data = homerange, mapping = aes(x = log10.mass, y = log10.hra)) +
  geom_point()
```

![](lab5_2_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

In big data sets with lots of similar values, overplotting can be an issue. `geom_jitter()` is similar to `geom_point()` but it helps with overplotting by adding some random noise to the data and separating some of the individual points.

```r
ggplot(data = homerange, mapping = aes(x = log10.mass, y = log10.hra)) +
  geom_jitter()
```

![](lab5_2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

You want to see the regression line, right?

```r
ggplot(data=homerange, mapping=aes(x=log10.mass, y=log10.hra)) +
  geom_jitter()+
  geom_smooth(method=lm, se=F) #adds the regression line, `se=TRUE` will add standard error
```

![](lab5_2_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

### Practice
1. What is the relationship between log10.hra and log10.preymass? What do you notice about how ggplot treats NAs?

```r
ggplot(data=homerange, mapping=aes(x=log10.hra, y=log10.preymass)) +
  geom_point(na.rm=T)+
  geom_smooth(method=lm, se=T, na.rm=T)
```

![](lab5_2_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

```r
ggplot(data=homerange, mapping=aes(x=taxon, y=log10.preymass))+
  geom_point(na.rm=T)
```

![](lab5_2_files/figure-html/unnamed-chunk-12-1.png)<!-- -->


### 2A. Bar Plot: `stat="count"`
When making a bar graph, the default is to count the number of observations in the specified column. This is best for categorical data. Here, I want to know how many carnivores vs. herbivores are in the data.  

Notice that we can use pipes! Also, the `mapping=` function is implied by `aes` and so is often left out.  

```r
homerange %>% 
  ggplot(aes(x = trophic.guild))+
  geom_bar(stat = "count")
```

![](lab5_2_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

### 2B. Bar Plot: `stat="identity"`
`stat="identity"` allows us to map a variable to the y axis so that we aren't restricted to counts. In this example, I start by summarizing mean body weight by taxonomic class and then use pipes to build the plot.

```r
homerange %>%
  group_by(class) %>% 
  summarize(mean_body_wt = mean(log10.mass)) %>% 
  ggplot(aes(x = class, y = mean_body_wt))+
  geom_bar(stat = "identity")
```

![](lab5_2_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

## Practice
1. Filter the `homerange` data to include `mammals` only.

```r
hr_mammal <- homerange %>% 
  filter(class == "mammalia")
```


2. Are there more herbivores or carnivores in mammals? Make a bar plot that shows their relative numbers.

```r
hr_mammal %>% 
  ggplot(aes(x=trophic.guild))+
  geom_bar(stat = "count")
```

![](lab5_2_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


3. Make a bar plot that shows the masses of the top 10 smallest mammals in terms of mass. Be sure to use `stat'="identity"`.

```r
hr_mammal %>% 
  top_n(-10, mean.mass.g) %>% 
  ggplot(aes(x=common.name, y=mean.mass.g))+
  geom_bar(stat="identity")+
  coord_flip()
```

![](lab5_2_files/figure-html/unnamed-chunk-17-1.png)<!-- -->


## That's it, let's take a break!   

-->[Home](https://jmledford3115.github.io/datascibiol/)
