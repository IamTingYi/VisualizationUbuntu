library(shiny)
library(shinydashboard)
# Step8：讀取sub_ui.R的source
source("sub_ui.R")
# Step1：建構初始UI介面(Header, Sidebar, Body)
dashboardPage(skin = "blue",
              dashboardHeader(
                title = "Practice"
              ),
              # Step2：建構Sidebar項目
              dashboardSidebar(
                sidebarMenu(
                  menuItem("Input Data", tabName = "data", icon = icon("table")
                  ),
                  menuItem("Plot", tabName = "Plot", icon = icon("image"),
                           menuItem("Scatter", tabName = "Scatter", icon = icon("braille")),
                           menuItem("Pie", tabName = "Pie", icon = icon("chart-pie")),
                           menuItem("Bar", tabName = "Bar", icon = icon("chart-bar")),
                           menuItem("Bubble", tabName = "Bubble", icon = icon("soap"))
                  ),
                  menuItem("Link", tabName = "link", icon = icon("link"))
                )
              ),
              dashboardBody(
                tabItems(
                  tabItem(tabName = "link",
                          fluidPage(
                            div(h1(p("去另一個shiny介面")), style = "color:navy"),
                            h2(a(href="http://localhost:3838/shiny1/", "按這裡"))
                          )
                  ),
                  # Step3：設置Upload Data(upload, button, show)
                  tabItem(tabName = "data",
                          fluidPage(
                            fileInput('data_upload', 'Data',
                                      accept = c('text/csv', 'text/comma-separated-values', '.csv')),
                            tags$script(
                              '$("#data_upload").on("click", function() {
                                      this.value = null; });'
                            ),
                            actionButton('upload', 'upload', icon = icon('upload'))
                          ),
                          dataTableOutput("datatable")
                  ),
                  # Step5：建構其他項目內容，這裡使用sub_ui的方式是為了簡化主程式碼
                  tabItem(tabName = "Scatter",
                          scatter_ui
                  ),
                  tabItem(tabName = "Pie",
                          pie_ui
                  ),
                  tabItem(tabName = "Bar",
                          bar_ui
                  ),
                  tabItem(tabName = "Bubble",
                          bubble_ui
                  )
                )
              )
)





