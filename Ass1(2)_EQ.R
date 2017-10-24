library(shiny)
#define UI for the application
ui <- fluidPage(
  #Title of the App
  titlePanel("Assignment 1 
             Part 2"
             ),
  sidebarLayout(
    sidebarPanel(
      #Allow user to input CSV files
      fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      tags$hr(),
      #Create a checkbox to display header of table
      checkboxInput("header", "Header", TRUE),
      #Allow user to select variable of choice to analyse
      selectInput('variable','Variable:',
                  c('Age'='age',
                    'Height'= 'height',
                    'Weigth'='weight',
                    'BMI'='bmi')),
      
    #Radio Buttons to allow user to change the colour of the box plot for each variable selected             
       radioButtons('radiob', 'Choose boxplot colour',
                    c('Blue',
                      "Green",
                      "Red",
                      "Pink"))
                  
      
    ),
    
    #The main panel will display the the table creted from the CSv file uploaded and the box plot of the individual variables
    mainPanel(
      tableOutput('data'),
      
      plotOutput('box')
    )
    
  
))

#Define the server logic to create a table and a boxplot (renderTable, renderPlot)
server <- function(input, output){
  output$data <- renderTable({
    infile <- input$file1
    if (is.null(infile))
      return(NULL)
    read.csv(infile$datapath, header = input$header)
  })


    output$box <- renderPlot({
      (req(input$file1))
      infile = input$file1
      data <- read.csv(infile$datapath, header = input$header)
      
      var = input$variable
      col = input$radiob
      boxplot(data[,var], col = col, main = paste("Selected Variable",var))
      
            
    })
}

#Run the shiny app 
shinyApp(ui=ui,server = server)