library(shiny)
library(ggplot2)
library(plotly)
library(gapminder)
library(rsconnect)

ui <- navbarPage(
  title = "Final Info project",
  theme = shinythemes::shinytheme("cosmo"),
  tabPanel("Introduction",
           br(),
           tags$img(src = 'Info_final_Image.png', height = 400, width = 400),
           mainPanel(
             h2("Diversity in the Makeup Industry (How Can The Industry Improve?)"),
             
             
             p("Our project is focused on the inclusivity of foundation ranges with two brands such as Fenty Beauty and Mac. For many years, there has been ongoing demand and concerns regarding inclusivity in the beauty industry. It is common knowledge, how diversity is glaringly insufficient and undesirable in today's progressive society. The darker shades of foundation on the color spectrum are usually limited and not many people of color have access to a wider range of shades within their skin tone. Despite people of color perpetually voicing their concerns about the lack of diversity. Unfortunately, many well-known brands disregard these claims and instead, they consistently cater to a lighter range of skin tones. No matter how many times consumers raise their voices, it has become apparent that disregarding the inclusivity of a certain population is a very detrimental oversight. Considering the fact that customers can wield their purchasing power anytime for a change. After many years, now the beauty industry is slowly evolving and some changes have been pioneered with brands like Fenty Beauty. Especially brands like Fenty Beauty, a Black-owned brand is are known for advocating for inclusivity and her foundation ranges are more diverse than any other brands."),
             p("The objective of this project is to conduct an analysis of the foundation shade offerings between two highly sought and leading cosmetic brands, Fenty Beauty (Black owned brand) and Mac Cosmetics (White owned brand). We are collecting and analyzing our data from, The Pudding: Beauty Brawl. We intend to evaluate the elements within foundation shade coloring that leads to a more diverse and inclusive range of foundation shades by evaluating the Saturation, Hues, and Lightness range of the brand shades. While also taking a closer look into international brands and their varying ranges."),
             h4("Original Data:"), 
             p("https://raw.githubusercontent.com/the-pudding/data/master/makeup-shades/shades.csv"),
             h3("Questions:"),
             p("Some research questions that we want to address in our project are what ranges of foundation shades are offered compared to different brands? Also how diverse are the lightness, saturation, and hues of each of the undertones? How does each brand show inclusivity within its foundation ranges? What demographic is the brand catering too?"),
             p("These questions are important to address because we want to investigate how prominent it is to have inclusivity when it comes to the beauty industry. Moreover, we want the beauty industry to cater to all skin tones and not be biased when it comes to representing people of color."),
             h3("Ethical Questions:"),
             p("A question of power we need to take into consideration is the power imbalance between BIPOC owned brands and Non-BIPOC owned brands. Many non-BIPOC owned brands such as MAC have the brand exposure in comparison to others. In Fenty’s case, a cosmetic brand owned by Rhianna receives publicity exposure; however, many BIPOC brands do not receive the same amount of media coverage and brand exposure."),
             h3("Limitations:"),
             p("The challenges or limitations that may arise while working with our dataset are heavily dependent on the size of the dataset, and how they have decided to evaluate the foundation shades. While the data set provides us with a good starting point it still leaves us with limitations and challenges regarding the foundation colors and companies that they have analyzed. Another challenge that arises with our dataset is that there is a lack of visual representation of the shade colors they evaluated This makes it less accessible, as hue and saturation are not common knowledge when customers are shopping for foundation shades. The insufficiency of a visual presence for the foundation colors can hinder the understanding of the diversity and inclusivity of these brands’ shade ranges. This would also pose a challenge in assessing the diversity and inclusivity of the brand's foundation shades when we are not able to analyze further and identify if undertone and skin tones play a role in the shade ranges they have included in their dataset."),
           )
  ),
  tabPanel("Histogram",
           fluidPage(
             titlePanel("Interactive Histogram of Foundation Shades"),
             sidebarLayout(
               sidebarPanel(
                 p("You can play with the foundation brands of different companies to see their lightness range of one another. Also, you can try to compare and contrast each brand of foundation to make an observation of what kind of audiences these companies cater to the most? Further, this Dataset includes White owned brands, Black owned brands and International owned brands from India, Japan, and Nigeria"), 
                 sliderInput("bins", "Number of Bins:", min = 10, max = 50, value = 30),
                 checkboxGroupInput("brands", "Select Brands:",
                                    choices = unique(foundation_dataset$brand),
                                    selected = c("Fenty", "MAC"))
               ),
               
               mainPanel(
                 plotlyOutput("histogramPlot"),
                 p("The above data set shows the main two brand comparison of lightness shades of the two brands Fenty and Mac. Observing the data set you can see how Fenty Foundation has more darker shades than the brand Mac. On the other hand, Mac has more frequency of lightness foundation than Fenty. For example, in the dataset, Mac has more significant brands of foundation that appear to be lighter and one shade that is the darkest. Additionally, in this dataset, the brand Mac appears to cater to more lighter skin color people instead of having an equal distribution of shades of all people of color like Fenty. If you just select the brand Fenty in the dataset, you can see how diverse Rihanna a black owned celebrity foundation appears to be. Since Rihanna is Black, she understands how important inclusivity is for all people. Unlike Mac a White owned company who invairably profits more from making lighter foundtion and barely even focusing on the struggle of people of color.")
               )
             )
           )
  ),
  
  tabPanel("Box Plot",
           
           fluidPage(
             titlePanel("Interactive Box Plot of Foundation Shades"),
             sidebarLayout(
               sidebarPanel(
                 selectInput("brandSelection", "Select Brands:",
                             choices = unique(foundation_dataset$brand),
                             selected = c("MAC", "Fenty"),
                             multiple = TRUE)
               ),
               mainPanel(
                 plotlyOutput("BoxPlot"),
                 p("I used a box plot to compare the hues of foundations from Fenty and Mac. From this plot, it is evident that Fenty is more inclusive of medium and darker skin tones. The range is greater for Fenty foundations hues as well. The wider hue range implies that there’s inclusivity and broader skin tones are accommodated. A variety of skin tones can be matched with a wider hue range. Hence Fenty, having a wider hue range, is able to have foundation shades that match more skin tones.")
               )
             )
           )
  ),
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
  ),

tabPanel("Conclusion",
         mainPanel(
           h2("Main Takeaways"),
           p("Popular shade ranges vary based on regional location and popular demographic as seen through our varying graphs. With the United States there is a divide between white and black owned makeup companies when it comes to foundation shade. Through our research we attempt to answer the question of the varying shades in American owned brands Fenty and MAC. Connecting the number of shades available with the diversity of a brand. Our analysis revealed that in 2018, Fenty, a black owned business, is more diverse than MAC in foundation shade range."),
           h3("Taking a further look at the data:"),
           p("Fenty has the highest (94) and lowest (25) lightness score when it comes to their foundation shades compared to MAC. The Lowest overall lightness score is 11 from Laws of Nature (a Black owned brand) and the highest was Lancome at 95 (White owned brand)."),
           p("Fenty has a larger hue range than MAC. MAC has a largest hue number."),
           p("The highest saturation level was found in Fenty at 0.79 in a 0-1 range."),
           p("Lightness scale is based on 10 point range between shade categories ranging from 0-100. The shades are categorized in ascending order with the darkest shade at the beginning (0-10). When evaluating the Hue, we pulled the highest and lowest number when evaluating shade range. Hue indicates the color used in the undertone of the foundation, which plays a direct role in shade variety when paired with saturation. This alone cannot tell whether a brand has a more diverse shade range as saturation plays a large role in the overall shade color. When it comes to the saturation we searched for the highest value to indicate which shade offers the darker shades in association to the hue. Saturation is the strength in which the hue color appears."),
           p("Overall, Fenty, a Black owned brand, shows the most diverse range of foundation in regards to not only foundation color but the variety of undertones their foundation caters towards. Inclusivity in foundation shade is not based on the color itself but the undertones catered towards. Brands who take better care and notice the layers that go into making their shade show a larger range of shade diversity than those who do not. BIPOC owned brands through our data research show a more diverse range when taking these other elements into account."),
         )
)
)

server <- function(input, output, session) {
  
  # Define a reactive expression to filter data based on selected brands
  filtered_data <- reactive({
    subset(foundation_dataset, brand %in% input$brands)
  })
  
  # Render histogram plot
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
  
  output$BoxPlot <- renderPlotly({
    
    filtered_values <- subset(foundation_dataset, brand %in% input$brandSelection)
    p2 <- ggplot(filtered_values, aes(x=brand, y=H, fill=brand)) +
      geom_boxplot() +
      theme_minimal() +
      labs(title="Box Plot of Hue for Selcted Foundation Brands", x="Brand", y="Hue")
    ggplotly(p2)
    
  })
  
  
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
}

shinyApp(ui = ui, server = server)
