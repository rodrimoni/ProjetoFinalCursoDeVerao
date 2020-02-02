import os
import requests
import json

# Função para fazer download das URLs da Câmara dos deputados
# Consutlar: https://dadosabertos.camara.leg.br/swagger/api.html#staticfile
def url_response(url):
    path, url = url
    r = requests.get(url, stream = True)
    with open(path, 'wb') as f:
        for ch in r:
            f.write(ch)
			
# Criando os diretórios de proposições e temas
pathProposicoes = "proposicoes"
pathTemas = "temas"

try:
    os.mkdir(pathProposicoes)
except OSError:
    print ("Criacao do diretorio %s falhou" % pathProposicoes)
else:
    print ("Criacao do diretorio %s com sucesso" % pathProposicoes)
			
try:
    os.mkdir(pathTemas)
except OSError:
    print ("Criacao do diretorio %s falhou" % pathTemas)
else:
    print ("Criacao do diretorio %s com sucesso" % pathTemas)
			
# Anos selecionados 1990 - 2019
years = [x for x in range(1990, 2020)]		

# Laço que realiza download dos arquivos de propostas por ANO
for x in years:
	url_response (('proposicoes/Ano' + str(x) + '.json', 'http://dadosabertos.camara.leg.br/arquivos/proposicoes/json/proposicoes-' + str(x) + '.json'))

# Remover toda informações das Propostas que não são significantes para nossa análise
# Cria um dicionário com o que realmente importa, cria um novo arquivo e sobrescreve o arquivo original

for x in years:
	result = []
	
	with open('proposicoes/Ano' + str(x) + '.json', encoding = "utf8") as data_file:
		data = json.load(data_file)

	for element in data['dados']:
		myDict = {}
		myDict['siglaTipo'] = element['siglaTipo']
		myDict['numero'] = element['numero']
		myDict['ano'] = element['ano']
		myDict['descricaoTipo'] = element['descricaoTipo']
		myDict['ementa'] = element['ementa']
		myDict['ementaDetalhada'] = element['ementaDetalhada']
		myDict['keywords'] = element['keywords']
		result.append(myDict)

	with open('proposicoes/Ano' + str(x) + '.json', 'w') as data_file:
		data = json.dump(result, data_file, ensure_ascii = False)
		
# Laço que realiza download dos arquivos de propostas com seus respectivos temas por ANO
for x in years:
	url_response (('temas/TemasAno' + str(x) + '.json', 'http://dadosabertos.camara.leg.br/arquivos/proposicoesTemas/json/proposicoesTemas-' + str(x) + '.json'))