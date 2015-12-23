library(shiny)
shinyUI(
  pageWithSidebar(
  headerPanel("Major League Baseball Win Predictor"),
  sidebarPanel(
    h4('This is a function that allows you to predict the number of wins for a US Major League baseball team.'),
    h4('The prediction is based on your input of a key statistic for batting, pitching and fielding, the three major areas of the game.'),
    h4('The prediction function is based on statistics from the 2015 MLB season'),
    numericInput('OPS', 'Enter Team OPS (onbase pct. for hitters plus slugging, from 0.670 to 0.800)', 0.670, min=0.670, max=0.8, step=0.001),
    submitButton('Submit'),
    numericInput('ERA', 'Enter Team ERA (earned run average for pitchers, from 2.90 to 5.10)', 5.10, min=2.90, max=5.10, step=0.01),
    submitButton('Submit'),
    numericInput('DEF', 'Enter Team Defensive Efficiency (defensive efficiency, from 0.665 to 0.710)', 0.665, min=0.665, max=0.710, step=0.001),
    submitButton('Submit')
    ),
  mainPanel(
    h3('Your hypothetical team is predicted to win the following number of games:'),
    verbatimTextOutput("prediction")
    )
   )
  )