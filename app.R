library(shiny)
library(bslib)
library(shinyvalidate)
library(useself)

cat("\nSTARTING SHINY APP, OUTPUT LOG\n")
cat("\nSTARTING SHINY APP, STDERR LOG\n",
    file = stderr())

generate_story <- function(noun, verb, adjective, adverb) {
  cat("\nGENERATE STORY FX, OUTPUT LOG\n")
  cat("\nGENERATE STORY FX, STDERR LOG\n",
      file = stderr())
  glue::glue(
    "
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  "
  )
}

ui <- page_sidebar(
  title = "Mad Libs Game",
  sidebar = sidebar(
    textInput("noun1", "Enter a noun:", ""),
    textInput("verb", "Enter a verb:", ""),
    textInput("adjective", "Enter an adjective:", ""),
    textInput("adverb", "Enter an adverb:", ""),
    actionButton("submit", "Create Story", class = "btn-primary")
  ),
  card(
    card_header("Your Mad Libs Story"),
    card_body(
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  cat("\nSTARTING SERVER FX, OUTPUT LOG\n")
  cat("\nSTARTING SERVER FX, STDERR LOG\n",
      file = stderr())
  story <- eventReactive(input$submit, {
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  output$story <- renderText({
    story()
  })
}

shinyApp(ui = ui, server = server)
