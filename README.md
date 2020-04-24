#Proiect final SQL - Utilizare Sistemelor de Operare


##Contribuitori

	- Balmau Dragos-Constantin
	- Varzan Laurentiu-Adrian
	- Cotesc Victor-Andrei
	- Nicolescu Robert-Alexandru

##Descriere

	Proiectul are ca scop simulare catorva comenzi fundamentale din limbajul SQL. Simulare se va face cu ajutorul unui 
		script in shell pe sistemul de operare Ubuntu - Linux. Comeziile simulate in acest script sunt:
			-CREATE DB; - done
			-CREATE TABLE; - done
			-OPEN DB; - done
			-SELECT; - in progress
			-INSERT; - in progress
			-UPDATE; - in progress
			-DELETE; - in progress
			-HELP; - in progress
			-QUIT; - done		

##Mod de functionare
	
	In acest proiect bazele de date sunt simulate de catre directoare(foldere), iar tabele dintr-o baza de date sunt simulate de fisiere text.
	La prima rulare a scriptului se va crea directorul principal cu numele "SQL" in care vor fi create directoare ce simuleaza bazele de date.
	
	CREATE

		Name
			CREATE - creeaza baze de date sau tabele

		Descriere

			Daca primul argument al functiei CREATE este DB aceasta va crea un director care simuleaza baza de date si va avea numelele 
			urmatorului parametru. 

			Daca primul argument al functiei CREATE este TABLE aceasta va crea un fisier text care simuleaza o tabela in baza de date curenta 
			si va avea numele urmatorului parametru. Urmatorii parametrii vor fi in mod alternativ numele unei coloane si tipul de date care va fi
			stocat in acea coloana.
			
			Altfel, se afiseaza un mesaj de eroare prin care se precizeaza ca functia CREATE poate crea doar baze de date si tabele.		
			
			Datele din fiecare tabela (fisier text) sunt structurate astfel: pe prima linie din fisier apar in ordinea introdusa de utilizator
			toate tipurile de date despartite prin cate un spatiu, iar pe linia urmatoare, sub fiecare tip de date se afla numele coloanei.
			Urmatoarele linii sunt alcatuite din informatiile pe care tabela le va stoca. Fiecare linie contine cate o informatie pentru fiecare coloana
			si ii corespunde tipului de date precizat initial in crearea tabelei.

			Exemplu stocare de date in tabela:

			datatype1	datatype2	datatype3
			columnname1	columnname2 	columnname3
			data10		date11 		data12
			data20 		date21 		data22
			data30 		date31 		data32		 

		Synopsis

			CREATE [FILE TYPE]... [FILE NAME] [COLUMN NAME] [COLUMN DATA TYPE]

		Options
		clear
			DB	parametru necesar in creare unei baze de date
			TABLE	parametru necesar in creare unei tabele

		Authors

			Balmau Dragos-Constantin si Cotescu Victor-Andrei
		
		See also

			Documentatie explicita pentru comanda: https://www.w3schools.com/sql/sql_create_table.asp
							       https://www.w3schools.com/sql/sql_create_db.asp
				

##Task-uri - in progress

	-Path inainte de ">" la fiecare comanda
	-Implementare de fisiere cu descrierea in cadrul comenzii help
	-Detalii cu privire la specificatiile echipamentului - hardware si software
	-tehnologii , limbaje aplicate
	-grade de utilizatori - admin, utilizator
	-carti
	


