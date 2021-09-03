library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)

data("airquality")
data("diamonds")
data("iris")
data("midwest")
data("mpg")
data("mtcars")

dataPractice <- airquality

dashboardPage(skin = "green",
              
              dashboardHeader(
                title = "Data Visualization"
              ),
              
              dashboardSidebar(
                sidebarMenu(
                  menuItem("Textbook", tabName = "Textbook", icon = icon("book")),
                  menuItem("Data Set", tabName = "Data", icon = icon("th")),
                  menuItem("Data Summary", tabName = "Summary", icon = icon("table")),
                  menuItem("Plot", tabName = "Plot", icon = icon("image"),
                           menuItem("Bar Chart", tabName = "Bar", icon = icon("chart-bar")),
                           menuItem("Histogram", tabName = "Hist", icon = icon("chart-bar")),
                           menuItem("Pie Chart", tabName = "Pie", icon = icon("chart-pie")),
                           menuItem("Scatter Plot", tabName = "Scatter", icon = icon("spinner"))),
                  menuItem("Practice", tabName = "Practice", icon = icon("edit")),
                  menuItem("Code", tabName = "Code")
                )
              ),
              
              dashboardBody(
                tabItems(
                  ##### Textbook Page #####
                  tabItem(
                    tabName = "Textbook",
                    fluidPage(
                      tabBox(
                        width = 7,
                        height = 1100,
                        tabPanel(
                          title = "單元主題簡介",
                          uiOutput("pdf1")
                        ),
                        tabPanel(
                          title = "資料視覺化介紹",
                          uiOutput("pdf2")
                        ),
                        tabPanel(
                          title = "常見視覺化圖表與程式實作",
                          uiOutput("pdf3")
                        ),
                        tabPanel(
                          title = "政府應用實例",
                          uiOutput("pdf4")
                        )
                      ),
                      box(
                        title = "R Code Practice",
                        solidHeader = TRUE,
                        status = "primary",
                        width=5,
                        height = 1100,
                        htmlOutput("html1"))
                    )
                  ),
                  
                  ##### Data Set Page #####
                  tabItem(
                    tabName = "Data",
                    fluidPage(
                      tabBox(
                        title = strong("Data Set"),
                        width = 12,
                        tabPanel(
                          title = "Select",
                          icon = icon("list"),
                          selectInput("dataSet", label = "Select Data Set",
                                      choices = c("airquality","diamonds","iris","midwest","mpg","mtcars")),
                          actionButton("start1", "Select", icon = icon("arrow-alt-circle-right"))),
                        tabPanel(
                          title = "Upload",
                          icon = icon("file-csv"),
                          fileInput("dataUpload", "Upload Data Set",
                                    accept = c("text/csv", "text/comma-separated-values", ".csv")),  
                          tags$script("$('#dataUpload').on('click', function() { this.value = null; });"),
                          actionButton("start2", "Upload", icon = icon("eject")))
                      ),
                      box(
                        title = "Data Table",
                        solidHeader = TRUE,
                        status = "primary",
                        width = 12,
                        dataTableOutput("dataTable")
                      )
                    )
                  ),
                  
                  ##### Data Summary Page #####
                  tabItem(
                    tabName = "Summary",
                    fluidPage(
                      box(
                        title = "Data Summary",
                        solidHeader = TRUE,
                        status = "primary",
                        width = 12,
                        verbatimTextOutput("summary")
                      )
                    )
                  ),
                  
                  ##### Plot Page #####
                  tabItem(
                    tabName = "Bar",
                    fluidPage(
                      box(
                        title = "Select Feature",
                        solidHeader = TRUE,
                        status = "primary",
                        width = 3,
                        selectInput("bar_feature", label = "Feature", choices = colnames(dataPractice)),
                        selectInput("bar_color", label = "Color", choices = colnames(dataPractice)),
                        div(paste("▲ Color請選擇「屬性資料」"), style = "color:red")
                      ),
                      box(
                        title = "Bar Chart",
                        solidHeader = TRUE,
                        status = "info",
                        width = 9,
                        plotOutput("bar_plot")
                      )
                    )
                  ),
                  tabItem(
                    tabName = "Hist",
                    fluidPage(
                      box(
                        title = "Select Feature",
                        solidHeader = TRUE,
                        status = "primary",
                        width = 3,
                        selectInput("hist_feature", label = "Feature", choices = colnames(dataPractice)),
                        selectInput("hist_color", label = "Color", choices = colnames(dataPractice)),
                        div(paste("▲ Color請選擇「屬性資料」"), style = "color:red")
                      ),
                      box(
                        title = "Histogram",
                        solidHeader = TRUE,
                        status = "info",
                        width = 9,
                        plotOutput("hist_plot")
                      )
                    )
                  ),
                  tabItem(
                    tabName = "Pie",
                    fluidPage(
                      box(
                        title = "Select Feature",
                        solidHeader = TRUE,
                        status = "primary",
                        width = 3,
                        selectInput("pie_feature", label = "Feature", choices = colnames(dataPractice))
                      ),
                      box(
                        title = "Pie Chart",
                        solidHeader = TRUE,
                        status = "info",
                        width = 9,
                        plotOutput("pie_plot")
                      )
                    )
                  ),
                  tabItem(
                    tabName = "Scatter",
                    fluidPage(
                      box(
                        title = "Select Feature",
                        solidHeader = TRUE,
                        status = "primary",
                        width = 3,
                        selectInput("scatter_x", label = "Var X", choices = colnames(dataPractice)),
                        selectInput("scatter_y", label = "Var Y", choices = colnames(dataPractice)),
                        selectInput("scatter_color", label = "Color", choices = colnames(dataPractice))
                      ),
                      box(
                        title = "Scatter Plot",
                        solidHeader = TRUE,
                        status = "info",
                        width = 9,
                        plotOutput("scatter_plot")
                      )
                    )
                  ),
                  
                  ##### Practice Page #####
                  tabItem(
                    tabName = "Practice",
                    fluidPage(
                      tabBox(
                        width = 7,
                        height = 1100,
                        tabPanel(
                          title = "練習實際案例操作",
                          uiOutput("pdf5")
                        )
                      ),
                      box(
                        title = "R Code Practice",
                        solidHeader = TRUE,
                        status = "primary",
                        width=5,
                        height = 1100,
                        htmlOutput("html2"))
                    )
                  ),
                  
                  #### Code Page #####
                  tabItem(
                    tabName = "Code",
                    htmlOutput("jupyter")
                  )
                )
              )
)

