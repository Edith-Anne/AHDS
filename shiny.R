library(shiny)

# Define the Shiny UI (User Interface)
ui <- fluidPage(
  titlePanel("BMI and Age Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Displays the relationship between Age and BMI"),
      
      # Input: Select the type of plot
      selectInput("plotType", "Select Plot Type:",
                  choices = c("Scatter Plot", "Box Plot"))
    ),
    
    # Output: Show the plot
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  # Generate the plot based on input
  output$plot <- renderPlot({
    # Scatter plot
    if (input$plotType == "Scatter Plot") {
      ggplot(data_merg, aes(x = AgeGroup, y = BMXBMI)) +
        geom_point(alpha = 0.4) +
        geom_smooth(method = lm, color = "blue") +
        labs(x = "Age", y = "BMI", title = "Relationship between Age and BMI")
    } 
    # Box plot
    else if (input$plotType == "Box Plot") {
      ggplot(data_merg, aes(x = AgeGroup, y = BMXBMI)) +
        geom_boxplot() +
        labs(x = "Age Group", y = "BMI", title = "BMI Distribution across Age Groups")
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
