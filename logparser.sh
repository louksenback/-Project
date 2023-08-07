#Λουκάς - Αλέξιος Χρηστίδης ΑΜ: 1090049
#Δημήτρης Ευθυμάκης ΑΜ: 1090054
#!/bin/bash

#Functions
#Function to count and display usernames occurrences
mining_usernames() {
  local filename="$1"

  #Count usernames occurrences
  awk '{ users[$3]++ } END { for (user in users) print users[user], (user == "" ? "-" : user) }' "$filename" | sort -n
}

#Function to display log entries for a specific user
log_entries_for_user() {
  local filename="$1"
  local user_id="$2"

  #Display log entries for the specified user
  awk -v user="$user_id" '$3 == user' "$filename"
}

#function to display info connected with the specified method
method_given_info()
{
	local filename="$1"      #Values: access.log
	local method_name="$2"   #Values: GET or POST
	
	while IFS= read -r line; do                #IFS: Internal Field Separator
    if [[ "$line" == *"$method_name"* ]]; then
        echo "$line"
    fi
	done < "$filename"
	
	
	#awk -v info="$method_name" '$6 == info' "$filename" #$3 is the 4th parameter given to execution. Ex. ./logparser.sh <filename> -method <method_name>    In this example its <method_name>
	
}


#function to display info connected with the specified Network Protocol
net_prot_given_info()
{
	local filename="$1"				#Values: access.log
	local network_protocol="$2"		#Values: IPV4 or IPV6
	
	while IFS= read -r line; do					#IFS: Internal Field Separator
    if [[ "$line" == *"$network_protocol"* ]]; then
        echo "$line"
    fi
	done < "$filename"
	
	
} 


#function to count the browsers and times of use
count_browsers()
{
	#array to store browser number
    declare -A browser_counts

	#function to match browsers and count occurrences
    match() {
        grep -o -E "Mozilla|Chrome|Safari|Edg" "$filename" | sort | uniq -c
    }
	
	#here we call match function and we store results in browser_counts
	while read -r count browser; do
        browser_counts["$browser"]=$count
    done < <(match)

	#here we display the browser counts
	for browser in "${!browser_counts[@]}"; do
        echo "$browser ${browser_counts[$browser]}"
    done

}

#function to display records based on given Date
date_given_results()
{
	local filename="$1"
	local Date="$2"
	
	

}
















#Check the number of parameters
if [ $# -lt 3 ]
then
	echo fafafafafaasdasdasd
	if [ $# -eq 0 ]
	then
		echo "Usage: $0 <string>"
		echo "1090049|1090054"   #Ερώτημα 1(i)
		exit 1
		else
			echo "Usage: $0 <filename> --usrid [<user_id>]"
		
	fi
	
fi


filename="$1"
option="$2"

if [ "$option" = "--usrid" ]; then
  #Check if the user_id is provided
  if [ $# -eq 2 ]; then
	mining_usernames access.log
    echo "Options: $0 <filename> --usrid <user_id>"
    exit 1
  fi

  user_id="$3"
  log_entries_for_user access.log "$user_id"

  #mining_usernames "$filename"
fi



if [ "$option" = "-method" ]; then
	#check if Get or Post
	method_name="$3"
	if [ "$method_name" = "GET" ]
	then 
		echo "Its Get"
		
		method_given_info access.log "$method_name"
	elif [ "$method_name" = "POST" ]
	then
		echo "Its Post"
		method_given_info access.log "$method_name"
	else
		echo "Wrong Method Name!"
	fi
fi

if [ "$option" = "--servprot" ]; then
	network_protocol="$3"               #For IPV4: 127.0.0.1, For IPV6: ::1
	if [ "$network_protocol" = "IPV4" ]
	then
		ipv4="127.0.0.1"
		net_prot_given_info access.log "$ipv4"
	elif [ "$network_protocol" = "IPV6" ]
	then
		ipv6="::1"
		net_prot_given_info access.log "$ipv6"
	else
		echo "Wrong Network Protocol!"
	fi
fi
	
if [ "$option" = "--browsers" ]; then
	
	count_browsers
fi	


if [ "$option" = "--datum" ]; then
	Date="$3"
	case $Date in
	
	Jan)
		sed -n '/Jan/ p' access.log
		;;
	Feb)
		sed -n '/Feb/ p' access.log
		;;
	Mar)
		sed -n '/Mar/ p' access.log
		;;
	Apr)
		sed -n '/Apr/ p' access.log
		;;
	May)
		sed -n '/May/ p' access.log
		;;
	Jun)
		sed -n '/Jun/ p' access.log
		;;
	Jul)
		sed -n '/Jul/ p' access.log
		;;
	Aug)
		sed -n '/Aug/ p' access.log
		;;
	Sep)
		sed -n '/Sep/ p' access.log
		;;
	Oct)
		sed -n '/Oct/ p' access.log
		;;
	Nov)
		sed -n '/Nov/ p' access.log
		;;
	Dec)
		sed -n '/Dec/ p' access.log
		;;
	*)
		echo "Wrong Date!"
	;;
esac	
fi
#Check if the number of parameters is correct








# Get the first command-line parameter and assign it to STRING1 variable
STRING1="$1"  # access.log
STRING2="$2"  # root
STRING3="$3"
# Set the comparison string variable
STRING0="access.log"

# Compare the input string with the comparison string



#if [ "$STRING1" = "$STRING0" ]; then
#	cat $1 #Ερώτημα 1(ii)
#else
 # echo "The input string does not match the comparison string."
#fi



