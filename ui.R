shinyUI(fluidPage(
    h3("Capstone Project in Data Science (Specialization by JHU and Coursera)"),
    h4("Predicting the next word"),
    # sidebarPanel(
    radioButtons("radio", label = h3(""),
                 choices = list("Use all words" = 1, "Remove stopwords" = 2), 
                 selected = 1),
    hr(),
    
    textInput("text", label = h3("Text input"), value = ""),
    numericInput("number", label = h3("Number of suggestions"), value = 5),
    submitButton("Submit!"),
    hr(),
    fluidRow(column(4, verbatimTextOutput("value")))
#   tabPanel("Documentation",includeHTML("documentation.html"))
#     numericInput("numberSuggestion", label = h4("Please enter the number of suggestion to be added to the original text"), value = ""),
#     submitButton("Add word!"),
#     hr()
#)
))