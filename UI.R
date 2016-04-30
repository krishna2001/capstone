library(shiny) 
shinyUI(pageWithSidebar( 
     headerPanel("The Predictor"), 
     sidebarPanel( 
         h4('This is a function that allows you to predict the next word based on your inputed text.'), 
         h4('The prediction is based on a large grouping of news articles, blogs and twitter posts.'), 
         h4('The prediction function will "clean" your text, removing punctuation, whitespace, numbers and profanity for accuracy.'), 
         h4('Note that very common words like THE have been removed.'), 
         h4('Your initial attempt may take a moment while the files load.  Thank you for your patience.'), 
         textInput("inputtext", label=h3("Enter Your Text Here"), value="Happy Mother's"), 
         submitButton('Submit') 
         ), 
     mainPanel( 
         h3('The top predictions for the Next Word are',style="color:red"), 
         verbatimTextOutput("predword") 
         ) 
      ) 
     ) 
