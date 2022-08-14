# Projet de Visualisation (Master 2 IMSD)
#
# Par :
# KHATBANE Mohammed
# Kassa-sombo Arthur
#----------------------------
library(shiny)
library(ggplot2)
library(lubridate)
library(shinydashboard)
library(shinydashboard)
#-------- IL FAUT CHANGER LE CHEMIN ICI ET DANS LE FICHIER server.R AUSSI ----------####
#-----------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-----------------------------------#

df <- read.csv("/Users/mohammedkhatbane/Documents/M2/Visualisation/Projet_vis/RShiny/data_vis.csv", row.names = 1)
df$Time <- as.POSIXct(df$Time,format="%Y-%m-%d %H.%M.%S")
#---------------------------------------------------------------------------------#   
ui <- dashboardPage(
    dashboardHeader(title = "Air Quality"),
    
    dashboardSidebar(
            sidebarMenu(
                menuItem("Informations", tabName = "information", icon = icon("dashboard")),
                menuItem("Corrélations", tabName = "correlations", icon = icon("th")),
                menuItem("Analyse uni-variée", tabName = "univarie", icon = icon("th")),
                menuItem("Analyse bi-variée", tabName = "bivarie", icon = icon("th")),
                menuItem("Évolution dans le temps", tabName = "evolution", icon = icon("th"))
               # menuItem("Prédiction", tabName = "pred", icon = icon("th"))
            )
        ),
    
    dashboardBody(
        tabItems(
            # Analyse uni-variée :
            
            tabItem(tabName = "univarie",
                    fluidRow(
                        
                
                               box(id = 'univariate_select',selectInput("univariate_datatype",label = "Sélectionnez la variable à visualiser : ",
                                                                        names(df)[-1]),width = 2),
                        box(plotOutput("plot1", height = 400, width = 700)),
                        column(width = 2, offset = 2,
                               sliderInput("slider", "bins :", 1, 200, 150))
                        
                        )
                    
            ),
            
            # Analyse bi-variée
            
            tabItem(tabName = "bivarie",
                    fluidRow(
                        box(id = 'bivariate_select', checkboxGroupInput('bivariate_datatype', label = 'Sélectionnez deux variables à visualiser :',
                                                                        names(df)[-1], selected = c("PT08.S1.CO.", "NOx.GT.")), width = 2),
                        box(plotOutput("plot2", height = 500, width = 700), width = 9)
                    
            )),
            
            # évolution dans le temps
            
            tabItem(tabName = "evolution",
                    fluidRow(
                        
                        box(id = 'evol_select',selectInput("evol",label = "Sélectionnez la variable à visualiser : ",
                                                                 names(df)[-1]),width = 2),
                        box(plotOutput("plot4", height = 400, width = 700))
                        
                    )),
                    
            
                    
            
            # Présentation du dataset
            
            tabItem(tabName = "information",
                    h2("Présentation du jeu de données"),
                    textOutput("text1")
            ),
            
            # Corrélations
            
            tabItem(tabName = "correlations",
                    h2("Correlation Matrix"),
                    fluidRow(
                        box(id = 'corr_select', checkboxGroupInput('corr', label = 'Sélectionnez les variables :',
                                                                        names(df)[-1], width = '500px', selected = c("RH","AH","T","CO.GT.", "NOx.GT.")), width = 2),
                        box(plotOutput("plot3", height = 500, width = 800), width = 10))
                    )
            
            
))
)