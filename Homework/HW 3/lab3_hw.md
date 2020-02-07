---
title: "Lab 3 Homework"
author: "Matt Kramer"
date: "Winter 2020"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run.  

## Load the tidyverse

```r
library(tidyverse)
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

1. Load the data into a new object called `homerange`.  

```r
homerange <-
  readr::read_csv("data/Tamburelloetal_HomerangeDatabase.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
```

```
## See spec(...) for full column specifications.
```

2. Use `spec()` to see the full details of the columns.  

```r
spec(homerange)
```

```
## cols(
##   taxon = col_character(),
##   common.name = col_character(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   primarymethod = col_character(),
##   N = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   alternative.mass.reference = col_character(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   hra.reference = col_character(),
##   realm = col_character(),
##   thermoregulation = col_character(),
##   locomotion = col_character(),
##   trophic.guild = col_character(),
##   dimension = col_character(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double(),
##   prey.size.reference = col_character()
## )
```

3. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.  

```r
dim(homerange)
```

```
## [1] 569  24
```

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

```r
str(homerange)
```

```
## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame':	569 obs. of  24 variables:
##  $ taxon                     : chr  "lake fishes" "river fishes" "river fishes" "river fishes" ...
##  $ common.name               : chr  "american eel" "blacktail redhorse" "central stoneroller" "rosyside dace" ...
##  $ class                     : chr  "actinopterygii" "actinopterygii" "actinopterygii" "actinopterygii" ...
##  $ order                     : chr  "anguilliformes" "cypriniformes" "cypriniformes" "cypriniformes" ...
##  $ family                    : chr  "anguillidae" "catostomidae" "cyprinidae" "cyprinidae" ...
##  $ genus                     : chr  "anguilla" "moxostoma" "campostoma" "clinostomus" ...
##  $ species                   : chr  "rostrata" "poecilura" "anomalum" "funduloides" ...
##  $ primarymethod             : chr  "telemetry" "mark-recapture" "mark-recapture" "mark-recapture" ...
##  $ N                         : chr  "16" NA "20" "26" ...
##  $ mean.mass.g               : num  887 562 34 4 4 ...
##  $ log10.mass                : num  2.948 2.75 1.531 0.602 0.602 ...
##  $ alternative.mass.reference: chr  NA NA NA NA ...
##  $ mean.hra.m2               : num  282750 282.1 116.1 125.5 87.1 ...
##  $ log10.hra                 : num  5.45 2.45 2.06 2.1 1.94 ...
##  $ hra.reference             : chr  "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ ...
##  $ realm                     : chr  "aquatic" "aquatic" "aquatic" "aquatic" ...
##  $ thermoregulation          : chr  "ectotherm" "ectotherm" "ectotherm" "ectotherm" ...
##  $ locomotion                : chr  "swimming" "swimming" "swimming" "swimming" ...
##  $ trophic.guild             : chr  "carnivore" "carnivore" "carnivore" "carnivore" ...
##  $ dimension                 : chr  "3D" "2D" "2D" "2D" ...
##  $ preymass                  : num  NA NA NA NA NA NA 1.39 NA NA NA ...
##  $ log10.preymass            : num  NA NA NA NA NA ...
##  $ PPMR                      : num  NA NA NA NA NA NA 530 NA NA NA ...
##  $ prey.size.reference       : chr  NA NA NA NA ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   taxon = col_character(),
##   ..   common.name = col_character(),
##   ..   class = col_character(),
##   ..   order = col_character(),
##   ..   family = col_character(),
##   ..   genus = col_character(),
##   ..   species = col_character(),
##   ..   primarymethod = col_character(),
##   ..   N = col_character(),
##   ..   mean.mass.g = col_double(),
##   ..   log10.mass = col_double(),
##   ..   alternative.mass.reference = col_character(),
##   ..   mean.hra.m2 = col_double(),
##   ..   log10.hra = col_double(),
##   ..   hra.reference = col_character(),
##   ..   realm = col_character(),
##   ..   thermoregulation = col_character(),
##   ..   locomotion = col_character(),
##   ..   trophic.guild = col_character(),
##   ..   dimension = col_character(),
##   ..   preymass = col_double(),
##   ..   log10.preymass = col_double(),
##   ..   PPMR = col_double(),
##   ..   prey.size.reference = col_character()
##   .. )
```

```r
summary(homerange)
```

```
##     taxon           common.name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean.mass.g        log10.mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative.mass.reference  mean.hra.m2          log10.hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass         log10.preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       PPMR         prey.size.reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```


4. Are there NA's in your data? Show the code that you would use to verify this, please.  

```r
anyNA(homerange)
```

```
## [1] TRUE
```

5. Change the class of the variables `taxon` and `order` to factors and display their levels.  

```r
homerange$taxon <- as.factor(homerange$taxon)
levels(homerange$taxon)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```

```r
homerange$order <- as.factor(homerange$order)
levels(homerange$order)
```

```
##  [1] "accipitriformes"         "afrosoricida"           
##  [3] "anguilliformes"          "anseriformes"           
##  [5] "apterygiformes"          "artiodactyla"           
##  [7] "caprimulgiformes"        "carnivora"              
##  [9] "charadriiformes"         "columbidormes"          
## [11] "columbiformes"           "coraciiformes"          
## [13] "cuculiformes"            "cypriniformes"          
## [15] "dasyuromorpha"           "dasyuromorpia"          
## [17] "didelphimorphia"         "diprodontia"            
## [19] "diprotodontia"           "erinaceomorpha"         
## [21] "esociformes"             "falconiformes"          
## [23] "gadiformes"              "galliformes"            
## [25] "gruiformes"              "lagomorpha"             
## [27] "macroscelidea"           "monotrematae"           
## [29] "passeriformes"           "pelecaniformes"         
## [31] "peramelemorphia"         "perciformes"            
## [33] "perissodactyla"          "piciformes"             
## [35] "pilosa"                  "proboscidea"            
## [37] "psittaciformes"          "rheiformes"             
## [39] "roden"                   "rodentia"               
## [41] "salmoniformes"           "scorpaeniformes"        
## [43] "siluriformes"            "soricomorpha"           
## [45] "squamata"                "strigiformes"           
## [47] "struthioniformes"        "syngnathiformes"        
## [49] "testudines"              "tetraodontiformes<U+00A0>"
## [51] "tinamiformes"
```

6. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer?  

```r
select(homerange, mean.mass.g, log10.mass, family, genus, species) %>% 
  filter(family == "cervidae") %>% 
  arrange(desc(log10.mass))
```

```
## # A tibble: 12 x 5
##    mean.mass.g log10.mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2     234758.       5.37 cervidae cervus     elaphus    
##  3     102059.       5.01 cervidae rangifer   tarandus   
##  4      87884.       4.94 cervidae odocoileus virginianus
##  5      71450.       4.85 cervidae dama       dama       
##  6      62823.       4.80 cervidae axis       axis       
##  7      53864.       4.73 cervidae odocoileus hemionus   
##  8      35000.       4.54 cervidae ozotoceros bezoarticus
##  9      29450.       4.47 cervidae cervus     nippon     
## 10      24050.       4.38 cervidae capreolus  capreolus  
## 11      13500.       4.13 cervidae muntiacus  reevesi    
## 12       7500.       3.88 cervidae pudu       puda
```

7. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!  

```r
filter(homerange, taxon == "snakes") %>% 
  arrange(desc(mean.hra.m2)) #Timber rattlensakes are found across the Eastern half of the US. They mostly feed on small mammals
```

```
## # A tibble: 41 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 snak<U+2026> timber rat<U+2026> rept<U+2026> squa<U+2026> viper<U+2026> crot<U+2026> horrid<U+2026> telemetry     6    
##  2 snak<U+2026> eastern in<U+2026> rept<U+2026> squa<U+2026> colub<U+2026> drym<U+2026> couperi telemetry     1    
##  3 snak<U+2026> midget fad<U+2026> rept<U+2026> squa<U+2026> viper<U+2026> crot<U+2026> oregan<U+2026> telemetry     21   
##  4 snak<U+2026> pine snake  rept<U+2026> squa<U+2026> colub<U+2026> pitu<U+2026> melano<U+2026> telemetry     12   
##  5 snak<U+2026> hognose sn<U+2026> rept<U+2026> squa<U+2026> colub<U+2026> hete<U+2026> platir<U+2026> telemetry     8    
##  6 snak<U+2026> Eastern ki<U+2026> rept<U+2026> squa<U+2026> colub<U+2026> lamp<U+2026> getula<U+2026> telemetry     12   
##  7 snak<U+2026> coachwhip   rept<U+2026> squa<U+2026> colub<U+2026> mast<U+2026> flagel<U+2026> telemetry     4    
##  8 snak<U+2026> giant gart<U+2026> rept<U+2026> squa<U+2026> colub<U+2026> tham<U+2026> gigal   telemetry     11   
##  9 snak<U+2026> Mojave rat<U+2026> rept<U+2026> squa<U+2026> viper<U+2026> crot<U+2026> scutul<U+2026> telemetry     19   
## 10 snak<U+2026> Armenian v<U+2026> rept<U+2026> squa<U+2026> viper<U+2026> mont<U+2026> raddei  telemetry     14   
## # <U+2026> with 31 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```


8. You suspect that homerange and mass are correlated in birds. We need a ratio that facilitates exploration of this prediction. First, build a new dataframe called `hra_ratio` that is limited to genus, species, mean.mass.g, log10.mass, log10.hra. Arrange it in ascending order by mean mass in grams.  

```r
hra_ratio <- filter(homerange, taxon == "birds") %>% 
  select(genus, species, mean.mass.g, log10.mass, log10.hra) %>% 
  arrange(mean.mass.g)
```


9. Replace the existing `hra_ratio` dataframe with a new dataframe that adds a column calculating the ratio of log 10 hra to log 10 mass. Call it `hra.mass.ratio`. Arrange it in descending order by mean mass in grams.  

```r
hra.mass.ratio <- hra_ratio$log10.hra/hra_ratio$log10.mass
hra_ratio <- cbind(hra_ratio, hra.mass.ratio)
hra_ratio %>% 
  arrange(desc(hra.mass.ratio))
```

```
##                  genus         species mean.mass.g log10.mass log10.hra
## 1              regulus         regulus        5.15  0.7118072  4.298853
## 2              regulus    ignicapillus        5.30  0.7242759  4.217484
## 3         phylloscopus         bonelli        7.50  0.8750613  4.544068
## 4           aegithalos        caudatus        8.00  0.9030900  4.623249
## 5              certhia      familiaris        8.77  0.9429996  4.672098
## 6                vireo    atricapillus        8.50  0.9294189  4.175319
## 7            motacilla            alba       21.22  1.3267454  5.894870
## 8            hippolais      polyglotta       11.00  1.0413927  4.477121
## 9            cisticola        juncidis        9.80  0.9912261  4.158362
## 10               parus       palustris       11.00  1.0413927  4.355305
## 11               parus    carolinensis       10.10  1.0043214  4.175319
## 12            wilsonia      canadensis        9.30  0.9684829  4.005057
## 13           setophaga        magnolia        8.60  0.9344985  3.862390
## 14            spizella       passerina       12.20  1.0863598  4.487931
## 15         troglodytes     troglodytes        9.50  0.9777236  4.005057
## 16            contopus          virens       13.80  1.1398791  4.643746
## 17               vireo           belli       10.00  1.0000000  4.069515
## 18               parus    atricapillus       11.00  1.0413927  4.163420
## 19           setophaga          virens        9.00  0.9542425  3.811237
## 20           setophaga       kirtlandi       14.00  1.1461280  4.531396
## 21               upupa           epops       67.00  1.8260748  7.098990
## 22             serinus         serinus       10.70  1.0293838  4.000000
## 23           empidonax        wrightii       12.30  1.0899051  4.198182
## 24           setophaga    pensylvanica        9.60  0.9822712  3.783209
## 25                jynx       torquilla       38.00  1.5797836  6.016239
## 26           setophaga           fusca        9.70  0.9867717  3.721061
## 27          geothylpis         trichas        9.80  0.9912261  3.721061
## 28  geothlypis<U+00A0>    philadelphia       11.30  1.0530784  3.885871
## 29              sylvia          undata        8.80  0.9444827  3.447158
## 30        streptopelia          turtur      140.33  2.1471505  7.803355
## 31           muscicapa         striata       12.80  1.1072100  4.000000
## 32             cuculus         canorus      128.00  2.1072100  7.585009
## 33               parus       inornatus       16.60  1.2201081  4.385268
## 34          thryomanes        bewickiI       11.00  1.0413927  3.686298
## 35              lanius           minor       44.22  1.6456187  5.803321
## 36         caprimulgus       europaeus       48.00  1.6812412  5.894870
## 37        protonotaria          citrea       16.10  1.2068259  4.175319
## 38           setophaga       ruticilla        9.00  0.9542425  3.288359
## 39              sylvia           sarda       10.50  1.0211893  3.518514
## 40         troglodytes           aedon       11.20  1.0492180  3.607117
## 41               sitta        europaea       18.30  1.2624511  4.322219
## 42          glaucidium      passerinum       61.32  1.7876021  6.096910
## 43           fringilla         coelebs       23.25  1.3664230  4.623249
## 44            spizella         arborea       18.10  1.2576786  4.230366
## 45             lululla         arborea       30.00  1.4771213  4.918871
## 46              circus        pygargus      315.50  2.4989994  8.303153
## 47           setophaga        petechia        9.50  0.9777236  3.230367
## 48          ammodramus      savannarum       16.70  1.2227165  4.038481
## 49            picoides        leucotos      109.25  2.0384214  6.724816
## 50           empidonax         minimus        9.90  0.9956352  3.250569
## 51            clamator      glandarius      151.50  2.1804126  7.098990
## 52           motacilla           flava       17.50  1.2430380  4.005057
## 53               picus           canus      124.50  2.0951694  6.655292
## 54              lanius         senator       35.00  1.5440680  4.903090
## 55            saxicola         rubetra       16.48  1.2169572  3.863323
## 56             seiurus    aurocapillus       18.90  1.2764618  4.005057
## 57            aegolius        funereus      119.00  2.0755470  6.496930
## 58               vireo       olivaceus       17.60  1.2455127  3.862390
## 59               habia          rubica       32.80  1.5158738  4.686298
## 60         phoenicurus     phoenicurus       15.21  1.1821292  3.653213
## 61            tyrannus        tyrannus       40.40  1.6063814  4.923087
## 62            picoides     tridactylus       65.65  1.8172347  5.544068
## 63                asio            otus      252.00  2.4014005  7.292699
## 64               habia      fuscicauda       37.70  1.5763414  4.783208
## 65               falco      sparverius      112.00  2.0492180  6.151185
## 66             chamaea        fasciata       14.80  1.1702617  3.510207
## 67            oenanthe        oenanthe       25.20  1.4014005  4.186901
## 68            coracias        garrulus      103.00  2.0128372  6.000000
## 69               vireo         griseus       11.40  1.0569049  3.125631
## 70             columba        palumbus      150.00  2.1760913  6.404834
## 71            picoides          medius       59.00  1.7708520  5.150756
## 72             laniuis    ludovicianus       48.10  1.6821451  4.878959
## 73             laniuis        collurio       30.00  1.4771213  4.198182
## 74               falco      peregrinus      781.50  2.8929290  8.187126
## 75               falco     tinnunculus      200.00  2.3010300  6.477121
## 76           accipiter        striatus      141.00  2.1492191  5.998052
## 77           phytotoma       raimondii       42.00  1.6232493  4.489958
## 78               picus         viridis      186.67  2.2710745  6.267172
## 79            caracara        cheriway     1125.00  3.0511525  8.382017
## 80          ixobrychus          exilis       67.00  1.8260748  4.986772
## 81               falco       biarmicus      675.00  2.8293038  7.698970
## 82          hieraaetus        pennatus      975.00  2.9890046  8.069298
## 83              sialia          sialis       30.80  1.4885507  4.005057
## 84                anas        strepera      719.00  2.8567289  7.661926
## 85           dryocopus         martius      277.37  2.4430595  6.544068
## 86              pipilo          fuscus       44.70  1.6503075  4.413297
## 87               buteo           buteo      846.00  2.9273704  7.701050
## 88           passerina          cyanea       14.30  1.1553360  3.022090
## 89              athene          noctua      156.50  2.1945143  5.698970
## 90               falco       mexicanus      721.00  2.8579353  7.411257
## 91           accipiter        gentilis      978.00  2.9903389  7.602060
## 92              pipilo          aberti       46.30  1.6655810  4.209177
## 93                tyto            alba      285.00  2.4548449  6.176091
## 94           circaetus        gallicus     1699.00  3.2301934  7.894870
## 95         thryothorus    ludovicianus       18.50  1.2671717  3.084240
## 96           nucifraga   caryocatactes      130.00  2.1139434  5.121665
## 97              milvus          milvus     1033.70  3.0143945  7.292810
## 98         typmanuchus cupido pinnatus      900.00  2.9542425  7.080266
## 99           accipiter        cooperii      469.00  2.6711728  6.352972
## 100             corvus           corax     1410.00  3.1492191  7.447158
## 101          accipiter           nisus      807.00  2.9068735  6.851258
## 102             circus         cyaneus      521.00  2.7168377  6.401605
## 103         haematopus      ostralegus      521.00  2.7168377  6.390935
## 104           neophron    percnopterus     2203.00  3.3430145  7.803252
## 105          geococcyx   californianus      300.00  2.4771213  5.740363
## 106          sturnella           magna       89.00  1.9493900  4.482178
## 107          sturnella        neglecta       89.00  1.9493900  4.482178
## 108       scenopoeetes    dentirostris      158.00  2.1986571  4.977724
## 109       centrocercus    urophasianus     1750.00  3.2430380  7.259073
## 110         hieraaetus       fasciatus     2049.00  3.3115420  7.292699
## 111            icteria          virens       27.00  1.4313638  3.125631
## 112              buteo     jamaicensis     1126.00  3.0515384  6.628306
## 113        neopmorphus      radiolosus      433.00  2.6364879  5.698101
## 114               bubo            bubo     2191.00  3.3406424  7.204120
## 115             aquila      chrysaetos     3000.00  3.4771213  7.440122
## 116              buteo       swainsoni      971.00  2.9872192  6.391734
## 117              mimus     polyglottos       50.10  1.6998377  3.607117
## 118               crex            crex      165.00  2.2174839  4.633468
## 119           daptrius      americanus      625.00  2.7958800  5.823474
## 120              buteo        lineatus      626.00  2.7965743  5.805774
## 121             tetrao          tetrix     1139.00  3.0565237  6.295567
## 122              strix           aluco      519.00  2.7151674  5.552586
## 123             nyctea       scandiaca     1920.00  3.2833012  6.693477
## 124          carduelis       cannabina     1550.00  3.1903317  6.496930
## 125        scardafella            inca       47.70  1.6785184  3.413296
## 126               bubo     virginianus     1510.00  3.1789769  6.327276
## 127             tetrao       urogallus     2936.00  3.4677561  6.740363
## 128             bonasa         bonasia      410.00  2.6127839  5.012837
## 129             rallus         elegans      266.00  2.4248816  4.643453
## 130             perdix          perdix      381.50  2.5814945  4.792392
## 131           aramides           wolfi      506.00  2.7041505  4.954243
## 132           botaurus       stellaris      900.00  2.9542425  5.285557
## 133               rhea         pennata    15000.00  4.1760913  7.378034
## 134            apteryx       australis     2320.00  3.3654880  5.666424
## 135           strigops     habroptilus     1941.00  3.2880255  5.290035
## 136           struthio         camelus    88250.00  4.9457147  7.925828
## 137            lagopus         lagopus      620.00  2.7923917  4.413297
## 138        nothoprocta          ornata      622.00  2.7937904  4.385268
## 139               rhea       americana    25000.00  4.3979400  6.389166
## 140        dendragapus        obscurus     1050.00  3.0211893  4.230366
##     hra.mass.ratio
## 1         6.039350
## 2         5.823035
## 3         5.192857
## 4         5.119367
## 5         4.954507
## 6         4.492397
## 7         4.443105
## 8         4.299167
## 9         4.195171
## 10        4.182193
## 11        4.157353
## 12        4.135393
## 13        4.133115
## 14        4.131164
## 15        4.096308
## 16        4.073894
## 17        4.069515
## 18        3.997934
## 19        3.993992
## 20        3.953656
## 21        3.887568
## 22        3.885820
## 23        3.851878
## 24        3.851491
## 25        3.808268
## 26        3.770944
## 27        3.753998
## 28        3.690011
## 29        3.649784
## 30        3.634284
## 31        3.612684
## 32        3.599551
## 33        3.594164
## 34        3.539777
## 35        3.526528
## 36        3.506260
## 37        3.459753
## 38        3.446041
## 39        3.445506
## 40        3.437910
## 41        3.423673
## 42        3.410664
## 43        3.383469
## 44        3.363631
## 45        3.330039
## 46        3.322591
## 47        3.303968
## 48        3.302876
## 49        3.299031
## 50        3.264819
## 51        3.255801
## 52        3.221991
## 53        3.176494
## 54        3.175436
## 55        3.174576
## 56        3.137624
## 57        3.130225
## 58        3.101044
## 59        3.091483
## 60        3.090366
## 61        3.064707
## 62        3.050827
## 63        3.036852
## 64        3.034373
## 65        3.001723
## 66        2.999506
## 67        2.987655
## 68        2.980867
## 69        2.957344
## 70        2.943274
## 71        2.908632
## 72        2.900439
## 73        2.842138
## 74        2.830047
## 75        2.814879
## 76        2.790805
## 77        2.766031
## 78        2.759562
## 79        2.747164
## 80        2.730869
## 81        2.721154
## 82        2.699661
## 83        2.690575
## 84        2.682063
## 85        2.678636
## 86        2.674227
## 87        2.630706
## 88        2.615767
## 89        2.596916
## 90        2.593221
## 91        2.542207
## 92        2.527152
## 93        2.515878
## 94        2.444086
## 95        2.433956
## 96        2.422801
## 97        2.419328
## 98        2.396643
## 99        2.378346
## 100       2.364763
## 101       2.356917
## 102       2.356271
## 103       2.352343
## 104       2.334196
## 105       2.317352
## 106       2.299272
## 107       2.299272
## 108       2.263984
## 109       2.238356
## 110       2.202206
## 111       2.183673
## 112       2.172120
## 113       2.161247
## 114       2.156507
## 115       2.139736
## 116       2.139694
## 117       2.122036
## 118       2.089516
## 119       2.082877
## 120       2.076031
## 121       2.059715
## 122       2.045025
## 123       2.038642
## 124       2.036443
## 125       2.033517
## 126       1.990350
## 127       1.943725
## 128       1.918581
## 129       1.914919
## 130       1.856441
## 131       1.832088
## 132       1.789141
## 133       1.766732
## 134       1.683686
## 135       1.608879
## 136       1.602565
## 137       1.580472
## 138       1.569648
## 139       1.452763
## 140       1.400232
```


10. What is the lowest mass for birds with a `hra.mass.ratio` greater than or equal to 4.0?

```r
hra_ratio %>% 
  filter(hra.mass.ratio >= 4.0) %>% 
  arrange(mean.mass.g)
```

```
##           genus      species mean.mass.g log10.mass log10.hra hra.mass.ratio
## 1       regulus      regulus        5.15  0.7118072  4.298853       6.039350
## 2       regulus ignicapillus        5.30  0.7242759  4.217484       5.823035
## 3  phylloscopus      bonelli        7.50  0.8750613  4.544068       5.192857
## 4    aegithalos     caudatus        8.00  0.9030900  4.623249       5.119367
## 5         vireo atricapillus        8.50  0.9294189  4.175319       4.492397
## 6     setophaga     magnolia        8.60  0.9344985  3.862390       4.133115
## 7       certhia   familiaris        8.77  0.9429996  4.672098       4.954507
## 8      wilsonia   canadensis        9.30  0.9684829  4.005057       4.135393
## 9   troglodytes  troglodytes        9.50  0.9777236  4.005057       4.096308
## 10    cisticola     juncidis        9.80  0.9912261  4.158362       4.195171
## 11        vireo        belli       10.00  1.0000000  4.069515       4.069515
## 12        parus carolinensis       10.10  1.0043214  4.175319       4.157353
## 13    hippolais   polyglotta       11.00  1.0413927  4.477121       4.299167
## 14        parus    palustris       11.00  1.0413927  4.355305       4.182193
## 15     spizella    passerina       12.20  1.0863598  4.487931       4.131164
## 16     contopus       virens       13.80  1.1398791  4.643746       4.073894
## 17    motacilla         alba       21.22  1.3267454  5.894870       4.443105
```


11. Do a search online; what is the common name of the bird from #8 above? Place a link in your markdown file that takes us to a webpage with information on its biology.  

[Canada Warbler]{https://en.wikipedia.org/wiki/Canada_warbler}


12. What is the `hra.mass.ratio` for an ostrich? Show your work, please.  

```r
hra_ratio %>% 
  filter(genus == "struthio", species == "camelus") %>% 
  select(hra.mass.ratio)
```

```
##   hra.mass.ratio
## 1       1.602565
```

## Push your final code to GitHub!
Please be sure that you have check the `keep md` file in the knit preferences.  
