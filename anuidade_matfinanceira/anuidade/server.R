library(shiny)

server <- function(input, output) {
  
  resultado <- reactive({
    input$calcular 
    
    isolate({
      
      R <- input$R
      i <- input$i / 100  
      n <- input$n
      
      carencia <- ifelse(is.null(input$carencia), 
                         0, input$carencia)
      
      if (input$calculo == "PV") {
        
        if (input$tipo == "postecipada") {
          # Fórmula para Valor Presente de Anuidade Postecipada
          PV <- R * (1 - (1 + i)^-n) / i
        } else if (input$tipo == "antecipada") {
          # Fórmula para Valor Presente de Anuidade Antecipada
          PV <- R * (1 - (1 + i)^-n) / i * (1 + i)
        } else if (input$tipo == "carencia") {
          # Fórmula para Valor Presente de Anuidade com Carência
          PV <- R * (1 - (1 + i)^-n) / i / (1 + i)^carencia
        }
        
        return(paste("O Valor Presente da anuidade é: R$", round(PV, 2)))
      }
      
      else if (input$calculo == "FV") {
        
        if (input$tipo == "postecipada") {
          # Fórmula para Valor Futuro de Anuidade Postecipada
          FV <- R * ((1 + i)^n - 1) / i
        } else if (input$tipo == "antecipada") {
          # Fórmula para Valor Futuro de Anuidade Antecipada
          FV <- R * ((1 + i)^n - 1) / i * (1 + i)
        } else if (input$tipo == "carencia") {
          # Fórmula para Valor Futuro de Anuidade com Carência
          FV <- R * ((1 + i)^n - 1) / i * (1 + i)^carencia
        }
        
        return(paste("O Valor Futuro da anuidade é: R$", round(FV, 2)))
      }
    })
    
  })
  
  output$resultado <- renderText({
    
    if(input$calcular == 0){
      print("Por favor, digite os valores ao lado e clique em consultar.")
    }else{
      resultado()
    }
    
  })
  
}
