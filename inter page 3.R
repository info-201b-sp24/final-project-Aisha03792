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
                 p("The chart attempts to visualize and understand the difference between saturation from companies of different regions across the globe, touching bases in America, Nigeria, India, and Japan. This page attempts to reveal patterns of variation of saturation density and of the diversity of saturation between all these brands."),
                 p("Presenting the data in a bubble chart makes it easy to intuitively understand and creatively observe the divergence of observations, which is presented by the size and density of bubbles. The range of bubble sizes shows the variation in saturation levels offered by different companies. Larger bubbles represent higher saturation and smaller bubbles represent lower saturation levels. These charts help understand the variation in saturation levels and make it easy to identify which company provided the more diverse bubble for a group of people."),
                 p("The Questions I am trying to answer:"),
                 
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
                             selected = "Select Category"
                 )
               ),
               mainPanel(
                 plotlyOutput("Selected_chart"),
                 
                 conditionalPanel(
                   condition = "input.category_select == 'Fenty'",
                   p("In this graph, we are observing Fenty Beauty. When we zoom out, we can observe that Fenty’s bubble chart is a heavily dense population, this represents that this company has a lot of saturation options and those options are of high levels.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'Mac'",
                   p("In this graph, we are observing Mac Cosmetics. When we zoom out, we can observe that Mac had a diverse population of saturation but those bubbles don’t go as high as Fenty’s bubble. Let's move on to the American Comparison to see this more clearly.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'America Comparison'",
                   p("Here, we are making a comparison between Mac and Fenty. As stated in the Mac Cosmetics section, we can see how much higher Fenty’s saturation goes up compared to Mac’s. This visual comparison helps us answer the second and third questions by demonstrating how Fenty offers more diversity of foundation shades by having more saturation options. The density and height of the bubbles in this graph provided another valuable insight into the difference compared to other regional graphs.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'House of Tara'",
                   p("Here, when their saturation levels are very spread out compared to Hegai and Ester,  this makes me question if they might be a new brand or because they hate her to just one population group they are limited to and how many ranges the company can have. Although their saturation levels go higher than Mac Foundation saturation levels it makes me question how pricing comes into play, for example, if the company is expensive for middle-class regular people it would show the reason why they don't have a wide variation of saturation or they are limited to a few.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'Hegai and Ester'",
                   p("Here,  we are observing Hegai and Ester. When we zoom out we can observe that A lot of their products have high saturation and they might not have a wide range of products because of how separated the saturation levels are. ")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'Nigeria Comparison'",
                   p("Here, we are making a comparison between House of Tara and Hegai and Ester, well-known Nigerian-based companies. Due to its consumer base being majority women of color, in order to make shades to cater to them they have to have high saturations in their foundation. This is why we see that their saturation levels are higher evaluated and do not go down to the zero scale as other brands.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'Addiction'",
                   p("Here we are evaluating the addiction company,  this is a company based in Japan. when we zoom out we can observe that they have a good amount of saturation levels,  but we can also observe that their saturation scale mark is not that high compared to the other ones that we've seen this makes me think that in this country there is not a need for beauty companies to have a high high saturations to fit into their consumer base.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'Ipsa'",
                   p("Here we are evaluating ipsa,  this company is based in Japan and we can observe that there are barely any saturation levels compared to a few and this makes me question whether a lot of the Foundation shapes that they produce are mainly on the lighter shades And or their consumer base is people who have lighters can tones and undertones.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'Japan Comparison'",
                   p("Here we're making a comparison between the two Japanese companies we can observe that Addiction has a lot more saturation levels. These two are equally compared to the foundations that they provide and addiction is the winner in providing a wide variation of saturation levels but Ipsa,  might also be staying to one consumer range as they might not have a big of a consumer market to reach out to by making more shades.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'Lakmé'",
                   p("Here we are observing Lakme,  an Indian-based company.  we can observe that They have a higher saturation compared to Lotus on the scale wavelength.  I did some more research and they are a beauty company that provides different services but in their makeup aspect they have darker shades and I feel like these variations are for more pigment in products specifically their Foundation shades.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'Lotus Herbals'",
                   p("Here we are observing Lotus Herbals, an Indian-based company.  We can observe that they also don't have a wide variation of saturation levels although their company. I did some research and I found that they are a white mean company so that might be a reason why they don't provide any saturation or have any “darker shade” options available.")
                 ),
                 conditionalPanel(
                   condition = "input.category_select == 'India Comparison'",
                   p("Here we can observe that Lakmè has a higher saturation level compared to Lotus, their results are very stark to me because of how big the separation Gap is even though they're based in the same country they have totally different consumer bases and targets.  While one communist goal is to brighten and get rid of dark marks the other one empowers.")
                 ),
               )
             )
           )
  )
)

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
                 "Japan Comparison" = japans_brands,
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

shinyApp(ui = ui, server = server)

