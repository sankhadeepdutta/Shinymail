#Libraries----
library(shinyAce)
library(emayili)
library(magrittr)
library(curl)
library(shinyWidgets)

#Server----
shinyServer(function(input, output, session) {
    #Set initial conditions----
    showModal(
        modalDialog(
            title = "Attention",
            "This is a basic email client developed in R Shiny. It only accepts gmail account id(s) and for this application to work, the user must turn on 'Less secure app access' feature for the email account.",
            easyClose = TRUE,
            footer = NULL
        )
    )
    
    disable("to")
    disable("subject")
    disable("send")
    
    #User credentials confirmation----
    onclick("confirm", {
        disable("user")
        disable("password")
        disable("confirm")
        enable("to")
        enable("subject")
        enable("send")
    })
    
    #Edit email credentials
    onclick("edit", {
        enable("user")
        enable("password")
        enable("confirm")
        disable("to")
        disable("subject")
        disable("send")
    })
    
    onclick("send", {
        email <- envelope(
            to = input$to,
            from = input$user,
            subject = input$subject,
            text = input$message
        )
        
        smtp <- server(
            host = "smtp.gmail.com",
            port = 465,
            username = input$user,
            password = input$password
        )
        
        tryCatch({
            smtp(email)
            sendSweetAlert(
                session = session,
                title = "Success!",
                text = "You email has been sent successfully!",
                type = "success"
            )
        },
        error = function(e) {
            sendSweetAlert(
                session = session,
                title = "Error!",
                text = e,
                type = "error"
            )
            disable("to")
            disable("subject")
            disable("send")
            enable("confirm")
            enable("user")
            enable("password")
        })

    })
    
    #Editor updates----
    observe({
        updateAceEditor(
            session,
            "message",
            theme = input$theme,
            tabSize = input$size,
            fontSize = input$fontsize,
            useSoftTabs = as.logical(input$soft),
            showInvisibles = as.logical(input$invisible)
        )
    })
    
    observeEvent(input$clear, {
        updateAceEditor(session, "message", value = "")
    })
    
})