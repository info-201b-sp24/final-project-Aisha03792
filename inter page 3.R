library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(gapminder)

foundation_dataset <- read.csv("shades (1).csv")

ui <- fluidPage(
  tabPanel("Saturation Exploration",
           fluidPage(
             titlePanel("Saturations Differences across Brands!"),
             sidebarLayout(
               sidebarPanel(
                 p("The chart attempts to visualize and understand the difference between saturation from companies of different regions across the globe, touching bases in America, Nigeria, and Japan. I am to reveal patterns and variations in the undertones and diversity of saturation between all these brands.Presenting the data in a bubble chart makes it easy to intuitively understand and creatively observe the divergence of observations, which is presented by the size and density of bubbles.The range of bubble sizes shows the variation in saturation levels offered by different companies. Larger bubbles represent higher saturation and smaller bubbles represent lower saturation levels. These charts are helpful in understanding the variation in saturation levels and make it easy to identify which company provided the more diverse bubble for a group of people."),
                 selectInput("category_select",
                             "Select a Category:",
                             choices = list(
                               "American Brands" = list(
                                 "Fenty",
                                 "Mac", 
                                 "America Comparison"),
                               "Nigeria" = c(
                                 "House of Tara",
                                 "Hegai and Ester",
                                 "Nigeria Comparison"),
                               "Japanese" = c(
                                 "Addiction", 
                                 "Ipsa",
                                 "Japan Comparison"),
                               "Indian" = c(
                                 "Lakmé", 
                                 "Lotus Herbals",
                                 "India Comparison")
                             ),
                             
                 ),
               ),
               
               mainPanel(
                 plotlyOutput("Selected_chart"),
               )
             )
           )
  )
)
server <- function(input, output) {
  
  output$Selected_chart <- renderPlotly({
    data <- switch(input$category_select,
                   "Fenty" = fenty_data,
                   "Mac" = mac_data,
                   "House of Tara" = House_data,
                   "Hegai and Ester" = Hegai_data,
                   "Addiction" = addict_data,
                   "Ipsa" = ipsa_data, 
                   "Lakmé" = Lakmé_data, 
                   "Lotus Herbals" = LotusHerbals_data,
                   "America Comparison" = american_brands, 
                   "Nigeria Comparison" = nigerian_brands,
                   "Japan Comparison" = Japans_brands,
                   "India Comparison" = indian_brands
    )
    
    p2 <- ggplot(data = data, aes(x = product, y = S, size = S, fill = brand)) + 
      geom_point(position = position_jitter(width = 0.3, height = 0.3), alpha = 0.7, shape = 21, colour = "black") +
      scale_size_continuous(range = c(-5, 10)) +
      labs(y = "Saturation Levels", x = "Product", fill = "Brand", size = "Saturation") +
      ggtitle(paste(input$category_select, "Foundation: Saturation Level")) +
      theme_minimal()
    
    ggplotly(p2)
  })
}

shinyApp(ui = ui, server = server)