# server.R
library("seqinr")

shinyServer(function(input, output) {
  
   
  nbsum1 <-  reactive({
    
    if(!is.null(input$file1)){
      infile <- input$file1
      sqf <- read.fasta( infile$datapath)
      nbsum <- vector( mode="integer", length=2000)
      
      for( i in 1:length(sqf)){
        for( j in 1:length( getSequence(sqf[[i]]))){
          if( getSequence(sqf[[i]])[j] == "n") nbsum[j] <- nbsum[j] + 1
        }
      }
      nbsum
    }
    
  }) 
  
  
  nbsum2 <-  reactive({
    
    if(!is.null(input$file2)){
      infile <- input$file2
      sqf <- read.fasta( infile$datapath)
      nbsum <- vector( mode="integer", length=2000)
      
      for( i in 1:length(sqf)){
        for( j in 1:length( getSequence(sqf[[i]]))){
          if( getSequence(sqf[[i]])[j] == "n") nbsum[j] <- nbsum[j] + 1
        }
      }
      nbsum
    }
    
  }) 
  

  output$downloadF <- downloadHandler(
      filename <- function() {
          paste("back", "txt", sep=".")
      },
      
      content <- function(file) {
          file.copy("back.txt", file)
      })    
  
  
  output$downloadR <- downloadHandler(
      filename <- function() {
          paste("for", "txt", sep=".")
      },
      
      content <- function(file) {
          file.copy("for.txt", file)
      })    
  
  
  output$plot1 <- renderPlot({
    #input$action
    nbsumf <- nbsum1()
    nbsumr <- nbsum2()
    x <- 1:1200

    if ( (!is.null(nbsumf))&(!is.null(nbsumr))){
        plot(nbsumf[x], xlab="Nucleotide Index", ylab="Count")
        points(nbsumr[x], col="red")
    }else{
        if(!is.null(nbsumf)){
             plot(nbsumf[x], xlab="Nucleotide Index", ylab="Count")
         }else{
             if(!is.null(nbsumr)){
                 plot(nbsumr[x], xlab="Nucleotide Index", ylab="Count", col="red")
                 }
        }
    }
    
    
  })  
  
   
})





