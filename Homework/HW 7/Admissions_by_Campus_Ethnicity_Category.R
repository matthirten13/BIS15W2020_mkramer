if (!require("tidyverse")) install.packages('tidyverse')
library("tidyverse")
if (!require("shiny")) install.packages('shiny')
library("shiny")
if (!require("shinydashboard")) install.packages('shinydashboard')
library("shinydashboard")
if (!require("naniar")) install.packages('naniar')
library("naniar")

UC_admit <- readr::read_csv("data/UC_admit.csv")

UC_admit <- UC_admit %>% 
  rename("Perc_Fr" = "Perc FR") %>% 
  mutate(Campus = as.factor(Campus),
         Academic_Yr = as.factor(Academic_Yr),
         Category = as.factor(Category),
         Ethnicity = as.factor(Ethnicity),
         Perc_Fr = as.numeric(gsub("[\\%,]", "", Perc_Fr)),
         FilteredCountFR = as.integer(FilteredCountFR)
  )

ui <- fluidPage(
  
  titlePanel("UC Campus Admissions 2010-2019"),
  
  sidebarLayout(      
    
    sidebarPanel(
      selectInput("Campus", "Filter by Campus:", 
                  choices=unique(UC_admit$Campus)),
      selectInput("Ethnicity", "Filter by Ethnicity:", 
                  choices=unique(UC_admit$Ethnicity)),
      selectInput("Category", "Filter by Admit Category:", 
                  choices=unique(UC_admit$Category)),
      hr(),
      helpText("Reference: University of California Information Center")
    ),
    
    mainPanel(
      plotOutput("plot")  
    )
    
  )
)

server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  
  output$plot <- renderPlot({
    
    UC_admit %>%
      filter(Campus == input$Campus & Ethnicity == input$Ethnicity & Category == input$Category) %>% 
      ggplot(aes(x=Academic_Yr, y=FilteredCountFR)) + 
      geom_bar(stat = "identity", color="black", fill="green2")+
      labs(x="Year",y=NULL)
  })
}

shinyApp(ui, server)
