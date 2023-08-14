#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
## Nome do Módulo: menu.sh
## Descrição/Explicação do Módulo: 
###############################################################################

while :; do											#Cria um ciclo while e só sai dele se o utilizador escrever "0" para sair
	clear
	echo "========================================"
	echo "                  MENU"
	echo "========================================"
	echo "1. Listar cidadãos"
	echo "2. Adicionar enfermeiro"
	echo "3. Stats"
	echo "4. Agendar vacinação"
	echo "0. Sair"
	echo -e "\n"
	echo -e "Escolha a sua opção: \c"
	read resposta
	case "$resposta" in
		1) ./lista_cidadaos.sh						#Se a opção for "1", executa o script lista_cidadaos.sh
		;;
		2)echo -e "Entre o nome do enfermeiro <PrimeiroNome Apelido>: "			#O utilizador escolhe a opção "2" - Adicionar enfermeiro
			read nome																#Pede e regista o primeiro e último nome do enfermeiro
			echo -e "Entre o nº de cédula profissional <nº cédula>: "				#Pede e regista o número de cédula profissional do enfermeiro
			read idEnf
			echo -e "Entre o centro de saúde associado <"CS"Localidade> (NOTA: Se localidade for como Torres Vedras, escrever tudo junto. Exemplo: CSTorresVedras) : "  #Pede e regista o Centro de saúde associado
			read csaude
			echo -e "Entre a disponibilidade do enfermeiro <disponibilidade (0-indisponível, 1-disponível)>: "		#Pede e regista a disponibilidade do enfermeiro
			read disp
			./adiciona_enfermeiros.sh "$nome" "$idEnf" "$csaude" "$disp"					#Executa o script adiciona_enfermeiros com os argumentos dados
		;;
		3) while :; do										#Cria um ciclo while para um sub-menu stats --> Só acontece quando o utilizador escolhe a opção "3" Stats
			clear
			echo "========================================"
			echo "	MENU --> STATS"
			echo "========================================"
			echo "1. Cidadãos"
			echo "2. Registados"
			echo "3. Enfermeiros"
			echo "4. Voltar ao menu principal"
			echo -e "\n"
			echo -e "Escolha a sua opção: \c"
			read opt
			case "$opt" in
			1) echo -e "Entre a localidade <localidade>: "			#Se for a opção "1" --> pede e regista a localidade 
				read localcid
				./stats.sh cidadaos "$localcid"				#executa o script stats.sh 
				echo -e "\n"
			;;
			2) ./stats.sh registados					#Se for a opção "2" --> executa o script ./stats.sh registados
				echo -e "\n"
			;;
			3) ./stats.sh enfermeiros					#Se for a opção "3" --> executa o script ./stats.sh enfermeiros
				echo -e "\n"
			;;
			4) echo -e "Voltando para o menu principal..."			#Se for a opção "4" --> sai do sub-menu stats e vai para o menu principal
			break
			;;
			*) echo "Opção inválida"				#Se não for uma opção válida, dá um erro e volta ao menu principal
			break
			;;
			esac
			break
			done
		;;
		4) ./agendamento.sh				#Se for a opção "4" --> executa o script ./agendamento.sh
		;;
		0) echo "Exiting..."			#Se for a opção "0" --> fecha o menu e acaba o script
		break
		;;
		*) echo "Opção inválida"		#Se for uma opção inválida, dá um erro e volta a dar print do menu principal
		;;
	esac 
	echo -e "\n"
	echo -e "\n"
	echo "Voltando para o menu principal em 3 segundos"
	sleep 3
	echo "Voltando para o menu principal..." 
	sleep 1
done
