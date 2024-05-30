library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)



# Load the dataset
foundation_dataset <- read.csv("shades (1).csv")


#  UI
ui <- fluidPage(
  titlePanel("Interactive Histogram of Foundation Shades"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of Bins:", min = 10, max = 50, value = 30),
      checkboxGroupInput("brands", "Select Brands:",
                         choices = unique(foundation_dataset$brand),
                         selected = c("Fenty", "MAC"))
    ),
    
    mainPanel(
      plotlyOutput("histogramPlot"),
      p("The above data set shows the comparison of lightness shades of the two brands Fenty and Mac. Observing the data set you can see how Fenty Foundation has more darker shades than the brand Mac. On the other hand, Mac has more frequency of lightness foundation than Fenty. For example, in the dataset, Mac has more significant brands of foundation that appear to be lighter and one shade that is the darkest. Additionally, in this dataset, the brand Mac appears to cater to more lightness instead of having an equal distribution of shade ranges like Fenty. Moreover, one can make the inference that if you are a person of color then a wiser choice would be to use Fenty Foundation as it appears to be more inclusive than Mac.

")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  filtered_data <- reactive({
    subset(foundation_dataset, brand %in% input$brands)
  })
  
  output$histogramPlot <- renderPlotly({
    p <- ggplot(data = filtered_data(), aes(x = L, fill = brand, text = paste("Brand:", brand, "<br>Lightness:", L))) +
      geom_histogram(bins = input$bins, color = "black", alpha = 0.7, position = "identity") +
      labs(
        title = "Histogram of Lightness for Selected Brands",
        x = "Lightness",
        y = "Frequency",
        fill = "Brand"
      ) +
      theme_minimal()
    
    ggplotly(p, tooltip = "text")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)