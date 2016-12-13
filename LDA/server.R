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
library(igraph)
# source("LDA.R")
options(shiny.maxRequestSize=100*1024^2)

# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
    
    output$value <- renderTable({
      if(is.null(input$file))     return(NULL)
      inFile <<- input$file
      # read.csv(inFile$datapath)
      docs_list <- readLines(inFile$datapath)
      
      doc_list <<- clear_text(docs_list, patterns = list("[|]\\w+"))
      doc_list <<- strsplit(doc_list, "[[:space:]]+")
      head(doc_list)
      
      term.table <<- table(unlist(doc_list))
      term.table <<- sort(term.table, decreasing = TRUE)
      head(term.table, 10)
      
    })
    
    output$delete_stop_words <- renderTable({
      # if(is.null(input$file2))     return(NULL)
      if(is.null(input$file))     return(NULL)
      paste("You have selected", input$file)
      
      # inFile_stop_words <<- input$file2
      # test_stop_words <- readLines(inFile_stop_words$datapath)
      # stop_words <- get_stop_words(c(test_stop_words))
      
      stop_words <- get_stop_words(c("вообще", "например", "вроде", "наверное", "думаю", "давай",
                                     "етот", "поэтому", "кстати", "вакцина", "прививка", "большой",
                                     "свой", "вакцинация", "|", "делать", "говорить", "думать",
                                     "писать", "=", "знать", "читать", "самый", "хороший", "ничто", "никто",
                                     "группа", "написать", "ребенок"))
      del <- names(term.table) %in% stop_words | term.table < 5
      term.table <<- term.table[!del]
      vocab <<- names(term.table)
      head(vocab)
      
    })
    
    
    output$modelling <- renderPlot({
      if(is.null(input$file))     return(NULL)
      paste("You have selected", input$slider1)
      paste("You have selected", input$file)
      get.terms <- function(x) {
        index <<- match(x, vocab)
        index <<- index[!is.na(index)]
        rbind(as.integer(index - 1), as.integer(rep(1, length(index))))
      }
      documents <<- lapply(doc_list, get.terms)
      K <<- input$slider1
      G <- 1000 
      alpha <- 0.02 
      eta <- 0.02 
      
      D <- length(documents)
      W <<- length(vocab)
      doc.length <- sapply(documents, function(x) sum(x[2, ]))
      N <- sum(doc.length)
      term.frequency <- as.integer(term.table)
      
      fit <- lda.collapsed.gibbs.sampler(documents = documents, K = K, vocab = vocab, 
                                         num.iterations = G, alpha = alpha, 
                                         eta = eta, initial = NULL, burnin = 0,
                                         compute.log.likelihood = TRUE)
      
      theta <- t(apply(fit$document_sums + alpha, 2, function(x) x/sum(x)))
      phi <- t(apply(t(fit$topics) + eta, 2, function(x) x/sum(x)))
      
      results <- list(phi = phi,
                      theta = theta,
                      doc.length = doc.length,
                      vocab = vocab,
                      term.frequency = term.frequency)
      
      
      json <- createJSON(phi = results$phi, 
                         theta = results$theta, 
                         doc.length = results$doc.length, 
                         vocab = results$vocab, 
                         term.frequency = results$term.frequency)
      
      serVis(json, out.dir = './', open.browser = TRUE)
      
    })
    
    # output$action_value <- renderText({
    #   if(is.null(input$action))     return(NULL)
    #   button_value <- input$action
    #   rm(list=ls())
    # })
    
  }
)