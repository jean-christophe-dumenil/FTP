#!/bin/bash
cd /home/jc/
cat Shell_Userlist.csv | while read varligne
do
	password=`echo $varligne |cut -d ',' -f4`
	username=`echo $varligne |cut -d ',' -f2`
	username=`echo ${username,,}`
	role=`echo $varligne |cut -d ',' -f5`
	echo $role
	if [ ${role:0:5} = "Admin" ]
	then
		echo "creation de l'utilisateur : $username"
        	#sudo useradd -m -p /home/$username $username
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password) 
		useradd -m -p "$pass" "$username"
      		echo "changement du role de : $username"
     		sudo usermod -aG sudo $username
        	sudo adduser $username ftp_group
        	#echo $username:$password | chpasswd
    	else 
       	 	echo "creation de l'utilisateur : $username"
        	#sudo useradd -m -p /home/$username $username
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)       
        	useradd -m -p "$pass" "$username"
        	#echo "$username:$password" | chpasswd     

    fi
done < <(tail -n +2 Shell_Userlist.csv)
