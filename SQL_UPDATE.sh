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

	if test -d "$1"; then
   	 	cd "$1"
	else
		echo "Database $1 does not exist"
	fi
}


function UPDATE(){

	declare -a colls_to_be_upd;
	declare -a index_colls_to_be_upd;
	declare -a upd_vals;

	declare -a colls_cond;
	declare -a cond_val;

	declare -a collumns
   	

	if test -f "${command[1]}"; then

   	tail -n +2 "${command[1]}"
 
   	collumns=($(sed '2!d' "${command[1]}"))

   	nr_colls="$(wc -w <<< "$(sed '2!d' "${command[1]}")")"
   	nr_rows="$(wc -l < "${command[1]}")"
   	(( nr_rows=nr_rows-2 ))


   	index_whr=0; #indexul pozitiei pe care se afla 'WHERE'

   	nr_words=0; #numarul de cuvinte din comanda

   	for txt in "${command[@]}"
   	do

   		if [ "$txt" == "where" ]; then
   			index_whr="$nr_words"
   		fi
   	(( nr_words=nr_words+1 ))
   	done
   	fi


   	nr_colls_tbu=0; #number of colls to be updated
   	for ((i = 3; i < index_whr; i=i+3))
   	do
   		colls_to_be_upd[nr_colls_tbu]=${command[$i]}
   		

   		upd_vals[nr_colls_tbu]="${command[$i+2]}"

   		((nr_colls_tbu=nr_colls_tbu+1))
   	done


   	nr_colls_cond=0
   	for ((j = index_whr+1; j < nr_words; j=j+3))
   	do
   		colls_cond[nr_colls_cond]="${command[$j]}"


   		cond_val[nr_colls_cond]="${command[$j+2]}"


   		((nr_colls_cond=nr_colls_cond+1))
   	done


   	declare -a index_rows_meeting_cond
   	declare -a index_colls_with_cond

   	ok="false";
   	temp_index=0;
   	for ((i = 0; i < nr_colls; ++i))
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

   	for ((i = 3; i <= nr_rows+2; ++i))
   	do

   		row=($(sed "${i}q;d" ${command[1]}))
   	

   		ok="true"
   		for((j = 0; j < nr_colls_cond; ++j))
   		do
   			if [ "${row[${index_colls_with_cond[$j]}]}" != "${cond_val[$nr_colls_cond-$j-1]}" ]; then
   				ok="false"
   			fi

   		done

   		declare -a updated_row

   		

   		#pana aici merge corect

   		if [ "$ok" == "true" ]; then

   			indez=(${index_colls_to_be_upd[@]})
   			index_upd=0;
   			for ((k = 0; k < nr_colls; ++k))
   			do
  
   				if [ "$k" == "${indez[$index_upd]}" ]; then

   					updated_row[k]="${upd_vals[$index_upd]}"

   					((index_upd=index_upd+1))

   				else

   					updated_row[k]="${row[$k]}"
   				fi

   			done

   			rw="${row[@]}"
   			rwu="${updated_row[@]}"
   			#echo "${updated_row[@]}"


   			sed -i "${i} s/${rw}/${rwu}/g" "${command[1]}"

   		fi
   		
   	done

   	cat ${command[1]}

}

read -a command;

OPEN "db1"
UPDATE "$command"












