#!/bin/bash

#Pasta onde encontra-se os arquivos
c1="/mnt/backups"

#IP do servidor de backup
ip="192.168.0.100"
user="massariol"

verifica_data(){
	var=$(date +%d%m%Y)
}

seleciona_bkp(){
	data=verifica_data
	echo "caminho $1"

	cd $c1
	if [ -e $1 ];then
		echo "Arquivo Existe"
	#	scp $1 massariol@192.168.0.102:$bkp1 | echo -e "12345678\n"
		rsync -uavzhEP $1 massariol@192.168.0.103:$2/

		if [ $? -eq 0 ];then
			echo "Deu certo"
		else
			echo "Erro na cópia"
		fi	
	else
		echo "Arquivo não existe"
	fi	
}


copia_arq(){
	arq=$@
	cd $c1
	for i in ${arq[@]}
	do
		# t=$(cut -c 1-10 $i)
		echo "mostra $i"
		seleciona_arq $i
				

	done
}

verifica_dia(){
	dia=$(date +%A)

		if [ $dia = "domingo" ]; then			
			echo "domingo"
	    elif [ $dia = "segunda" ]; then 
			echo "segunda"
		elif [ $dia = "terça" ]; then
			copia_arq ${arq3[@]}
		elif [ $dia = "quarta" ]; then
			echo "quarta"			
		elif [ $dia = "quinta" ]; then
			echo "quinta"
		elif [ $dia = "sexta" ]; then
			echo "sexta"
		else [ $dia = "sabado" ];
			echo "sabado"
		fi
}

ler_cadastra_backup(){
	while read -a dados
	do
		var1=$(echo $dados | cut -f1 -d';')
		var2=$(echo $dados | cut -f2 -d';')
		var3=$(echo $dados | cut -f3 -d';')
		if [ $var1 = $(verifica_dia) ];then
			seleciona_bkp $var2 $var3
		fi
#		echo "dia: $var1"
#		echo "nome_arq: $var2"
#		echo "storage: $var3"
		
	done < cadastrar_backups.txt
}

ler_cadastra_backup
#verifica_dia

