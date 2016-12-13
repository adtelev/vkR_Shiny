# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


# Define UI for application that draws a histogram
library(shiny)
library(vkR)
library(lda)
library(LDAvis)
library(stringr)
library(tm)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("vkR_LDA"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider1", label = h3("Enter number of topics"),  min = 5, 
                  max = 10, value = 5),
      fileInput("file", label = h3("File input"))
      # fileInput("file2", label = h3("File stop-words input"))
      # actionButton("action", label = "Action")
    ),
    
    mainPanel(
      helpText("Forming table of frequency:"),
      tableOutput("value"),
      helpText("Deleting stop-words:"),
      tableOutput("delete_stop_words"),
      plotOutput("modelling")
      # textOutput("action_value")
      
    )
  )
))