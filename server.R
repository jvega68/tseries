#Autor: Jorge de la Vega.
#Fecha: Marz 2014
library(shiny)
shinyServer(function(input, output){
         output$tsplot <- renderPlot({
            serie <- ts(scan(input$dataset$datapath, what = "numeric"))
            serie.mean <- mean(as.numeric(serie))
            serie.var  <- var(as.numeric(serie))
            serie.min <- min(as.numeric(serie))
            serie.max <- max(as.numeric(serie))
            n <- length(as.numeric(serie))
            str1 <- paste("mean:", serie.mean)
            str2 <- paste("var:", serie.var)
            str3 <- paste("min:", serie.min)
            str4 <- paste("max:", serie.max)
            str5 <- paste("Num. Observations:", n)
            ncase <- as.character(sum(as.numeric(input$checkGroup)))
            po <- input$points
            switch(ncase,
                "1" = {ts.plot(serie, main="Serie", ylab = "x", xlab = "time", col="blue")
                       if(po=="1") points(as.numeric(serie),pch=16,cex=0.5)
                       abline(h=serie.mean, col="red",lwd=2)
                       abline(h=serie.mean + c(-1,1)*sqrt(serie.var), col="red",lty=2,lwd=2)},
           
                "2" = {acf(as.numeric(serie), main = "acf")},
            
                "4" = {pacf(as.numeric(serie), main = "pacf")},
           
                "3" = {par(mfcol = c(2,1))
                  ts.plot(serie, main="Serie", ylab = "x", xlab = "time", col="blue")
                  if(po=="1") points(as.numeric(serie),pch=16,cex=0.5)
                  abline(h=serie.mean, col="red",lwd=2)
                  abline(h=serie.mean + c(-1,1)*sqrt(serie.var), col="red",lty=2,lwd=2)
                  acf(as.numeric(serie), main = "acf")},
           
                "5" = {par(mfcol = c(2,1))
                  ts.plot(serie, main="Serie", ylab = "x", xlab = "time", col="blue")
                  if(po=="1") points(as.numeric(serie),pch=16,cex=0.5)
                  abline(h=serie.mean, col="red",lwd=2)
                  abline(h=serie.mean + c(-1,1)*sqrt(serie.var), col="red",lty=2,lwd=2)
                  pacf(as.numeric(serie), main = "pacf")},
           
                "6" = {par(mfcol = c(2,1))
                  acf(as.numeric(serie), main = "acf")
                  pacf(as.numeric(serie), main = "pacf")},
           
                "7" = {layout(matrix(c(1,1,2,3),ncol=2,byrow=T))
                  ts.plot(serie, main="Serie", ylab = "x", xlab = "time", col="blue")
                  if(po=="1") points(as.numeric(serie),pch=16,cex=0.5)
                  abline(h=serie.mean, col="red",lwd=2)
                  abline(h=serie.mean + c(-1,1)*sqrt(serie.var), col="red",lty=2,lwd=2)
                  acf(as.numeric(serie), main = "acf")
                  pacf(as.numeric(serie), main = "pacf")}
            )
            output$text <- renderText({paste(str1, str2, str3, str4, str5,sep="</br>")})
        })
    })