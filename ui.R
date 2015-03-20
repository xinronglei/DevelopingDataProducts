library(shiny)
library(caret)
library(ggplot2)
library(ISLR)
library(gbm)
shinyUI(pageWithSidebar(
  headerPanel("Predicting wage using a simple model"),
  sidebarPanel(
    helpText("Select input value for the predictive variables"),
    
    selectInput('race', 'Race',selected = '1. White', choices=names(summary(Wage$race))),
    selectInput('jobclass', 'Job Class',selected = '2. Information', choices=names(summary(Wage$jobclass))),
    selectInput('education', 'Education',selected = '5. Advanced Degree', choices=names(summary(Wage$education))),
    helpText("Don't forget slide and pick up an age, it is also an input value"),
    
    sliderInput('age', 'Age',value = 30, min = 18, max = 100, step = 1,),
    submitButton('Submit')
    #jobclass<-'2. Information';race<-'1. White';education<-'5. Advanced Degree';age<-30
  ),
  mainPanel(    
    h3('Predicting income based on the following value: '), 
    
    helpText("This model is trained by Wage data in ISLR package in R,
              using Generalized Boosted Regression Model"),
    div("Note: The model takes awhile to initialize(15 seconds?). 
             Once it is done, you shall see a default output.
             Adjust the explainary varible and make your own prediction!", style = "color:blue"),
    verbatimTextOutput("orace"),
    verbatimTextOutput("oeducation"),
    verbatimTextOutput("ojobclass"),
    verbatimTextOutput("oage"),
        
    span(h3('This person shall make (in thousand dollars)'), style = "color:blue"),
    
    verbatimTextOutput("opred")
  )
))