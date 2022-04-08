# setwd('~/OneDrive/Pitts/2022spring/BIOST2094_Advanced_R/final_project/recipe/')
load('Recipe.RData')
# ingred <- NULL
# for(i in 1:length(Recipe)){
#   ingred <- c(ingred, Recipe[[i]]$ingredients)
#   unique(ingred)
# }
# length(ingred)
cuisine <- sapply(Recipe, function(x) x$cuisine)
cuisine_count_df <- as.data.frame(table(cuisine))


library(shiny)
library(ggplot2)
ui <- fluidPage(
  titlePanel("Decide what to eat!"),
  sidebarLayout(
    sidebarPanel(
      fluidRow(column(12, "Select cuisine(s):")),
      fluidRow(column(6, checkboxGroupInput(
                             inputId = "CuisineFinder1",
                             label = "",
                             choices = c("Brazilian" = "brazilian", 
                                         "British" = "british",
                                         "Cajun Creole" = "cajun_creole",
                                         "Chinese" = "chinese",
                                         "Filipino" = "filipino",
                                         "French" = "french",
                                         "Greek" = "greek", 
                                         "Indian" = "indian",
                                         "Irish" = "irish", 
                                         "Italian" = "italian"),
                             selected = "british")),
             column(6, checkboxGroupInput(
                             inputId = "CuisineFinder2",
                             label = "",
                             choices = c("Jamaican" = "jamaican", 
                                         "Japanese" = "japanese", 
                                         "Korean" = "korean", 
                                         "Mexican" = "mexican",
                                         "Moroccan" = "moroccan", 
                                         "Russian" = "russian",
                                         "Southern US" = "southern_us",
                                         "Spanish" = "spanish",
                                         "Thai" = "thai",
                                         "Vietnamese" = "vietnamese"),
                             selected = "jamaican")
      )
    )),
    mainPanel(
      plotOutput("cuisinePlot")
    )
  )
)
server <- function(input, output){
  output$cuisinePlot <- renderPlot({
    input$CuisineFinder1
    input$CuisineFinder2
    CuisineFinder <- c(input$CuisineFinder1, input$CuisineFinder2)
    selected_cusine_df <- cuisine_count_df[which(cuisine_count_df$cuisine %in% CuisineFinder),]
    ggplot(selected_cusine_df, aes(y = Freq, x = cuisine, fill = cuisine)) + 
      geom_bar(position="stack", stat="identity") +
      ggtitle("Selected Cuisine") +
      xlab("")
    })
}
shinyApp(ui, server)

