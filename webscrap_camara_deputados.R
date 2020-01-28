require(RSelenium)
require(XML)

driver  <- rsDriver(port = 4606L, 
                    browser = c('chrome'), # navegador usado
                    chromever = "78.0.3904.70") # versao 

yrs <- 1934:2019

url_prop <- url_tema <- vector()

for (i in 1:length(yrs)){
  url_prop[i] <- paste0('http://dadosabertos.camara.leg.br/arquivos/proposicoes/xlsx/proposicoes-', 
                     yrs[i], '.xlsx')
  
  url_tema[i] <- paste0('http://dadosabertos.camara.leg.br/arquivos/proposicoesTemas/xlsx/proposicoesTemas-', 
                     yrs[i], '.xlsx')
}


for (j in 1:length(yrs)){
  
  url = url_prop[j]
  
  remDr <- driver[['client']]
  remDr$navigate(url) # site
  Sys.sleep(3) 
  
}


for (j in 1:length(yrs)){
  
  url = url_tema[j]
  
  remDr <- driver[['client']]
  remDr$navigate(url) # site
  Sys.sleep(3) 
  
}

