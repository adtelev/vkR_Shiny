#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(vkR)
value = 0

# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
    
    output$value <- renderPrint({ input$text })
    
    output$distgetGroups <- renderTable({
      getGroups(user_id = input$text, count = "10")
    })
    
    output$distgetFriends <- renderTable({
      getFriends(user_id = input$text, count = "10")
    })
    
    output$distusersGetFollowers <- renderTable({
      usersGetFollowers(user_id = input$text, progress_bar = TRUE)
    })
    
    output$distusersGetSubscriptions <- renderTable({
      usersGetSubscriptions(user_id = input$text, progress_bar = TRUE)
    })
    
    output$distAgePredict <- renderTable({
    age_predict(user_id = input$text)
    })
    
    
  }
)
