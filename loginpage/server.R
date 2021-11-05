library(shinyjs)
library(shinyWidgets)
library(shinydashboard)
library(shiny)

shinyServer(function(input, output) {
  USER <- reactiveValues(login = FALSE)
  observeEvent(input$login, {
    js$hidehead('')
    shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
  })
})