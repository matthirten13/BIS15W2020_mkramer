library(tidyverse)
library(shiny)
library(shinydashboard)
library(naniar)

options(scipen=999)

UC_admit <- readr::read_csv("data/UC_admit.csv")

UC_admit <- UC_admit %>% 
  rename("Perc_Fr" = "Perc FR") %>% 
  mutate(Campus = as.factor(Campus),
         Academic_Yr = as.factor(Academic_Yr),
         Category = as.factor(Category),
         Ethnicity = as.factor(Ethnicity),
         Perc_Fr = as.numeric(gsub("[\\%,]", "", Perc_Fr)),
         FilteredCountFR = as.integer(FilteredCountFR)
  ) %>% 
  filter(Ethnicity != "All")

ui <- fluidPage(
  titlePanel("UC Campus Admissions by Percent"),
  selectInput("x", "Select X Variable", choices = c("Campus", "Academic_Yr", "Category"), 
              selected = "Campus"),
  plotOutput("plot", width = "800px", height = "500px")
  
)

server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  output$plot <- renderPlot({
    ggplot(UC_admit, aes_string(x = input$x, y = UC_admit$Perc_Fr, fill = UC_admit$Ethnicity))+
      geom_bar(stat = "identity", position = "dodge")+
      labs(x = input$x,
           y = "Percent")
  })
}

shinyApp(ui, server)