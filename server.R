
# load necessary libraries
library(shiny)
library(tm)
library(knitr)
library(R.utils)
library(devtools)
library(tau)
library(tictoc)


#Next, we will load the data and read in the necessary files.

load("unibitriDF.RData")
load("unibiDF.RData")


cleanit<-function(chrfile)  {
cleaned <- tolower(chrfile)
cleaned<-removePunctuation(cleaned)
cleaned<-removeNumbers(cleaned)
FCCbadwords<-c("fuck", "shit", "piss", "cunt", "cocksucker", "motherfucker", "tits")
cleaned <- removeWords(cleaned, FCCbadwords)
cleaned <- stripWhitespace(cleaned)
return(cleaned)
}


numberofwords<-function(str1) {
words <- sapply(gregexpr("[[:alpha:]]+", str1), function(x) sum(x > 0))
return(words)
}


predicttri<-function(word2, word1) {
trisubDF<-unibitriDF[unibitriDF$FirstWord==word1 & unibitriDF$SecondWord==word2,] 
ordtrisubDF<-trisubDF[order(trisubDF$TriProb, decreasing=TRUE),]
ordtop5<-ordtrisubDF[1:5,]
finaltri<-ordtop5[complete.cases(ordtop5),]
return(finaltri$ThirdWord)
}

predictbi<-function(wordb) {
bisubDF<-unibiDF[unibiDF$FirstWord==wordb,] 
ordbisubDF<-bisubDF[order(bisubDF$BiProb, decreasing=TRUE),]
ordbitop5<-ordbisubDF[1:5,]
finalbi<-ordbitop5[complete.cases(ordbitop5),]
return(finalbi$SecondWord)
}

predictor<-function(worddeux, wordun) {
  testword1<-unibitriDF$FirstWord==wordun
  testword2<-unibitriDF$SecondWord==worddeux
  testword3<-unibiDF$FirstWord==worddeux
  if ((sum(testword1)>0) & (sum(testword2)>0)) {
    predword<-predicttri(worddeux,wordun)
     } else if (sum(testword3)>0) {
        predword<-predictbi(worddeux)
     } else predword<-"NO MATCHES FOUND"
}

shinyServer(
  function(input,output) {
    input2 <- reactive(as.character(cleanit(input$inputtext)))
    n<-reactive(as.numeric(numberofwords(input2())))
    inputword2<-reactive(as.character(sapply(strsplit(input2(), ' '), function(a) a[n()])))
    inputword1<-reactive(as.character(sapply(strsplit(input2(), ' '), function(a) a[n()-1])))
    output$predword<-renderText({predictor(inputword2(),inputword1())})
   }
)





