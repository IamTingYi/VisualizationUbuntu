library(shiny)
data('iris')

shinyServer(function(input, output, session) {

  var <- reactiveValues(table = iris)
  
  #Step4：設定連動Server端Upload的活動
  ## Upload Botton Event
  observeEvent(input$upload, {
    req(input$data_upload)
    initial_data <- read.csv(input$data_upload$datapath, header = TRUE)
    var$table <- initial_data
    updateSelectInput(session, 'scatter_x', label = 'X', choices = colnames(var$table))
    updateSelectInput(session, 'scatter_y', label = 'Y', choice = colnames(var$table))
    updateSelectInput(session, 'pie_feature', label = 'Feature', choices = colnames(var$table))
    updateSelectInput(session, 'bar_feature', label = 'Feature', choices = colnames(var$table))
    updateSelectInput(session, 'bubble_x', label = 'X', choices = colnames(var$table))
    updateSelectInput(session, 'bubble_y', label = 'Y', choice = colnames(var$table))
    updateSelectInput(session, 'bubble_size', label = 'Size', choice = colnames(var$table))
  })
  output$datatable <- renderDataTable({var$table[, -1]})
  
  #Step9：設定連動Server端Scatter的活動
  ## Plot Scatter
  output$scatter_plot <- renderPlot({
    x <- var$table[, input$scatter_x]
    y <- var$table[, input$scatter_y]
    plot(x, y, xlab = input$scatter_x, ylab = input$scatter_y)
  })

  ##Step10：設定連動Server端Pie的活動
  ## Plot Pie
  output$pie_plot <- renderPlot({
    feature <- var$table[, input$pie_feature]
    feature_count <- table(feature)
    pie(feature_count)
  })
  
  ##設定連動Server端Bar的活動
  ## Plot Bar Chart
  output$bar_plot <- renderPlot({
    feature <- var$table[, input$bar_feature]
    feature_count <- table(feature)
    barplot(feature_count)
  })
  
  ##設定連動Server端Bubble的活動
  ## Plot Bubble
  library(ggplot2)
  library(dplyr)
  output$bubble_plot <- renderPlot({
    x <- var$table[, input$bubble_x]
    y <- var$table[, input$bubble_y]
    size <- var$table[, input$bubble_size]
    ggplot(data = var$table, mapping = aes(x, y, size = size)) + 
      geom_point(color = 'blue', alpha = 0.5) +
      scale_x_continuous(input$bubble_x) +
      scale_y_continuous(input$bubble_y) 
  })
  
})
