library(shiny)
#wins is my prediction function from a regression of MLB 2015 team statistics, wins regressed vs. OPS, ERA and defensive efficiency

wins<-function(h,f,p) {
  74.05019 + (73.65*h) + (40.02*f) + (-0.18658*p)
}

#ERA is in whole number units, so we need to convert this input as a reactive variables

shinyServer(
  function(input,output) {
    pitch<-reactive({as.numeric(input$ERA*100)})
    wp<-reactive(as.numeric(wins(input$OPS, input$DEF, pitch())))
    #round win prediction to 1 decimal place
    wp2<-reactive(as.numeric(round(wp(),1)))
    output$prediction<-renderPrint({wp2()})
   }
)