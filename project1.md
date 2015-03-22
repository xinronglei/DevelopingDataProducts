

Project for Developing Data Products
========================================================
author: xinrong
date: March 19,2015

**Outline of these document**: 
- Overview
- Fitting A Random Forest model
- Model Summary
- Prediction with Shiny

Overview
========================================================
This project uses jobclass,education,race and age (Data source: Wage in ISLR package) to predict wage.  
Highlight:  Jobs related to 'Information' dominate the top tier incomes.

![plot of chunk unnamed-chunk-1](project1-figure/unnamed-chunk-1-1.png) 


Fitting a boosted tree model 
========================================================

```r
fit1<-train(wage~jobclass+age+race+education,
            method="gbm",data=Wage,verbose=FALSE) 
summary(fit1$finalModel)
```

![plot of chunk unnamed-chunk-2](project1-figure/unnamed-chunk-2-1.png) 

```
                                                    var    rel.inf
education5. Advanced Degree education5. Advanced Degree 41.4530262
age                                                 age 27.5852468
education4. College Grad       education4. College Grad 16.9494157
education2. HS Grad                 education2. HS Grad  5.3904428
jobclass2. Information           jobclass2. Information  3.6773552
education3. Some College       education3. Some College  2.8938704
race2. Black                               race2. Black  1.1393616
race3. Asian                               race3. Asian  0.5953214
race4. Other                               race4. Other  0.3159600
```

Important factors
========================================================

```r
varImp(fit1$finalModel)
```

```
                               Overall
jobclass2. Information       181453.71
age                         1361153.62
race2. Black                  56220.13
race3. Asian                  29375.26
race4. Other                  15590.58
education2. HS Grad          265983.51
education3. Some College     142793.80
education4. College Grad     836344.11
education5. Advanced Degree 2045438.89
```


Prediction Application with Shiny 
========================================================

**link to shiny app**
http://xinrong.shinyapps.io/FirstShiny  


![alt text](shiny.jpg)

