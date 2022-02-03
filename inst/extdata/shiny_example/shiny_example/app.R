#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(diffr2)
library(DT)
library(shiny)

git_log <- gert::git_log()

# Define UI for application that shows the ten latest commits
ui <- fluidPage(

  # Application title
  titlePanel("shiny_example"),

  # Sidebar with a slider input for 1 to 10 commits
  sidebarLayout(
    sidebarPanel(
      sliderInput("refs",
                  "ref:",
                  min = 1,
                  max = 10,
                  value = 1)
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("git", DTOutput("git_log")),
        tabPanel("diff", diffr2::diffr2Output("git_diff"))
      )
    )

  )
)

# Define server logic required to draw diffr2
server <- function(input, output) {

  output$git_log <- renderDT({
    git_log[input$refs,]
  })

  output$git_diff <- diffr2::renderDiffr2(
    diffr2(diff = paste(
      gert::git_diff_patch(
        ref = git_log$commit[input$refs],
        repo = "."),
      collapse = "\n"),
      outputFormat = "side-by-side",
      divname = 'git_diff')
  )
}

# Run the application
shinyApp(ui = ui, server = server)
