        #abrindo os dados------------------------------
        
        library(jsonlite)
        library(tidyverse)
        library(tidytext)
        library(stringr)
        library(caret)
        library(tm)
        
        url <- c("https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1990.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1991.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1992.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1993.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1994.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1995.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1996.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1997.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1998.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema1999.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2000.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2001.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2002.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2003.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2004.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2005.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2006.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2007.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2008.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2009.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2010.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2011.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2012.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2013.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2014.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2015.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2016.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2017.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2018.json",
                 "https://raw.githubusercontent.com/rodrimoni/ProjetoFinalCursoDeVerao/master/data/deputados/propComTemas/PropComTema2019.json")
        
        
        df <- data.frame()
        
        # os dados foram baixados em json porque era melhor e mais leve, sem seguida os anos foram mesclados
        # e colocados todos juntos em um data frame, em que o total ficou em 61.717 observações 
        # indice, as palavras chaves e o tema 
        
        yrs <- 1990:2019
        
        for (i in 1:30) {
                if(i == 1){
                        arch <- fromJSON(url[i])
                        dfAux <- as.data.frame(cbind(arch, year = yrs[i]))
                        df <- dfAux
                } else {
                        arch <- fromJSON(url[i])
                        dfAux <- as.data.frame(cbind(arch, year = yrs[i]))
                        df <- merge(df, dfAux, all = TRUE)
                }
        }
        
        
        
        (congress_tokens <- df %>%
            unnest_tokens(output = word, input = keywords) %>%
            # remove numbers
            #filter(!str_detect(word, "^[0-9]*$")) %>%
            # remove stop words
            anti_join(data.frame(word = stopwords("pt-br")), by = "word"))# %>%
            # stem the words
            #mutate(word = SnowballC::wordStem(word)))
        
        (congress_dtm <- congress_tokens %>%
                # get count of each token in each document
                count(index, word) %>%
                # create a document-term matrix with all features and tf weighting
                cast_dtm(document = index, term = word, value = n))
        
        congress_dtm <- removeSparseTerms(congress_dtm, sparse = .99)
        dados <- as.data.frame(as.matrix(congress_dtm))
        dados$tema <- as.factor(df$tema[-56503])
        
        aux <- row.names(dados)
        only <- df$index[!df$index %in% aux] 
        which(df$index == only)
        
        
        set.seed(1234)
        index <- sample(1:length(dados$financeira), 0.7*length(dados$financeira))
        train <- dados[index,]
        test <- dados[-index,]

library(h2o)

h2o.init(jvm_custom_args = '-Dsys.ai.h2o.ext.core.toggle.XGBoost=False')        

train <- as.h2o(train)
test <- as.h2o(test)

gbm <- h2o.gbm(x = 1:357, y = 358, training_frame = train, ntrees = 200, distribution = "multinomial")

perfgbm <- h2o.performance(gbm, test)         

rf <- h2o.randomForest(x = 1:357, y = 358, training_frame = train, ntrees = 200, distribution = "multinomial")

perfrf <- h2o.performance(rf, test)    

glm <- h2o.glm(family= "multinomial", x = 1:357, y = 358, training_frame=train, lambda = 0)

perfglm <- h2o.performance(glm, test)  
