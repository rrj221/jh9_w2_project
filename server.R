#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)

    businesses <- data.frame(Name = as.character(),
                             Lat = as.numeric(),
                             Long = as.numeric(),
                             website = as.character(),
                             logo = as.character())
    names(businesses) = c("Name", "Lat", "Long", "website", "log")
    
    restaurantIcon <- "https://cdn4.iconfinder.com/data/icons/real-estate-1/512/restaurant-512.png"
    lawFirmIcon <- "https://banner2.kisspng.com/20180319/yxq/kisspng-criminal-defense-lawyer-law-firm-personal-injury-l-legal-scale-icon-photos-good-pix-gallery-5ab03e5c0f0a97.5817540115214997400616.jpg"
    gymIcon <- "https://image.freepik.com/free-icon/gym-dumbbell-black-silhouette_318-50983.jpg"
    drugsIcon <- "https://cdn0.iconfinder.com/data/icons/medical-and-health-3-9/128/Pharmacy-Drugs-Medical-Store-Drugstore-Healthy-Clinic-512.png"
    generalIcon <- "https://imageog.flaticon.com/icons/png/512/33/33558.png?size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF"
    clothingIcon <- "https://cdn1.iconfinder.com/data/icons/buildings-landmarks-2/96/Clothing-Store-512.png"
    
    busIcons <- iconList(
        restaurant = makeIcon(restaurantIcon, iconHeight =  40, iconWidth = 40),
        clothingStore = makeIcon(clothingIcon, iconHeight = 40, iconWidth =  40),
        legal = makeIcon(lawFirmIcon, iconHeight = 40, iconWidth =  40),
        gym = makeIcon(gymIcon, iconHeight = 40, iconWidth =  40),
        drugs = makeIcon(drugsIcon, iconHeight = 40, iconWidth =  40),
        general = makeIcon(generalIcon, iconHeight = 40, iconWidth =  40)
    )
    
    


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    info <- data.frame(
                Name = input$busName, 
                Lat = as.numeric(input$lat), 
                Long = as.numeric(input$long), 
                website = paste("<a href='https://",input$websiteURL,"'>",input$busName,"</a>", sep=""), 
                busType = input$busType)

    businesses <<- rbind(businesses, info)
    

    busWebsiteURLs <- as.character(unlist(businesses[,4]))


    busLatLong <- sp::SpatialPointsDataFrame(
        cbind(
            businesses[,3],  # lng
            businesses[,2]  # lat
        ),
        data.frame(busType = factor(
            businesses[,5]
        ))
    )
    

    busLatLong %>% 
        leaflet() %>%
        addTiles() %>% 
        addMarkers(icon = ~busIcons[busType], popup = busWebsiteURLs)
  })
  
})
