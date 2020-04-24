#!/bin/bash

#Sa aratam o cale minima langa >
echo off;
clear;
echo "Bash version ${BASH_VERSION}";

cd ~/Desktop;

if test -d "SQL" 
then
    cd SQL;
else
	mkdir SQL;
	cd SQL;
fi

echo  -ne ">";
read -a command;

function CREATE(){

	#
	
	if [ "${command[1]}" == "TABLE" ]
	then
		if test -f "${command[2]}"; 
		then
            echo -n "Exista deja o tabela cu acest nume!"
    	else
        	touch "${command[2]}";

        	len=${#command[@]};

        	for (( i=4; i<$len; i=i+2 ))
			do  
   				echo -ne "${command[i]} " >> "${command[2]}";
			done

			echo -ne "\n" >> "${command[2]}";

			for (( i=3; i<$len; i=i+2 ))
			do  
   				echo -ne "${command[i]} " >> "${command[2]}";
			done
 
        fi
    else
    	if [ "${command[1]}" == "DB" ]
    	then
	    	if test -d "${command[2]}"; 
			then
	            echo -n "Exista deja o baza de date cu acest nume!"
	        else    
	        	mkdir "${command[2]}";          
	    	fi
    	fi         
	fi
}

function OPEN(){

    if test -d "$1"; 
    then
        cd "$1";
    else
        echo "Baza de date $1 nu exista";
    fi
}

function SELECT_FROM(){
 
	if [ "${command[1]}" == "*" ] #utilizatorul doreste sa selecteze toate coloanele(i.e. intregul tabel)
	then
	    tail -n +2 ${command[3]}; #numele fisierului se afla pe pozitia a 3a din vectorul command
		echo -ne "\n";
	fi
 
}

while true 
do

	if [ "${command[0]}" == "CREATE" ]
	then

		CREATE

	fi

	if [ "${command[0]}" == "OPEN" ]
	then

		OPEN "${command[1]}"

	fi

	if [ "${command[0]}" == "SELECT" ]
	then

		SELECT_FROM

	fi

	if [ "${command[0]}" == "QUIT" ]
	then

		exit 0

	fi

	echo  -ne ">";
	read -a command;

done