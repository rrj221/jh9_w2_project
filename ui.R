#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Add Your Business"),
  titlePanel("Today is July 24, 2019"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("busName",
                 "Business Name",
                 value = "McDonalds"
                 ),
       textInput("lat",
                 "Latitue",
                 value = "44"
       ),
       textInput("long",
                 "Longitude",
                 value = "-77"
       ),
       textInput("websiteURL",
                 "Website URL",
                 value = "www.mcdonalds.com"
       ),
       selectInput("busType","Business Type",
                   c("Restaurant" = "restaurant",
                     "Clothing Store" = "clothingStore",
                     "Legal Services" = "legal",
                     "Gym" = "gym",
                     "Drug Store" = "drugs",
                     "General Store" = "general")),
       submitButton("Add Business")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
