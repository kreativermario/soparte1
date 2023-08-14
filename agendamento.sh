#!/bin/bash


###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
## Nome do Módulo: agendamento.sh
## Descrição/Explicação do Módulo: comentários feitos abaixo
###############################################################################
rm -f agenda.txt			#remove o ficheiro agenda.txt
if [ ! -f "enfermeiros.txt" ] || [ ! -f "cidadaos.txt" ]; then			#Se o ficheiro enfermeiros.txt ou cidadaos.txt não existir, emite erro
	echo "Erro: Ficheiro enfermeiros.txt ou cidadaos.txt não existe!"
	exit -1
fi
i=1
while [ $i -le $(wc -l < enfermeiros.txt) ]; do					#ciclo que percorre a lista de enfermeiros
disp=$(awk -F[:] '{print $5}' enfermeiros.txt | awk 'NR=='$i'')			#regista a disponibilidade do enfermeiro
	if [[ $disp == 1 ]]; then											#se a disponibilidade do enfermeiro for 1 (disponível), é iniciado o agendamento
		csaude=$(awk -F[:] '{print $3}' enfermeiros.txt | awk 'NR=='$i'' | awk -F'CS' '{print $2}')		#registo do centro de saúde do enfermeiro disponível retirando o CS (CSLoures ==> Loures)
		csaudetodo=$(awk -F[:] '{print $3}' enfermeiros.txt | awk 'NR=='$i'')							#registo do centro de saúde do enfermeiro disponível  com o CS (CSLoures)
		nomeEnf=$(awk -F[:] '{print $2}' enfermeiros.txt | awk 'NR=='$i'')								#registo do nome do enfermeiro disponível
		idEnf=$(awk -F[:] '{print $1}' enfermeiros.txt | awk 'NR=='$i'')								#registo do nº de cédula profissional
		j=1

		while [ $j -le "$( wc -l < cidadaos.txt )" ]; do										#ciclo que percorre a lista de cidadãos.txt 
		
			localidade=$(awk -F[:] '{print $4}' cidadaos.txt | awk 'NR=='$j'')					#regista a localidade do cidadão
			
				if [[ "$csaude" == "$localidade" ]]; then										#se a localidade do cidadão for igual ao centro de saúde do enfermeiro disponíve este é agendado com esse mesmo
					nomeCid=$(awk -F[:] '{print $2}' cidadaos.txt | awk 'NR=='$j'')				#regista o nome do cidadão
					idCid=$(awk -F[:] '{print $1}' cidadaos.txt | awk 'NR=='$j'')				#regista o número de utente do cidadão
					date=$(date '+%Y-%m-%d')													#regista a data atual no formato yyyy-mm-dd
		
					echo "$nomeEnf:$idEnf:$nomeCid:$idCid:$csaudetodo:$date" >> agenda.txt		#agenda o cidadão com o enfermeiro disponível da sua localidade

				else					
					:

				fi

		j=$(( $j+1 ))
	

		done
	else
		if [[ ! $(awk -F[:] '{print $5}' enfermeiros.txt | grep 1) ]]; then						#Se o ficheiro enfermeiros.txt só tiver enfermeiros indisponiveis, acaba o script
			echo "Erro: Não há enfermeiros disponíveis"
			exit -3
		fi
	fi

	i=$(( $i+1 ))
done
echo "Agendamento feito com sucesso"

