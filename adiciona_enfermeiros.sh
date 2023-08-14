#!/bin/bash


###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
## Descrição/Explicação do Módulo: Adiciona um enfermeiro à lista de enfermeiros no ficheiro enfermeiros.txt
###############################################################################

nome=$1						#Regista o 1º argumento que é o nome
ncedula=$2					#Regista o 2º argumento que é o nº cédula profissional
csaude=$3					#Regista o 3º argumento que é o centro de saúde associado "CS"Localidade
disp=$4						#Regista a disponibilidade do enfermeiro

if [[ "$disp" -ne "0" ]] || [[ "$disp" -ne "1" ]]; then			#Verificar se o argumento disponibilidade passado for diferente de 0 ou 1
	echo -e "Erro: Valor: "$4" tem de ser 0 ou 1"
	exit -1
fi
if [ $# -ne 4 ]; then									#Se o número de argumentos dados for diferente de 4, irá devolver um erro
	echo -e "Erro: Síntaxe: "$0" <número cédula profissional>:<nome>:<centro saúde
associado>:<nº de vacinações efetuadas>:<disponibilidade>\n"
	echo "Aviso: Se o centro saúde associado, por exemplo, for "Torres Vedras". Por favor escreva "CSTorresVedras"."
	exit -2
else													#Se o número de argumentos for igual a 4, o script é executado normalmente
	if [ ! -f enfermeiros.txt ]; then					#Se não existir o ficheiro enfermeiros.txt, o script não precisa de verificar por exceções
	echo "$ncedula:$nome:$csaude:0:$disp" > enfermeiros.txt				#escreve os parâmetros no ficheiro enfermeiros.txt
	else																#Caso existir o ficheiro enfermeiros.txt, verifica-se as exceções
		if $(awk -F[:] '{print $3}' enfermeiros.txt | grep -q "$csaude") ; then						#Se já existir um enfermeiro registado no mesmo CSaúde, retornará um erro
			echo "Erro: O Centro de Saúde introduzido já tem um enfermeiro registado"
			exit -3
		else															
			if $(awk -F[:] '{print $1}' enfermeiros.txt | grep -q "$ncedula" ) ; then					#Se já o enfermeiro que prentender registar tiver registado noutro CSaúde, retornará erro
				echo "Erro: Enfermeiro já está noutro CSaúde"
				exit -4
			else														#Caso contrário, não há problemas e o enfermeiro é registado
				echo "$ncedula:$nome:$csaude:0:$disp" >> enfermeiros.txt
			fi
		
		fi
	
	fi
fi
echo -e "\n"
echo -e "Adicionamento feito com sucesso\n"
cat enfermeiros.txt



