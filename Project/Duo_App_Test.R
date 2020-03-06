if (!require("tidyverse")) install.packages('tidyverse')
library("tidyverse")
if (!require("shiny")) install.packages('shiny')
library("shiny")
if (!require("shinydashboard")) install.packages('shinydashboard')
library("shinydashboard")
if (!require("naniar")) install.packages('naniar')
library("naniar")

goose <- readr::read_csv("data/Goose_data_2019.csv")

names(goose)<-gsub("\\s","_",names(goose))#Put_in names
names(goose)<-gsub("#","Number",names(goose))

goose <- goose %>% 
  mutate_at(vars(Band_Number,Species,Common_Name,Age,Sex,Bander_ID,
                 Location,How_Captured,Transmitter_Affixed,Cloacal_Swab,
                 Blood_Sample_Taken, Transmitter_ID,Aux_Marker_Type,Season),
            as.factor) %>% 
  mutate_at(vars(Wing_Chord, Bird_Weight, Tarsus_Length, Culmen_Length, 
                 Bill_Width, Bill_Height), 
            as.numeric)

goose_mean <- goose %>% 
  group_by(Common_Name, Sex) %>% 
  summarize(Wing_Chord_mm = mean(Wing_Chord, na.rm=T),
            Bird_Weight_g = mean(Bird_Weight, na.rm=T),
            Tarsus_Length_mm = mean(Tarsus_Length, na.rm=T),
            Culmen_Length_mm = mean(Culmen_Length, na.rm=T),
            Bill_Width_mm = mean(Bill_Width, na.rm=T),
            Bill_Height_mm = mean(Bill_Height, na.rm=T)) %>% 
  pivot_longer(Wing_Chord_mm:Bill_Height_mm,
               names_to = "Measure",
               values_to = "Value")
goose_all <- goose %>% 
  rename(Wing_Chord_mm = Wing_Chord,
         Bird_Weight_g = Bird_Weight,
         Tarsus_Length_mm = Tarsus_Length,
         Culmen_Length_mm = Culmen_Length,
         Bill_Width_mm = Bill_Width,
         Bill_Height_mm = Bill_Height) %>% 
  pivot_longer(Wing_Chord_mm:Bill_Height_mm,
               names_to = "Measure",
               values_to = "Value")
  

ui <- fluidPage(    
  
  titlePanel("Goose Data by Sex"), 
  sidebarLayout(      
    sidebarPanel(
      radioButtons("Common_Name", "Select a Goose Species:", 
                  choices=unique(goose_mean$Common_Name)),
      selectInput("Measure", "Select a Measurement",
                  choices = unique(goose_mean$Measure)),
      selectInput("Type", "Select a Graph Type:",
                  choices = c("Bar Graph", "Box Plot"),
                  selected = "Bar Graph"),
      hr(),
      helpText("Credit: Goose data collected by A. Mott")
    ),
    mainPanel(
      plotOutput("goosePlot")  
    )
  )
)
server <- function(input, output, session) {
  output$goosePlot <- renderPlot({
     if (input$Type == "Bar Graph") 
      goose_mean %>% 
        filter(Common_Name == input$Common_Name & Measure == input$Measure) %>% 
        ggplot(aes(x=Sex, y=Value, fill = Sex)) + 
        geom_bar(stat = "identity")+
        labs(x="Sex",
           y=input$Measure)
    else
      goose_all %>% 
        filter(Common_Name == input$Common_Name & Measure == input$Measure) %>% 
      ggplot(aes(x=Sex, y=Value, fill = Sex))+
      geom_boxplot()+
      labs(x="Sex",
           y=input$Measure)
  })
}

shinyApp(ui, server)