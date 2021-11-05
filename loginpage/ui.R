library(shinyjs)
library(shinyWidgets)
library(shinydashboard)
library(shiny)

dashboardPage(skin = "blue",
              dashboardHeader(disable = TRUE),
              dashboardSidebar(disable = TRUE),
              dashboardBody(
                shinyjs::useShinyjs(),
                #shinyjs::extendShinyjs(text = "shinyjs.refresh = function() { history.go(0); }", functions = c("refresh")),
                #shinyjs::extendShinyjs(text = "shinyjs.hidehead = function(parm){$('header').css('display', parm);", functions = c("hidehead")),
                includeHTML('/home/tingyi/桌面/ShinyUbuntu/Visualization/loginpage/login.html')
              )
              )