#Libraries----
library(shiny)
library(shinyAce)
library(shinyjs)
library(shinythemes)

#Theme selection----
themes <- getAceThemes()

#UI----
shinyUI(
    fluidPage(
        useShinyjs(),
        title = "ShinyMail",
        theme = shinytheme("spacelab"),
        
        headerPanel(title = "ShinyMail"),
        
        sidebarLayout(
            sidebarPanel(
                width = 3,
                
                #Login----
                h5("Enter you email credentials", style = "font-weight: bolder;"),
                
                textInput(
                    inputId = "user",
                    label = "Username:",
                    placeholder = "Enter your username"
                ),
                
                passwordInput(
                    inputId = "password",
                    label = "Enter password:",
                    placeholder = "Enter your password"
                ),
                
                textInput(
                    inputId = "name",
                    label = "Your name:",
                    placeholder = "Enter your display name here"
                ),
                
                fluidRow(column(width = 4,
                                div(
                                    actionButton(
                                        inputId = "confirm",
                                        label = "Confirm",
                                        icon = icon("fas fa-user-check"),
                                        class = "btn-primary"
                                    ), style = "padding-bottom: 1.5%;"
                                )),
                         column(
                             width = 2,
                             actionButton(
                                 inputId = "edit",
                                 label = "Edit",
                                 icon = icon("fas fa-edit"),
                                 class = "btn-warning"
                             )
                         )),
                
                HTML("<hr />"),
                
                #Sender address and message details----
                textInput(
                    inputId = "to",
                    label = "Enter recipient's address:",
                    value = "to@gmail.com",
                    placeholder = "Enter recipient's email id"
                ),
                
                textInput(
                    inputId = "subject",
                    label = "Subject:",
                    placeholder = "Provide mail subject here"
                ),
                
                actionButton(
                    inputId = "send",
                    label = "Send mail",
                    class = "btn-success",
                    icon = icon("fas fa-envelope")
                ),
                
                #Editor customizations----
                HTML("<hr />"),
                
                h5("Editor customizations", style = "font-weight: bolder;"),
                
                selectInput(
                    "theme",
                    "Select theme: ",
                    choices = themes,
                    selected = "ambience"
                ),
                
                fluidRow(
                    column(width = 6,
                           numericInput(
                               "fontsize", "Font size:", value = 12, min = 1
                           )),
                    column(width = 6,
                           numericInput("size", "Tab size:", 4))
                ),
                
                radioButtons("soft", NULL, c(
                    "Soft tabs" = TRUE, "Hard tabs" = FALSE
                ), inline = TRUE),
                
                radioButtons(
                    "invisible",
                    NULL,
                    c("Hide invisibles" = FALSE, "Show invisibles" = TRUE),
                    inline = TRUE
                )
                
            ),
            
            mainPanel(
                div(
                aceEditor(outputId = "message", value = "write message here"),
                actionButton("clear", "Clear text", class = "btn-danger", style = "margin-bottom:2rem;")
            )
            )
        )
        
    )
)