library(shiny)
#etwd(dirname(rstudioapi::getActiveDocumentContext()$path))

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "index.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "https://use.fontawesome.com/releases/v5.5.0/css/all.css"),
    tags$script(src = "index.js", type = "text/javascript")
  ),
  titlePanel("How Education Accessibility Has Changed Worldwide"),
  
  tabsetPanel(id = "main",
    tabPanel(title = "Home", value = "home", htmlOutput("home")),
    tabPanel(title = "Creators", value = "creators", htmlOutput("creators")),
    tabPanel(title = "About", value = "intro",
             titlePanel("About Our Project"),
             img(src = "assets/globe.png", alt = "globe", id = "globe"),
             p("Our project analyzes the trends of the UN’s database on expected years of schooling
               around the world. We have filtered the information so our user can interact with the data to
               see how certain demographics have different levels of development."),
             h3("Data"),
             p("Our team used data from the “Human Development Data (1990-2017)” from
               the United Nations Development Programme linked to the World Bank Dataset.
               We chose to study Education and analyze the following three subcategories:
               Expected years of schooling (years), Expected years of schooling, female (years),
               Expected years of schooling, male (years)."),
             a("The data can be found here", href = "http://hdr.undp.org/en/data"),
             h3("Audience"),
             p("Our target audience is economists devoted to education:
               people interested in demographics within the educational system throughout the nation.
               More often, these are individuals who are social scientists studying the relationship
               between human behavior and the levels of development in various countries across the world."),
             h3("Big Questions"),
             p("Our team project will answer the following questions for our honed audience:"),
             p("1. How does each continent rank when comparing expected years of schooling rates?"),
             p("2. How do male and female expected years of schooling rates compare over the years for all the countries?"),
             p("3. When using the UN’s categorization of developed and developing nations, do developing nations have a lower expected years of
                     schooling rate compared to developed nations, and if so, does the gap decrease over time?"),
             h3("Analysis"),
             p("We constructed three tabs to answer our three questions:"),
             p("1. The first tab goes deep into exploring the information and comparison in the expected schooling years
                between different countries grouped by their continents, as well as filtered by specific years. This is shown using maps and bar charts."),
             p("2. The second tab builds a line graph to answer questions: For each country how has the expected years of schooling rate changed between 1990 and 2017? 
               How do these rates change when comparing females and males?"),
             p("3. The third tab intakes the data on expected years of schooling for both males and females combined and outputs 
              an interactive bar plot that shows the expected years of schooling for the countries categorized by developed nations and developing nations. ")),

    ## YEARS OF SCHOOLING BY CONTINENT (QUESTION 1)
    tabPanel(title = "Continents", value = "q1",
             titlePanel(strong("Expected Years Of Schooling By Continent")),
             # A summary about these charts related to continent
             p("Is there a difference in expected years of schooling for both males and females between different 
               continents and different years in the world?"),
             p(" The following map and bar chart give a visualization
                and comparison about the rate of expected schooling years between different continents in different years. 
                To explore the data visualization, the map and chart can be filtered by a specific continent using the buttons. There 
                is also an option for all continents. A specific year can also be chosen using the drop down menu."),
             # A conclusion for the question about continent
             p("Throughout the charts, we conclude that Europe has the smallest
               difference between countries in the rate of schooling years, whereas Africa witnesses
               the most significant difference. Furthermore, filtering the years helps us figure out
               the slight growth trend in the rate of schooling years for all the continents of the world included in
               the data."),
             sidebarLayout(
               # Side Panel
               sidebarPanel(
                 # Continent Filter (Using radio buttons type of widget)
                 helpText(h6("Choose a continent or all continents.
                             The map and the bar chart will show the rate of expected
                             schooling years in the selected option.")),
                 radioButtons(
                   "continent",
                   "Continent:",
                   c("All continents", "Asia", "Africa", "Americas",
                     "Europe", "Oceania"),
                   selected = "All continents"
                 ),
                 ## Year Filter (Using drop down menu type of widget)
                 helpText(h6("Choose a specific year. The map will show the rate of
                             expected schooling years in the selected year")),
                 selectInput(
                   "year",
                   "Year:",
                   c("1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997",
                     "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005",
                     "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013",
                     "2014", "2015", "2016", "2017"),
                   selected = "1990"
                 )
                 ),
               # Main Panel
               mainPanel(
                 # Creating the tab set for 2 different types of plots
                 tabsetPanel(type = "tabs",
                             tabPanel("Map", plotOutput("continent_map", height = 600)),
                             tabPanel("Bar Chart", plotOutput("continent_bar"))
                 )
               )
      )),
    
    tabPanel(title = "Female and Male", value = "q2",
             titlePanel("Female and Male Comparisons for Expected Years of Schooling Per Country"),
             # A summary about these charts related to gender
             p("For each country how has the expected years of schooling rate changed between 1990 and 2017? 
               How do these rates change when comparing females and males?
               Where does the world see trends of increased expected years of schooling and decreased expected years of schooling?"),
             # A conclusion for the question about gender
             p("For the most part, a majority of the world sees an upward trend of increased amount of expected years in schooling.
               These increases between 1990 and 2017 show, on average, a 2-3 extra years of expected years in schooling.
               This average increase is the same when isolating females and males, they both see about 2-3 additional years of expected schooling.
               One interesting observation is that for a majority of countries, females receive on average 1-2 more expected years of schooling when compared to males.
               Saudi Arabia is an interesting outlier, showing an increase of about 6 years in expected schooling between 1990 and 2017.
               Some countries, like Nigeria, see sudden drops in expected year of schooling around 2005 to 2010, but overall these countries saw the same average increase.
               All countries have seen the same trends of increased years of learning.
               However it is interesting to note that developing countries lag behind developed countries by about 5 years in expected schooling."),
             sidebarLayout(
               sidebarPanel(

                 # Select button dataset of both female and male, female, or male
                 radioButtons(inputId = "femaleMaleSelect",
                              label = "Select Data of:",
                              choices = list("Both Female and Male", "Female", "Male"),
                              selected = "Both Female and Male"),
                 # Select an input range of years
                 sliderInput(inputId = "femaleMaleYear",
                             label = ("Year Range:"),
                             sep = "",
                             min = 1990,
                             max = 2017,
                             value = c(1990, 2017),
                             ticks = FALSE),
                 # Select input of country choice
                 selectInput(inputId = "femaleMaleCountry",
                             label = "Select Country:",
                             choices = c("Afghanistan","Albania","Algeria","Andorra","Angola","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahamas","Bahrain",
                                         "Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bhutan","Bolivia (Plurinational State of)","Botswana","Brazil",
                                         "Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile",
                                         "China","Colombia","Comoros","Congo","Congo (Democratic Republic of the)","Costa Rica","Croatia","Cuba","Cyprus","Czechia",
                                         "Côte d'Ivoire","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Estonia","Swaziland",
                                         "Ethiopia","Fiji","Finland","France","Gabon","Gambia","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea",
                                         "Guinea-Bissau","Guyana","Haiti","Honduras","Hong Kong, China (SAR)","Hungary","Iceland","India","Indonesia","Iran (Islamic Republic of)",
                                         "Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Korea (Republic of)","Kuwait",
                                         "Kyrgyzstan","Lao People's Democratic Republic","Latvia","Lebanon","Lesotho","Libya","Lithuania","Luxembourg","Madagascar","Malawi",
                                         "Malaysia","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova (Republic of)","Mongolia","Morocco","Mozambique","Myanmar","Namibia",
                                         "Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Papua New Guinea","Paraguay","Peru",
                                         "Philippines","Poland","Portugal","Qatar","Romania","Russian Federation","Rwanda","Saint Kitts and Nevis","Saint Lucia",
                                         "Saint Vincent and the Grenadines","Samoa","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone",
                                         "Singapore","Slovakia","Slovenia","Solomon Islands","South Africa","Spain","Sri Lanka","Sudan","Suriname","Sweden","Switzerland",
                                         "Syrian Arab Republic","Tajikistan","Tanzania (United Republic of)","Thailand","The former Yugoslav Republic of Macedonia","Togo","Tonga",
                                         "Trinidad and Tobago","Tunisia","Turkey","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Uzbekistan",
                                         "Venezuela (Bolivarian Republic of)","Viet Nam","Yemen","Zambia","Zimbabwe"),
                             selected = "United States")
               ),
               mainPanel(plotOutput("q2"))
             ),
  tags$br()
  ),
  
  #Start for Question 3
  tabPanel(title = "Developing and Developed Nations", value = "q3",
           # Title of shiny app page
           titlePanel(strong("UN Developed Nations vs. Developing Nations")),
           # Introduces purpose and where categories are from.
           p("This visualization displays a barchart where the user can choose between developed and 
             developing nations and which year of data they prefer to see. The data displayed shows 
             each country in the correct categorization and their comparing expected years of schooling 
             rate for the selected year."),
           h3("Data"),
           p("We did not create the country categories on our own. We used the United Nations
             list of developed and developing nations."),
           a("The categories can be found here.", href = "https://unstats.un.org/unsd/methodology/m49/"),
           p(),
           p("When looking at the data there is a range in expected schooling rates in both the UN classified
             developed and developing countries, however there is a greater variety in the range of developing
             nations. Another clear trend, is that when comparing the bar plots for both developed and developing
             nations between the 1990 plot and the 2017 plot, there is a clear increase in expected schooling rates 
             across the board in 2017."),
           
           # Creates sidebar layout 
           sidebarLayout(
             sidebarPanel(
               
               # Created radio buttons to choose Developed or Developing
               radioButtons(inputId = "nations",
                            "Data Of:",
                            choices = list("Developed", "Developing"),
                            selected = "Developed"),
               
               # Creates select box widget for the given years in the data set of 
               # UN nations from server.R data.
               selectInput(inputId = "years",
                           label = "Years:",
                           choices = 1990:2017)
             ),
             
             # Creates area where bar plot will be displayed
             mainPanel(
               plotOutput("barPlot")
             )
           )
           ),
  
  tabPanel(title = "Donations", value = "donate", 
           titlePanel("Please donate $1 to help children around the world receive a fair education."),
           # A summary about how donating will help
           img(src = "assets/donate0.png", id = "donate-main-img"),
           p( "Children in developing nations need your help to have a chance at receiving an equitable education.
             All donations will go towards aiding and supporting schooling systems close to home and abroad.
             In particular, by helping developing nations raise their rates of expected years of schooling, countries
             will gain long term value that improves domestic standards of living, and in turn world-wide productivity."),
           p("A small donation today can make a world of difference tomorrow!", id = "quote"),
           p("Here are some charities you may consider donating to:"),
           a(img(src = "assets/donate1.png", class = "donate-img"), href = "https://www.savethechildren.org/us/what-we-do/global-programs/education"),
           p(),
           a(img(src = "assets/donate2.png", class = "donate-img"), href = "https://www.obama.org/globalgirlsalliance/"),
           p(),
           p("To learn more about current issues in education systems, consider visiting the site of 
             Educational International for news updates on education around the world."),
           a(img(src = "assets/donate3.png", class = "donate-img"), href = "https://www.ei-ie.org/"))
),
uiOutput("buttons")
)
