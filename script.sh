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
		useradd -m -c $nomr $nom # 5-Create the user / 7-Set the password.
        [ $? -eq 0 ] && echo "L'usuari ha estat afegit al sistema." || echo "No s'ha pogut afegir l'usuari al sistema."
        echo -e "$contra\n$contra" | passwd $nom # 7-Set the password. 
        passwd -e $nom  #9-Force password change on first login.
        [ $? -eq 0 ] && echo "La contrasenya d'ha establert" || echo "No s'ha pogut establir la contrasenya." # 8-Check to see if the passwd command succeeded.
        x = `hostname`
        echo " El usuari és $user, la contrasenya és $contra i el host és $x." # 10-Display the username, password, and the host where the user was created.
	fi
else
	echo "Nomès pots crear usuaris en mode Super Usuari"
	exit 2
fi
