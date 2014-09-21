library(shiny)
# IU para graficas de permanencia 

shinyUI(fluidPage(
  titlePanel(h1("Time Series Analyzer")),
p("The following application provides a very simple analysis to time series, by plotting a sequence of values stored in a file and separaraed by spaces. I also allows to obtain plots of the autocorrelation function (acf), the partial autocorrelation function (pacf) and giving some basic statistics for the series. With the acf and pacf, is easy to determine, for example, if the series is or not stationary." ),
  
p("Initially, there is an error message in the main Panel since the application is waiting for a time series to start the analysis."),
  
p("You have to select a file with extension txt and the data should be stored in that file, separated by lines or by spaces. The file do not need to have a header, and at this point, does not accept missing values"),

p("A test file can be generated with something like:"),

code('write(file="ts.txt",rnorm(200))'),

p(" "),
    sidebarLayout(
      sidebarPanel(h3("Inputs"),fileInput(inputId = "dataset", label = h4("File"), 
                                      multiple = F, accept = "text"),
                            checkboxGroupInput("checkGroup", label = h4("Plotting functions"), 
                                                choices = list("ts" = 1, "acf" = 2, "pacf" = 4), selected = 1),
                            radioButtons("points", label = h4("Include points?"), 
                                                choices = list("yes" = 1, "no" = 2), selected = 2)),
      mainPanel(h3("Graphics and Statistics"),plotOutput(outputId = "tsplot"),
                               htmlOutput(outputId = "text"))
))
)

