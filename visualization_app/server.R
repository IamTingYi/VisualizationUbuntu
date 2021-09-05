dataPractice <- airquality

shinyServer(function(input, output, session) {
  ##### Textbook Page #####
  output$pdf1 <- renderUI({
    tags$iframe(style="height:1000px; width:100%", src="1單元主題簡介.pdf")
  })
  output$pdf2 <- renderUI({
    tags$iframe(style="height:1000px; width:100%", src="2資料視覺化介紹.pdf")
  })
  output$pdf3 <- renderUI({
    tags$iframe(style="height:1000px; width:100%", src="3常見視覺化圖表與程式實作.pdf")
  })
  output$pdf4 <- renderUI({
    tags$iframe(style="height:1000px; width:100%", src="4政府應用實例.pdf")
  })
  output$html1 <- renderUI({
    tags$iframe(src = "example.html", width = "100%", height = "1000", seamless=TRUE)
  })
  
  ##### Data Set Page #####
  var <- reactiveValues(table = dataPractice)
  observeEvent(input$start1,{
    dataSet <- switch(input$dataSet,
                      "airquality" = airquality,
                      "diamonds" = diamonds,
                      "iris" = iris,
                      "midwest" = midwest,
                      "mpg" = mpg,
                      "mtcars" = mtcars)
    if(class(dataSet)[1]!="data.frame"){
      dataSet <- as.data.frame(dataSet)
    }
    var$table <- dataSet
    updateSelectInput(session, "bar_feature", label = "Feature", choices = colnames(var$table))
    updateSelectInput(session, "bar_color", label = "Color", choice = colnames(var$table))
    updateSelectInput(session, "hist_feature", label = "Feature", choices = colnames(var$table))
    updateSelectInput(session, "hist_color", label = "Color", choices = colnames(var$table))
    updateSelectInput(session, "pie_feature", label = "Feature", choices = colnames(var$table))
    updateSelectInput(session, "scatter_x", label = "Var X", choices = colnames(var$table))
    updateSelectInput(session, "scatter_y", label = "Var Y", choices = colnames(var$table))
    updateSelectInput(session, "scatter_color", label = "Color", choices = colnames(var$table))
  })
  observeEvent(input$start2,{
    req(input$dataUpload)
    intial_data <- read.csv(input$dataUpload$datapath, header = TRUE)
    var$table <- intial_data
    updateSelectInput(session, "bar_feature", label = "Feature", choices = colnames(var$table))
    updateSelectInput(session, "bar_color", label = "Color", choice = colnames(var$table))
    updateSelectInput(session, "hist_feature", label = "Feature", choices = colnames(var$table))
    updateSelectInput(session, "hist_color", label = "Color", choices = colnames(var$table))
    updateSelectInput(session, "pie_feature", label = "Feature", choices = colnames(var$table))
    updateSelectInput(session, "scatter_x", label = "Var X", choices = colnames(var$table))
    updateSelectInput(session, "scatter_y", label = "Var Y", choices = colnames(var$table))
    updateSelectInput(session, "scatter_color", label = "Color", choices = colnames(var$table))
  })
  output$dataTable <- renderDataTable({var$table})
  
  ##### Data Summary Page #####
  output$summary <- renderPrint({summary(var$table)})
  
  ##### Plot Page #####
  output$bar_plot <- renderPlot({
    feature <- var$table[, input$bar_feature]
    color <- var$table[, input$bar_color]
    ggplot(data = var$table, mapping = aes(x = feature, fill = color)) +
      geom_bar() +
      labs(x = input$bar_feature, y = "Frequency") +
      theme_minimal()
  })
  output$hist_plot <- renderPlot({
    feature <- var$table[, input$hist_feature]
    color <- var$table[, input$hist_color]
    ggplot(data = var$table, mapping = aes(x = feature, fill = color)) +
      geom_histogram(bins = 30) +
      labs(x = input$hist_feature, y = "Frequency") +
      theme_minimal() 
  })
  output$pie_plot <- renderPlot({
    feature <- var$table[, input$pie_feature]
    ggplot(data = var$table, aes(x = "", fill = factor(feature))) +
      geom_bar(width = 1) +
      coord_polar(theta = "y") +
      theme_void()
  })
  output$scatter_plot <- renderPlot({
    x <- var$table[, input$scatter_x]
    y <- var$table[, input$scatter_y]
    color <- var$table[, input$scatter_color]
    ggplot(data = var$table, mapping = aes(x, y, color = color)) + 
      geom_point(size = 5, alpha = 0.5) +
      scale_x_continuous(input$scatter_x) +
      scale_y_continuous(input$scatter_y) +
      theme_minimal()
  })
  
  ##### Practice Page #####
  output$pdf5 <- renderUI({
    tags$iframe(style="height:1000px; width:100%", src="5練習-資料視覺化實例操作.pdf")
  })
  output$html2 <- renderUI({
    tags$iframe(src = "example.html", width = "100%", height = "1000", seamless=TRUE)
  })
  
  ##### Code Page #####
  output$jupyter <- renderUI({
    tags$iframe(src = "http://localhost:8888/?token=695ebae5b3a929335d970cb6aa57e366fc2ce8525662a94e", width = "100%", height = "1000")
  })
})
