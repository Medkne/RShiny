# Projet de Visualisation (Master 2 IMSD)
#
# Par :
# KHATBANE Mohammed
# Kassa-sombo Arthur
#----------------------


library(corrplot)
library(shiny)
library(ggplot2)
library(lubridate)
library(shinydashboard)
server <- function(input, output) {

  
  #-------- IL FAUT CHANGER LE CHEMIN ICI ET DANS LE FICHIER ui.R AUSSI ----------####
  #-----------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-----------------------------------#
      df <- read.csv("/Users/mohammedkhatbane/Documents/M2/Visualisation/Projet_vis/RShiny/data_vis.csv", row.names = 1)
      # Conversion de temps
      df$Time <- as.POSIXct(df$Time,format="%Y-%m-%d %H.%M.%S")
  #---------------------------------------------------------------------------------# 
      
      
      #uni-varié
      output$plot1 <- renderPlot({
        var <- input$univariate_datatype
        ggplot(data = df, aes(x = df[, var]))+
          geom_histogram(color = "blue", fill = "white", bins = input$slider)+
          labs(title=paste("Distribution de la variable", var),
               x = "", y = "effectif")+ theme_minimal()
      })

    
    
    output$plot2 <- renderPlot({
      var1 <- input$bivariate_datatype[1]
      var2 <- input$bivariate_datatype[2]
      ggplot(data = df, aes(x = df[,var1], y = df[, var2]))+
        geom_point(color = "blue")+
        labs(title=paste(var2,"en fonction de", var1),
             x = var1, y = var2)+ theme_minimal()
      #   hist(data)
    })
    
    
    # Evolution dans le temps
    
    output$plot4 <- renderPlot({
      var <- input$evol
      ggplot(data = df, aes(x = df[,1], y = df[,var]))+
        geom_line(color = "blue")+
        labs(title=paste("Évolution de", var,"en fonction du temps"),
             x = "Time", y = var)+ theme_minimal()
    })
    
    # Corrélations
    output$plot3 <- renderPlot({
      var <- input$corr
      mcor <- cor(df[,var])
      corrplot(mcor, order="hclust", tl.col="black", tl.srt=45)
      
    })
    
    # Présentation
    
    output$text1 <- renderText(" Le dataset contient 9358 instances de la
                               mesure de la quantité moyenne par heure de 5 
                               oxides métalliques, détectée par un multi 
                               capteur chimique de la qualité de l’air. 
                               L’appareil a été placé sur le terrain dans 
                               une zone très polluée, au niveau de la route, 
                               dans une ville italienne. Les données ont été 
                               relevées de mars 2004 à avril 2005, ce qui 
                               représente la plus grande durée d’enregistrement 
                               de données de ce type.")


    
    
}
