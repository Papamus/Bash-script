#!/bin/bash
ROOTID=$(id -u)
while :
do
 echo "Wybierz opcje z menu:"
 echo "*********************************"
 echo "1 - Zbierz info o systemie"
 echo "2 - Wyswietl zapisane informacje"
 echo "3 - Utworz grupe"
 echo "4 - Utworz uzytkownika"
 echo "5 - Pobierz i przetworz plik"
 echo "6 - Wyszukaj frazy w plikach"
 echo "0 - Opuszczenie skryptu"
 echo "*********************************"
 read menuchoice

 case $menuchoice in
	1)
	 clear
	 echo "Wybrano opcje 1"
	 echo -n "Nazwa hosta:" > info.txt
	 uname -n >> info.txt
	 echo -n "Info na temat jadra:" >> info.txt
	 uname -v >> info.txt
	 echo -n "Wersja jadra:" >>info.txt
	 uname -r >> info.txt
	 #echo "Informacje na temat hardware'u" >> info.txt
	 #hwinfo --short >> info.txt
	 echo "Wykorzystanie pamieci:" >>info.txt
	 free >> info.txt
	 echo "Info na temat dyskow:" >> info.txt
	 df -h >> info.txt
	 echo "Zebrano informacje o systemie"
	 ;;

	2)
	 clear
	 echo "Wybrano opcje 2"
	 echo "Wyswietlam informacje o systemie"
	 cat info.txt
	 ;;

	3)
	 clear
	 echo "Wybrano opcje 3"
	 if [ $ROOTID -eq 0 ]
	  then
	   echo "Podaj nazwe grupy jaka chcesz utworzyc:"
	   read grpname
	   if grep -q $grpname /etc/group
	    then
 	     echo "Grupa o podanej nazwie juz istnieje!"
	   else
	    groupadd $grpname
	    echo "Dodano grupe o nazwie: $grpname"
	   fi
	 else
	  echo "Nie jestes zalogowany jako root wiec nie mozesz wykonac tego polecenia!"
 	 fi
	 ;;

	4)
	 clear
	 echo "Wybrano opcje 4"
	 if [ $ROOTID -eq 0 ]
	  then
	   echo "Podaj nazwe uzytkownika ktorego chcesz stworzyc:"
	   read username
	   if grep -q $username /etc/passwd
	    then
	     echo "Uzytkownik o podanej nazwie juz istnieje!"
	   else
	    echo "Podaj nazwe grupy do ktorej chcesz dodac uzytkownika"
	    read groupname
	    if grep -q $groupname /etc/group
	     then
	      useradd $username
	      usermod -G $groupname $username
	      echo "Dodano nowa grupe i uzytkownika oraz uzytkownika do nowej grupy"
	      echo "Podaj haslo dla nowego uzytkownika:"
	      passwd $username
	    else
	     echo "Podana grupa nie istnieje!"
	    fi
	   fi
	 else
	  echo "Nie jestes zalogowany jako root, nie mogesz wykonca tego polecenia!"
	 fi
	 ;;

	5)
	 clear
	 echo "Wybrano opcje 5"
	 echo "Plik przed modyfikacja:"
	 cat file.txt
	 sed -i '1i ******************************' file.txt
	 sed -i '1i MINIPROJEKT SYSTEMY OPERACYJNE' file.txt
	 sed -i '1i ******************************' file.txt
	 echo "Autorem skryptu jest: Adam Kusiakiewicz" >> file.txt
	 echo "Plik po modyfikacji:"
	 cat file.txt
	 echo "Czy chcesz zmodyfikowac plik? Wpisz tak lub nie"
	 read decision
	 if [ $decision == "tak" ]
	  then
	   nano file.txt
	 fi
	 ;;

	6)
	 clear
	 echo "Wybrano opcje 6"
	 echo "Wybierz plik z ktorego chcesz odczytac dane frazy:"
	 read file
	 if [ -e $file ]
	  then
	   echo "Plik istnieje, podaj fraze ktora chcesz wyszukac:"
	   read phrase
	   echo "Wyswietlam linie w ktorych znajduje sie szukana fraza:"
	   grep -rnw $file -e $phrase 
	 else
	  echo "Podany plik nie istnieje!"
	 fi
	 ;;

	0)
	 clear
	 echo "Wyjscie ze skryptu"
	 break
	 ;;

	*)
	 clear
	 echo "Wybrano niewlasciwa opcje"
	 ;;
 esac
done
