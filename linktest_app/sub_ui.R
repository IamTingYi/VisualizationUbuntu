data('iris')

# Step6：建立Scatter Body的真實內容
scatter_ui <- fluidPage(
  box(
    selectInput('scatter_x', label = 'X', choices = colnames(iris)),
    selectInput('scatter_y', label = 'Y', choice = colnames(iris))
  ),
  box(
    plotOutput('scatter_plot')
  )
)

# Step7：建立Pie Body的真實內容
pie_ui <- fluidPage(
  box(
    selectInput('pie_feature', label = 'Feature', choices = colnames(iris))
  ),
  box(
    plotOutput('pie_plot')
  )
)

# 建立Bar Body的真實內容
bar_ui <- fluidPage(
  box(
    selectInput('bar_feature', label = 'Feature', choices = colnames(iris))
  ),
  box(
    plotOutput('bar_plot')
  )
)

# 建立Bubble Body的真實內容
bubble_ui <- fluidPage(
  box(
    selectInput('bubble_x', label = 'X', choices = colnames(iris)),
    selectInput('bubble_y', label = 'Y', choice = colnames(iris)),
    selectInput('bubble_size', label = 'Size', choice = colnames(iris))
  ),
  box(
    plotOutput('bubble_plot')
  )
)
# Step8：回到主程式碼(ui.R)最前方讀取sub_ui.R的source