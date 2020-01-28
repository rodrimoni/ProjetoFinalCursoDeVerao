require(RSelenium)
require(XML)

driver  <- rsDriver(port = 4603L, 
                    browser = c('chrome'), # navegador usado
                    chromever = "78.0.3904.105") # versao 


url = 'http://www.camarapoa.rs.gov.br/projetos'

remDr <- driver[['client']]
remDr$navigate(url) # site
Sys.sleep(3) 

# os tipos de projetos: 

# PLCE, PLL, PDL, PELO, PLCL, PLE e PP

ord_proj <- c('PLCE', 'PLL', 'PDL', 'PELO', 'PLCL', 'PLE', 'PP')

projs <- c('//*[@id="processos"]/div/div[1]/form/div[2]/div[1]/div/div/div[2]/div[7]',
           '//*[@id="processos"]/div/div[1]/form/div[2]/div[1]/div/div/div[2]/div[10]',
           '//*[@id="processos"]/div/div[1]/form/div[2]/div[1]/div/div/div[2]/div[4]',
           '//*[@id="processos"]/div/div[1]/form/div[2]/div[1]/div/div/div[2]/div[5]',
           '//*[@id="processos"]/div/div[1]/form/div[2]/div[1]/div/div/div[2]/div[8]',
           '//*[@id="processos"]/div/div[1]/form/div[2]/div[1]/div/div/div[2]/div[9]',
           '//*[@id="processos"]/div/div[1]/form/div[2]/div[1]/div/div/div[2]/div[11]')


#------ colocar um for aqui

#for(pr in 1:length(projs)){

titulos <- list()
desc <- list()
otr <- list()

# abrir as opções de projeto
webElem <- remDr$findElement(using = "xpath", 
                             value = '//*[@id="processos"]/div/div[1]/form/div[2]/div[1]/div/div/i[2]')
webElem$clickElement()

# escolher uma opção 
webElem <- remDr$findElement(using = "xpath", value = projs[1])
webElem$clickElement()

# clicar em buscar 
webElem <- remDr$findElement(using = "xpath", 
                             value = '//*[@id="processos"]/div/div[1]/form/div[2]/div[4]/div/button')
webElem$clickElement()
Sys.sleep(3) 

# agora como pegar os textos
############################################

# descobrindo quantos registros tem: 
webElem <- remDr$findElement(using = "xpath", value = '//*[@id="status-pagina"]/strong[2]')
temp <- webElem$getElementText()
pags <- ceiling((as.numeric(temp)/20))
navBar <-  remDr$findElement(using = "xpath", value = '//*[@id="processos"]/div/div[1]/div/div[2]/div[2]/div[1]')

cont = 1 

for(j in 1:pags){ 
  
  Sys.sleep(1) 
  
  # codigo pra saber que na ultima pagina tem que acabar antes do 10
  allArticlesPerPage <- remDr$findElements(using = "css selector", value = paste0(".lista .items article.item"))
  per_page <- length(allArticlesPerPage)
  
  for(i in 1:per_page){
    # os titulos:
    webElem <- remDr$findElement(using = "xpath", 
      value = paste0('//*[@id="processos"]/div/div[1]/div/div[2]/div[2]/section/article[',i,']/div/h2'))
    titulos[[cont]] <- webElem$getElementText()
  
    # descrição
    webElem <- remDr$findElement(using = "xpath", 
      value = paste0('//*[@id="processos"]/div/div[1]/div/div[2]/div[2]/section/article[',i,']/div/div[1]'))
    desc[[cont]] <- webElem$getElementText()
  
    # autor
    webElem <- remDr$findElement(using = "xpath", 
      value = paste0('//*[@id="processos"]/div/div[1]/div/div[2]/div[2]/section/article[',i,']/div/div[2]'))
    otr[[cont]] <- webElem$getElementText()
  
    cont = cont + 1
  }
  
  # proximo
  webElem <- remDr$findElement(using = "link text", 
                value = paste0(toString(j + 1)))
  webElem$clickElement()
  Sys.sleep(5) 
}

aux <- data.frame(tit_projeto = unlist(titulos), 
                  descricao = unlist(desc), 
                  autor_situacao = unlist(otr))

write.table(x = aux, file = paste0(ord_proj[1], '.txt'))

#}
