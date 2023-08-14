#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
## Nome do Módulo: stats.sh
## Descrição/Explicação do Módulo: Obtém informações sobre o sistema
###############################################################################


if [ $1 = cidadaos ]; then							#Se o 1º argumento passado for igual a cidadaos
	if [ ! -f "cidadaos.txt" ]; then				#Se o ficheiro cidadaos.txt não existir, emite um erro
		echo "Erro: O ficheiro cidadaos.txt não existe!"
		exit -1
	fi
	if [ $# -ne 2 ]; then							#Se não der dois argumentos cidadaos <localidade>, retornará erro
		echo "Erro: Número de argumentos inválido --> ./stats.sh cidadaos <localidade>"
		exit -2
	fi
	value=$(cut -d":" -f4 cidadaos.txt | grep -w "$2" | wc -l)			#regista o 2º argumento e dá "filter" da lista de cidadãos.txt de acordo com a localidade que é o 2º argumento
	echo "O número de cidadãos registados em $2 é $value"			#dá print do número de cidadãos nessa localidade
else											
	if [ $1 = registados ]; then					#Se o 1º argumento for registados
		if [ ! -f "cidadaos.txt" ]; then
			echo "Erro: O ficheiro cidadaos.txt não existe!"
			exit -1
		else
			value1=$(sort -t : -r -k 3 cidadaos.txt | awk -F[:] '$3>60' | awk -F[:] '{print $2,":", $1}' |  sed 's/ *: */:/g')	#dá filter e sort do ficheiro cidadaos.txt dos cidadaos com mais de 60 anos e guarda só o nome e número de utente Ex: Joaquim Silva:10006 
			echo "$value1"	#imprime os resultados
		fi
	else
		if [ $1 = enfermeiros ]; then			#Se o 1º argumento for enfermeiros
			if [ ! -f "enfermeiros.txt" ]; then		#Se o ficheiro enfermeiros.txt não existir, emite um erro
				echo "Erro: O ficheiro enfermeiros.txt não existe!"
				exit -3
			else
				echo "$(sort -t : -n -k 5 enfermeiros.txt | awk -F[:] '$5==1' | awk -F[:] '{print $2}' )"	#Dá filter de enfermeiros com disponibilidade igual a 1 e dá print
			fi
		else
			echo "Argumento não válido (usar ./stats.sh <cidadaos> <localidade> | ./stats.sh <registado> | ./stats.sh <enfermeiros>)"		#dá o erro de argumentos inválidos
			exit -3
		fi 
	fi
fi

echo -e "\n\nScript executado com sucesso"
