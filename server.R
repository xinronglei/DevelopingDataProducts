#setwd("C:/Users/xin/Dropbox/Courses/Developing Data Products")

library(shiny)
library(caret)
library(ggplot2)
library(ISLR)
library(gbm)

data(Wage) 
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


library(shiny)
shinyServer(
  function(input, output) {
    output$orace <- renderPrint({input$race})
    output$oeducation <- renderPrint({input$education})
    output$ojobclass <- renderPrint({input$jobclass})
    output$oage <- renderPrint({input$age})   
   
    output$opred <- renderPrint({pred(input$jobclass,input$race,input$education,input$age)})    
    
  }
)