#!/bin/bash
#
# Função: Testa o certificado SSL dos sites, organiza a data para o padrão brasileiro.
# OBS.: Os meses estão abreviados na lingua inglesam o que nao deve atrapalhar.
# 
#
# Criador: Bruno dias da Silva
versao="Versão: 1.3"
#
#
#clear

function ssl {

	#Exibe o comando na tela
	echo "Comando:
	true | openssl s_client -connect $1:443 -servername $1 2>&- | openssl x509 -enddate -noout
			
	"
	# Pegando resultado do comando e armazenando na variável espirar
	expirar=$(true | openssl s_client -connect $1:443 -servername $1 2>&- | openssl x509 -enddate -noout | cut -d "=" -f 2 | sed 's/GMT//')

	# Pegando do resultado o mês, dia, ano e hora que o certificado vai expirar.
	mes=$(cut -c -3 <<< $expirar); dia=$(cut -c 5,6 <<< $expirar); ano=$(cut -c 17-20 <<< $expirar); hora=$(cut  -c 8-15 <<< $expirar)

	# Exibindo a data que vai espirar o certificado
	echo "Expira em: $dia $mes de $ano às $hora GMT
	
	"
	
}

		function ssl_ssl {
		read -p echo "Digite o site, ao qual deseja consultar o tempo de vida do SSL" ssl
		echo "

		"
		# Exibe o comando na tela
		echo "true | openssl s_client -connect $ssl:443 -servername $ssl 2>&- | openssl x509 -enddate -noout
		"			
		# Pegando resultado do comando e armazenando na variável espirar
		expirar=$(true | openssl s_client -connect $ssl:443 -servername $ssl 2>&- | openssl x509 -enddate -noout | cut -d "=" -f 2 | sed 's/GMT//')
	
		# Pegando do resultado o mês, dia, ano e hora que o certificado vai expirar.
		mes=$(cut -c -3 <<< $expirar); dia=$(cut -c 5,6 <<< $expirar); ano=$(cut -c 17-20 <<< $expirar); hora=$(cut  -c 8-15 <<< $expirar)


		# Exibindo a data que vai espirar o certificado
		echo "Expira em: $dia $mes de $ano às $hora GMT


		"

		}

case $1 in
	"-v") echo "$versao

		";;

	-H) ;&
	--help) 
	echo ""
	cat /home/bruno/check_ssl_help.txt
	echo "

		";;

	"") ssl_ssl

		;;

	"-h")
		ssl $2	
				;;
esac
