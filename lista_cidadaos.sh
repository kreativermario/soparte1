#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
## Nome do Módulo: lista_cidadaos.sh
## Descrição/Explicação do Módulo: Cria uma lista de cidadãos para serem vacinados num ficheiro cidadaos.txt
###############################################################################


if [ ! -f listagem.txt ]; then							#Se o ficheiro listagem.txt não estiver presente, o script irá dar um erro
	echo "Erro: ficheiro listagem.txt não existe!"
	exit -1
fi


i=1														#Ciclo while que vai até ao valor do número de linhas do ficheiro listagem.txt

while [ $i -le "$( wc -l < listagem.txt )" ]; do
	birthdate=$(cut -d '|' -f2 listagem.txt | awk -F[:] '{print $2}' | awk 'NR=='$i'' | sed 's/\s*$//g') #Regista a data de nascimento dd-mm-yyyy
	byear=10#${birthdate:6:4}				#Regista o ano de nascimento
	cyear=2021								#Regista o ano 2021
	let	age=cyear-byear						#Calcula a idade 2021 - ano
	
	echo "$((10000+$i)):$(awk -F[:] '{print $2}' listagem.txt | cut -d '|' -f1 | awk 'NR=='$i'' | sed 's/\s*$//g'):$age:$(awk -F[:] '{print $4}' listagem.txt | cut -d '|' -f1 | awk 'NR=='$i'' | sed 's/\s*$//g'):$(awk -F[:] '{print $5}' listagem.txt | awk 'NR=='$i'' | sed 's/\s*$//g'):0" 
						 #Dá print linha a linha de acordo com a variavel i <número de utente>:<nome>:<idade>:<localidade>:<nº telemóvel>:<estado vacinação>
	i=$(( $i+1 ))		#variável i que controla quais linhas a imprimir (através dos comandos awk 'NR=='$i'')
 done >cidadaos.txt     #Redireciona o output todo do ciclo para o ficheiro cidadaos.txt (e substituir se existir)
cat cidadaos.txt        #Print da lista de cidadãos
echo -e "\n\n Script executado com sucesso"

