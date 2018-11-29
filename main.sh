#!/bin/bash

#Pasta onde encontra-se os arquivos
c1="/mnt/backups"

#Quais arquivos vou fazer o backup
# Campos do array = o nome do arquivo, exceto o ultimo
# Ultimo campo do array = dia do backup
arq1=(teste1.txt teste2.txt teste3.txt domingo)
arq2=(teste4.txt teste5.txt teste6.txt segunda)
arq3=(teste7.txt terça)

#Para quais as pastas do servidor remoto devem ser copiados
bkp1='/home/massariol/Documentos/BACKUPS/TESTE1/'          
bkp2='/home/massariol/Documentos/BACKUPS/TESTE2/'
bkp3='/home/massariol/Documentos/BACKUPS/TESTE3/'

####
bkp1=(quarta teste1.txt '/home/massariol/Documentos/BACKUPS/TESTE1')
bkp2=(quarta teste2.txt '/home/massariol/Documentos/BACKUPS/TESTE2')
bk3=(quarta teste3.txt '/home/massariol/Documentos/BACKUPS/TESTE3')
bk4=(quarta teste4.txt '/home/massariol/Documentos/BACKUPS/TESTE1')
bk5=(quarta teste5.txt '/home/massariol/Documentos/BACKUPS/TESTE2')
#bk6=(quarta teste1.txt '/home/massariol/Documentos/BACKUPS/TESTE1')
#bk7=(quarta teste1.txt '/home/massariol/Documentos/BACKUPS/TESTE1')
#bkp8=(quarta teste1.txt '/home/massariol/Documentos/BACKUPS/TESTE1')
#bkp9=(quarta teste1.txt '/home/massariol/Documentos/BACKUPS/TESTE1')
#bkp10=(quarta teste1.txt '/home/massariol/Documentos/BACKUPS/TESTE1')

#IP do servidor de backup
ip="192.168.0.100"
user="massariol"

verifica_data(){
	var=$(date +%d%m%Y)
}

seleciona_arq(){
	data=verifica_data
	echo "caminho $2"
	
	cd $c1
	if [ -e $1 ];then
		echo "Arquivo Existe"
	#	scp $1 massariol@192.168.0.102:$bkp1 | echo -e "12345678\n"
		rsync -uavzhEP $1 massariol@192.168.0.103:$bkp3/

		if [ $? -eq 0 ];then
			echo "Deu certo"
		else
			echo "Erro na cópia"
		fi	
	else
		echo "Arquivo não existe"
	fi	
}

seleciona_bkp(){
	data=verifica_data
	echo "caminho $2"

	cd $c1
	if [ -e $2 ];then
		echo "Arquivo Existe"
	#	scp $1 massariol@192.168.0.102:$bkp1 | echo -e "12345678\n"
		rsync -uavzhEP $2 massariol@192.168.0.103:$3/

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
	d1=(domingo segunda terça quarta quinta sexta sábado)	
	dia=$(date +%A)

		if [ $dia = "domingo" ]; then			
			echo 1
			copia_arq ${arq1[@]}
	    elif [ $dia = "segunda" ]; then 
			echo 2
			copia_arq ${arq2[@]}
		elif [ $dia = "terça" ]; then
			echo 3
			copia_arq ${arq3[@]}
		elif [ $dia = "quarta" ]; then
			echo 4
			seleciona_bkp ${bkp[@]}
		elif [ $dia = "quinta" ]; then
			echo 5
		elif [ $dia = "sexta" ]; then
			echo 6
		else [ $dia = "sabado" ];
			echo 7
		fi
}

verifica_dia

