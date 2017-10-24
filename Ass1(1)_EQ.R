library(shiny)
# Define the UI for the app
ui <- fluidPage( 
 
  #define the title of the App
   titlePanel("Assignment 1"),
  #Place the input field in the sidebar panel
   sidebarLayout(
  sidebarPanel(
  numericInput(inputId = "n",
    "Sample size", value = 20, min = 1, max = 10000),
  
  #Input: slider for the mean and standard deviation of the distribution
  sliderInput ("mean", "Mean:",
               min = 0, max = 200,
               value = 10, step = 1),
  #Input : Decimal Starndard deviation ----
  sliderInput("sd", "Standard Deviation:",
              min = 0, max= 10,
              value=1, step = 1)),
            

  
  #Plot histogram in the main panel  
  mainPanel(
    plotOutput(outputId = "hist")) 
))



#Define the server function for the output
server <- function(input, output) { 
  output$hist <- renderPlot({ 
    hist(rnorm(input$n, input$mean, input$sd),col = 'lightblue', border = 'black',
         xlab = "Histogram of input 'n'",
         main = "Histogram")
    })

} 

shinyApp(ui = ui, server = server)
