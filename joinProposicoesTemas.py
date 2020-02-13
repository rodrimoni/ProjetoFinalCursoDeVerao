import os
import requests
import json

# Anos selecionados 1990 - 2019
years = [x for x in range(1990, 2020)]

pathPropComTemas = "propComTemas"

try:
    os.mkdir(pathPropComTemas)
except OSError:
    print ("Criacao do diretorio %s falhou" % pathPropComTemas)
else:
    print ("Criacao do diretorio %s com sucesso" % pathPropComTemas)

for x in years:
	result = []
	with open('/home/rodrigo/Documentos/ProjetoFinalCursoDeVerao/data/deputados/temas/TemasAno' + str(x) + '.json', 'r') as data_file:
		temas = json.load(data_file)
	
	temasDict = {}
	for element in temas['dados']:
		tipo = element.get('siglaTipo')
		numero = element.get('numero')
		if (tipo and numero):
			index = str(element['siglaTipo']) + str(element['numero']) + str(x)
			if (index in temasDict):
				temasDict[index] += ". " + element['tema']
			else:
				temasDict[index] = element['tema']
				
	with open('/home/rodrigo/Documentos/ProjetoFinalCursoDeVerao/data/deputados/proposicoes/Ano' + str(x) + '.json', 'r', encoding = "ISO-8859-1") as data_file:
		proposicoes = json.load(data_file)
	
	for element in proposicoes:
		myDict = {}
		index = str(element['siglaTipo']) + str(element['numero']) + str(element['ano'])
		myDict['siglaTipo'] = element['siglaTipo']
		myDict['numero'] = element['numero']
		myDict['ano'] = element['ano']
		myDict['descricaoTipo'] = element['descricaoTipo']
		myDict['ementa'] = element['ementa']
		myDict['ementaDetalhada'] = element['ementaDetalhada']
		myDict['keywords'] = element['keywords']
		if (index in temasDict):
			myDict['tema'] = temasDict[index]
		else:
			myDict['tema'] = ''
			
		result.append(myDict)

	with open('propComTemas/PropComTema' + str(x) + '.json', 'w') as data_file:
		data = json.dump(result, data_file, ensure_ascii = False)
