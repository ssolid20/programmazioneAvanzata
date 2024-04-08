#!/bin/bash
# primo esempio di script

if [[ $1 = "search" ]]
then 
	#echo "hai scelto search"
	if [ "$#" != "2" ]
	then
		echo "Servono due argomenti"
		exit 0
	fi

	tosort=$(grep $2 -i address-book-database.csv | cat)
	#numtosort=$(grep $2 -ci  address-book-database.csv)

	if [[ $? != 0 ]]
	then
	    echo "Not found"
	    exit 0	   
	fi

	#echo numero di coincidenze $numtosort
	echo
	IFS=$'\n'
	for str in $tosort
	do
		#echo $str
		echo "Name: $(echo $str | cut -d , -f 1)"
		echo "Surname:$(echo $str | cut -d , -f 2)"
		echo "Phone:$(echo $str | cut -d , -f 3)"
		echo "Mail:$(echo $str | cut -d , -f 4)"
		echo "City:$(echo $str | cut -d , -f 5)"
		echo "Address:$(echo $str | cut -d , -f 6)"
		echo ""

	unset IFS

	done






	unset IFS


	

elif [[ $1 = "view" ]]
then 
	echo "hai scelto view"
	
	column -t -s ',' address-book-database.csv
	

# 

elif [[ $1 = "insert" ]]
then 
	echo "hai scelto insert"
	echo -n "Name:" 
	read name
	echo -n "Surname:" 
	read surname 
	echo -n  "Phone:"
	read phone  
	echo -n "Mail:" 
	read mail
	grep $mail -q address-book-database.csv 
	if [[ $? = 0 ]]
	then
	    echo "Email è gia uttilizzata, perfavore usa un'altra email"
	    exit 0 
	fi
	echo -n "City:" 
	read city
	echo -n "Address:" 
	read address 
	echo  "Added"
	echo "" >> address-book-database.csv
	echo -n "$name,$surname,$phone,$mail,$city,$address"  >> address-book-database.csv
	#sed 2i $str address-book-database.csv $?


elif [[ $1 = "delete" ]]
then 
	echo "hai scelto delete"
	if [ "$#" != "2" ]
	then
		echo "Servono due argomenti"
		exit 0
	fi

	emailtodelete=$(grep $2  address-book-database.csv)

	sed -i "s/$emailtodelete//g" address-book-database.csv 2>/dev/null

	if [[ $? = 0 ]]
	then
	    echo "Deleted"
	else 
	    echo "Cannot find any record"
	   
	fi
	
	
	
	

else
echo "L'argomento non  valido"
fi
