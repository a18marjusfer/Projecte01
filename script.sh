#!/bin/bash
if [ $(id -u) -eq 0 ]; then # 1-Make sure the script is being executed with superuser privileges.
	read -p "Introdueix l'usuari : " nom # 2-Get the username (login).
    read -p "Introdueix el nom real : " nomr # 3-Get the real name (contents for the description field).
	read -s -p "Introdueix la contrasenya : " contra # 4-Get the password.
	egrep "^$nom" /etc/passwd >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "L'usuari $nom existeix!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $contra)
		useradd -m -p $pass $nom
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	fi
else
	echo "Nomès pots crear usuaris en mode Super Usuari"
	exit 2
fi
