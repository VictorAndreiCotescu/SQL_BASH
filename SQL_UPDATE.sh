#!/bin/bash


# UPDATE "table_name" SET cols_to_be_updated = "value" WHERE col_condition = "value" 


# /$$$$$$$  /$$       /$$   /$$ /$$              /$$$$$$   /$$              /$$        /$$$$$$  /$$   /$$ /$$$$$$$ 
#| $$__  $$| $$      | $$  | $$| $$             /$$__  $$ | $$             | $$       /$$__  $$| $$  | $$| $$__  $$
#| $$  \ $$| $$$$$$$ | $$  | $$| $$   /$$      | $$  \__//$$$$$$           | $$      | $$  \ $$| $$  | $$| $$  \ $$
#| $$$$$$$ | $$__  $$| $$$$$$$$| $$  /$$/      | $$$$   |_  $$_/           | $$      | $$$$$$$$| $$  | $$| $$$$$$$/
#| $$__  $$| $$  \ $$|_____  $$| $$$$$$/       | $$_/     | $$             | $$      | $$__  $$| $$  | $$| $$__  $$
#| $$  \ $$| $$  | $$      | $$| $$_  $$       | $$       | $$ /$$         | $$      | $$  | $$| $$  | $$| $$  \ $$
#| $$$$$$$/| $$$$$$$/      | $$| $$ \  $$      | $$       |  $$$$//$$      | $$$$$$$$| $$  | $$|  $$$$$$/| $$  | $$
#|_______/ |_______/       |__/|__/  \__/      |__/        \___/ |__/      |________/|__/  |__/ \______/ |__/  |__/

                                        
echo off
clear
echo "Bash version ${BASH_VERSION}:01000010 01100010 00110100 01101011"
echo ""
echo "update table1 set AGE = 20 where NAME = DRAGOS ID = 2"
echo ""

cd ~/Documents/SQL


function OPEN(){

	if test -d "$1"; then #verific daca exista directory-ul primit ca parametru in functia OPEN "dir"
   	 	cd "$1" #daca exista mut operatiile in el
	else
		echo "Database $1 does not exist" #daca nu exista afisez eroare
	fi
}


function UPDATE(){

	declare -a colls_to_be_upd; 			#salvarea coloanelor ce trebuie modificate

	declare -a index_colls_to_be_upd;		#indexum coloanelor ce trebuie modificate

	declare -a upd_vals;					#valorile noi

	declare -a colls_cond;					#salvarea coloanelor ce reprezinta conditii

	declare -a cond_val;					#valoarea conditiilor

	declare -a collumns						#retin 'header-ul' table-ului
   	

	if test -f "${command[1]}"; then #verificare daca exista fisierul

   	#tail -n +2 "${command[1]}"
 
   	collumns=($(sed '2!d' "${command[1]}")) #iau de pe linia 2 din fisier "header-ul" table-ului

   	#echo "${collumns[@]}"

   	nr_colls="$(wc -w <<< "$(sed '2!d' "${command[1]}")")" #salvez numarul de coloane
   	nr_rows="$(wc -l < "${command[1]}")" #salvez numarul de randuri
   	(( nr_rows=nr_rows-2 )) #scad primele doua randuri care fac referire la
   												#tipurile de date ale coloanelor
   												#numele coloanelor


   	index_whr=0; #indexul pozitiei pe care se afla 'WHERE'

   	nr_words=0; #numarul de cuvinte din comanda

   	for txt in "${command[@]}" #parcurg comanda cuvant cu cuvant
   	do

   		if [ "$txt" == "where" ]; then
   			index_whr="$nr_words" #cand gasesc "where" ii salvez pozitia
   		fi 
   	(( nr_words=nr_words+1 )) #incrementez numarul de cuvinte
   	done
   	fi


   	nr_colls_tbu=0; #numarul de coloane ce urmeaza sa fie updatate
   	for ((i = 3; i < index_whr; i=i+3)) #plec de la al 3-lea cuvant, $prima coloana: update table set col
   	do
   		colls_to_be_upd[nr_colls_tbu]=${command[$i]} #salvez valoarea in matrice

   		upd_vals[nr_colls_tbu]="${command[$i+2]}" #sar peste egal si salvez valoarea ce urmeaza sa inlocuiasca

   		((nr_colls_tbu=nr_colls_tbu+1)) #incrementez numarul de coloane ce trebuie updatate
   	done


   	nr_colls_cond=0	#numarul de coloane care vor reprezenta restritiile pentru update
   	for ((j = index_whr+1; j < nr_words; j=j+3))
   	do
   		colls_cond[nr_colls_cond]="${command[$j]}"

   		cond_val[nr_colls_cond]="${command[$j+2]}"

   		((nr_colls_cond=nr_colls_cond+1))
   	done


   	#declare -a index_rows_meeting_cond
   	declare -a index_colls_with_cond #salvez indexul coloanelor pe care se pun conditii

   	ok="false";
   	temp_index=0;
   	for ((i = 0; i < nr_colls; ++i)) #parcurg toate coloanele
   	do

   		ok="false";

   		for ((j = 0; j < nr_colls_cond; ++j))
   		do
   			if [ "${collumns[$i]}" == "${colls_cond[$j]}" ]; then
   				ok="true"

   			fi
   		done

   		if [ "$ok" == "true" ]; then
   			index_colls_with_cond[temp_index]="$i"
   			((temp_index=temp_index+1))
   		fi

   	done

   	for ((i = 0; i < nr_colls; ++i))
   	do

   		ok="false";

   		for ((j = 0; j < nr_colls_tbu; ++j))
   		do
   			if [ "${collumns[$i]}" == "${colls_to_be_upd[$j]}" ]; then
   				ok="true"
   				
   			fi
   		done

   		if [ "$ok" == "true" ]; then
   			index_colls_to_be_upd[temp_index]="$i"
   			((temp_index=temp_index+1))
   		fi

   	done
   	

   	declare -a row

echo "----------------------------"

   	for ((i = 3; i <= nr_rows+2; ++i)) #parcurg toate randurile incepand cu primul rand pe care se afla date
   	do

   		row=($(sed "${i}q;d" ${command[1]})) #salvez in variabila row randul i
   	

   		ok="true"
   		for((j = 0; j < nr_colls_cond; ++j)) #parcurg coloanele cu conditii
   		do
   			if [ "${row[${index_colls_with_cond[$j]}]}" != "${cond_val[$nr_colls_cond-$j-1]}" ]; then
   				ok="false"

   				#daca difera nu se vor efectua modificari asupra acestei linii
   			fi

   		done

   		declare -a updated_row


   		if [ "$ok" == "true" ]; then #daca linia a intalnit toate conditiile

   			indez=(${index_colls_to_be_upd[@]}) #salvez toate indexurile coloanelor in alta matrice
   			index_upd=0; #variabila temporara de salvare a indexurilor 
   			for ((k = 0; k < nr_colls; ++k))
   			do
  
   				if [ "$k" == "${indez[$index_upd]}" ]; then #daca pe coloana k corespunde o valoare ce trebuie modificata

   					updated_row[k]="${upd_vals[$index_upd]}" #atasez valoarea corespunzatoare
 
   					((index_upd=index_upd+1)) #trec la urmatoarea valoare

   				else

   					updated_row[k]="${row[$k]}" #daca valoarea de pe coloana k nu trebuie modificata copiez din linia originala
   				fi

   			done

   			rw="${row[@]}"
   			rwu="${updated_row[@]}"


   			sed -i "${i} s/${rw}/${rwu}/g" "${command[1]}" #inlocuiesc coloana de pe linia i
   		fi
   		
   	done

   	cat ${command[1]} #afisez fisierul modificat

}

read -a command; #citesc comanda

OPEN "db1" #deschid db
UPDATE "$command" #update












