#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(vkR)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("vkR_user_id"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Function with user_id"),
      
      textInput("text", label = h3("Enter user-id"),
                value = "") 
    ),
    
    mainPanel(
      fluidRow(column(3, verbatimTextOutput("value"))),
      helpText("Results getGroups (count = 10):"),
      tableOutput("distgetGroups"),
      helpText("Results getFriends (count = 10):"),
      tableOutput("distgetFriends"),
      helpText("Results AgePredict:"),
      tableOutput("distAgePredict"),
      helpText("Results usersGetFollowers: disabled"),
      # tableOutput("distusersGetFollowers")
      helpText("Results usersGetSubscriptions (default arguments):"),
      tableOutput("distusersGetSubscriptions")
      
      
    )
  )
))