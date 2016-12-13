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
  titlePanel("vkR_groups"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Function with group_id"),
      
      textInput("text1", label = h5("Enter domain, for example: privivkanet"),
                value = ""),
      textInput("text2", label = h5("Enter owner_id, for example:: -38532412"),
                value = "") 
    ),
    
    mainPanel(
      
      helpText("Active Users: "),
      tableOutput("Active_Users"),
      helpText("Population: "),
      tableOutput("population"),
      helpText("Clear Population: "),
      tableOutput("clear_population"),
      helpText("Members: "),
      tableOutput("members"),
      helpText("Share Active Members: "),
      tableOutput("share_active_members"),
      helpText("Connected Users: disabled"),
      # tableOutput("connected_users")
      helpText("Connected Users Share: disabled"),
      # tableOutput("connected_users_share")
      helpText("Isolates: disabled"),
      # tableOutput("isolates")
      helpText("Isolates Share: disabled"),
      # tableOutput("isolates_share")
      helpText("Edges: disabled"),
      # tableOutput("edges"),
      
      helpText("Connected Components: "),
      tableOutput("connected_components"),
      helpText("Vertex Giant Component: "),
      tableOutput("vertex_giant_component"),
      helpText("Density: disabled"),
      # tableOutput("density"),
      helpText("Modularity: "),
      tableOutput("modularity"),
      helpText("Clusters: "),
      tableOutput("clusters"),
      helpText("Diameter: "),
      tableOutput("diameter"),
      
      helpText("Femal Share: "),
      tableOutput("femal_share"),
      helpText("Writer Share: "),
      tableOutput("writer_share"),
      helpText("Liker Share: "),
      tableOutput("liker_share"),
      helpText("Passive Share: "),
      tableOutput("passive_share")
      
    )
  )
))