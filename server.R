#setwd("C:/Users/xin/Dropbox/Courses/Developing Data Products")

library(shiny)
library(caret)
library(ggplot2)
library(ISLR)
library(gbm)
library(rCharts)
library(sqldf)
library(googleVis)

data(Wage) 

W2<-sqldf("select distinct avg(wage) as wage,race, jobclass,education,year from Wage group by year,jobclass,education,race")
#for prediction function
fit1<-train(wage~jobclass+age+race+education,
            method="gbm",data=Wage,verbose=FALSE) 

pred<-function(jobclass,race,education,age){
  #set default
  newdt<-data.frame(jobclass='2. Information',race="1. White",education='5. Advanced Degree',age=45)
  newdt$jobclass<-jobclass
  newdt$race<-race
  newdt$education<-education
  newdt$age<-as.numeric(age)

  predict(fit1,newdata=newdt)
}



shinyServer(
  function(input, output) {
    output$orace <- renderPrint({input$race})
    output$oeducation <- renderPrint({input$education})
    output$ojobclass <- renderPrint({input$jobclass})
    output$oage <- renderPrint({input$age})   
   
    output$opred <- renderPrint({pred(input$jobclass,input$race,input$education,input$age)})    
    
    output$plotwage <- renderChart({
      n1<-rPlot(wage~year|jobclass,data=W2[W2$race==input$race,],color='education',type='point')
      n1$set(title="Wage by year in the training set" ,dom='plotwage')
      return(n1)
    })
    #this table only show on html browser, won't show in runapp in R
    output$myTable <- renderGvis({
      t1<-gvisTable(W2[W2$race==input$race,], options=list(page='enable', height=300),chartid='myTable')
      return(t1)
    })
    
  }
)