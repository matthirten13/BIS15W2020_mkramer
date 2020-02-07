---
title: "Lab 1 Homework"
author: "Matt Kramer"
date: "Winter 2020"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code, keep track of your versions using git, and push your final work to our [GitHub repository](https://github.com/FRS417-DataScienceBiologists). I will randomly select a few examples of student work at the start of each session to use as examples so be sure that your code is working to the best of your ability.  

1. Navigate to the R console and calculate the following expressions.  
  + 5 - 3 * 2  
  + 8 / 2 ** 2  
  
2. Did any of the results in #1 surprise you? Write two programs that calculate each expression such that the result for the first example is 4 and the second example is 16.  

```r
sum(5-3)*2 #Example 1
```

```
## [1] 4
```

```r
prod(8/2)**2 #Example 2
```

```
## [1] 16
```

3. Make a new object `pi` as 3.14159265359.  

```r
pi <- 3.14159265359
```

4. Is `pi` an integer or numeric? Why? Show your code.  

```r
class(pi) #Returns numeric, so pi is numeric
```

```
## [1] "numeric"
```

5. You have decided to use your new analytical powers in R to become a professional gambler. Here are your winnings and losses this week. Note that you don't gamble on the weekends!  

```r
blackjack <- c(140, -20, 70, -120, 240, NA, NA)
roulette <- c(60, 50, 120, -300, 10, NA, NA)
```

a. Build a new vector called `days` for the days of the week. 

```r
days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
```


We will use `days` to name the elements in the poker and roulette vectors.

```r
names(blackjack) <- days
names(roulette) <- days
```

b. Calculate how much you won or lost in blackjack over the week.  

```r
sum(blackjack, na.rm = TRUE)
```

```
## [1] 310
```


c. What is your interpretation of this result? What do you need to do to address the problem? Recalculate how much you won or lost in blackjack over the week.  

```r
sum(blackjack, na.rm = TRUE) #My interpretation is that I won 310 in blackjack over the course of the week. I probably need to go less often as my gambling problem is pretty bad if I'm going 5x a week.
```

```
## [1] 310
```

d. Calculate how much you won or lost in roulette over the week.  

```r
sum(roulette, na.rm = TRUE)
```

```
## [1] -60
```


e. Build a `total_week` vector to show how much you lost or won on each day over the week. Which days seem lucky or unlucky for you?

```r
total_week <- blackjack + roulette
print(total_week)
```

```
##    Monday   Tuesday Wednesday  Thursday    Friday  Saturday    Sunday 
##       200        30       190      -420       250        NA        NA
```


f. Should you stick to blackjack or roulette? Write a program that verifies this below. 

```r
if(sum(blackjack, na.rm = TRUE)>sum(roulette, na.rm = TRUE)) print("Blackjack")  else print("Roulette") #stick to Blackjack
```

```
## [1] "Blackjack"
```

## Push your final code to [GitHub](https://github.com/FRS417-DataScienceBiologists)

