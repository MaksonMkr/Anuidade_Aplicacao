library(shiny)

ui <- fluidPage(

    titlePanel("Calculadora de Anuidade"),
    
    sidebarLayout(
      
      sidebarPanel(
        selectInput("calculo", "Tipo de cálculo:", 
                    choices = list("Valor Presente" = "PV", 
                                   "Valor Futuro" = "FV")),
        
        selectInput("tipo", "Tipo de anuidade:", 
                    choices = list("Postecipada" = "postecipada", 
                                   "Antecipada" = "antecipada", 
                                   "Com Carência" = "carencia")),
        
        numericInput("R", "Valor do pagamento periódico (R):", 
                     value = 1000, min = 0, step = 0.01),
        
        numericInput("i", "Taxa de juros por período (%):", 
                     value = 1, min = 0, step = 0.01),
        
        numericInput("n", "Número de períodos (n):", 
                     value = 12, min = 1, step = 1),
        
        conditionalPanel(
          condition = "input.tipo == 'carencia'",
          numericInput("carencia", "Período de carência (em períodos):", 
                       value = 0, min = 0, step = 1)
        ),
        
        actionButton("calcular", "Calcular", class = "btn-success")
      ),
      
      mainPanel(
        h3("Resultado:"),
        verbatimTextOutput("resultado")
      )
    )
    
)


#rsconnect::deployApp(".")
  
