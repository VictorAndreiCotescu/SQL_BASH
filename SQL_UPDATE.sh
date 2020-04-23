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

#collumns~gollumns~gollum~my_precious_code
                                        
echo off
clear
echo "Bash version ${BASH_VERSION}:01000010 01100010 00110100 01101011"
echo ""
echo "update table1 set col1 = val1 where colx = valx"
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

	declare -a colls_to_pe_upd;
	declare -a upd_vals;

	declare -a colls_cond;
	declare -a cond_val;

	declare -a collumns
   	

	if test -f "${command[1]}"; then

   	tail -n +2 "${command[1]}"
   	echo ""

   	collumns=$(sed '2!d' "${command[1]}") ##ERRORKLASCNAO
   	echo "${collumns[1]}"

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
   		colls_to_pe_upd[nr_colls_tbu]=${command[$i]}
   		upd_vals[nr_colls_tbu]="${command[$i+2]}"

   		#echo "${colls_to_pe_upd[$nr_colls_tbu]}"
   		#echo "${upd_vals[$nr_colls_tbu]}"

   		((nr_colls_tbu=nr_colls_tbu+1))
   	done


   	nr_colls_cond=0
   	for ((j = index_whr+1; j < nr_words; j=j+3))
   	do
   		cols_cond[nr_colls_cond]="${command[j]}"
   		cond_val[nr_colls_cond]="${command[j+2]}"

   		#echo "${cols_cond[nr_colls_cond]}"
   		#echo "${cond_val[nr_colls_cond]}"

   	((nr_colls_cond=nr_colls_cond+1))
   	done


   	declare -a index_rows_meeting_cond
   	declare -a index_colls_with_cond

   	ok=0;
   	temp_index=0;
   	for ((i = 0; i < nr_colls; ++i))
   	do

   		ok=0;

   		for ((j = 0; j < nr_colls_cond; ++j))
   		do
   			if [ "${collumns[$i]}" == "${colls_cond[$j]}" ]; then
   				echo "${collumns[$i]}"
   				echo " = "
   				echo "${colls_cond[$j]}"
   				echo ""
   				ok=1;
   			fi
   		done

   		if [ ok == 1 ]; then
   			echo okok
   			index_colls_with_cond[temp_index]="$i"
   			((temp_index=temp_index+1))
   		fi

   	done
   	
   	for((i = 0; i < nr_colls_cond; i++))
   	do
   		echo ok
   		echo "$nr_colls_cond"
   		echo -n "${index_colls_with_cond[$i]}";

   	done

   	

}

read -a command;

OPEN "db1"
UPDATE "$command"












