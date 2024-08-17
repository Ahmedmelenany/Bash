
#! /bin/bash  
while true 
do  
	
echo "Choose one of the following options to fully control the system:

1) user control 

2) group control 

3) leave

" 

read -p "Enter your choice: " choice 

if [  $choice -eq 1  ]
then 
         while true
         do 
		    PS3="Choose one of the above user controls from (1-7) to fully control users or choose 8 to go back: " ;
		 
	select var1 in Add_user Change_password Change_user_name Change_user_id Add_user_to_group Delete_user Remove_user_from_group Go_back 
	do 
		case $var1 in 
				"Add_user") 
			       while true ; do 	
				read -p "Enter the name of the user to be added: " U1
				if id $U1 &> /dev/null; then 
					while true ; do 
                                 echo "pay attention!! the user already exists, try another user name"
                                     break 1 
			               done 
			       else  
			        		

				echo "`sudo useradd $U1`" 
				echo "congratulations!! the user has already been added sucessfully" 
                                 break 1 
			          fi 
			          done 	  
				;;
			"Change_password")
			       while true ; do 	
			        read -p "Enter the name of the user to change his password: " U2	
				 if id "$U2" &>/dev/null; then 
				echo "`sudo passwd $U2`" 
				echo  "congratulations!! the password has been changed successfully" 
			         break 1 	
			         else 
			        while true ; do 		 
				 echo "pay attention !! the user doesn't exist mainly, try another user" 
			          break 1 
			           done 
			           fi 
			           done 	   
                                ;;
			"Change_user_name")
			       while true ; do 	
				read -p "Enter the name of the user you want to change it:" U3  
				if id "$U3" &>/dev/null; then
				read -p "Enter the new user name" U4 
				echo "`sudo usermod -c $U4 $U3`" 
		       	        echo  "congratulations!! the name has been changed successfully" 
			        break 1 	
		        	else 
			        while true ; do 		
				echo "pay attention!! the user doesn't exist mainly ,try another user" 
			       break 1 
		                done 
		                fi 
		                done 
			         	
				;; 
			"Change_user_id")  
			       while true; do 	
			        read -p "Enter the name of the user you want to change his id:" U5 
				if id "$U5" &>/dev/null; then
			         
			        read -p "Enter the new id" U6 
			        echo "`sudo usermod -u $U6  $U5`"
				echo  "congratulations!! the id has been changed successfully" 
			        break 1 	
		        	else 
				while true; do 
				echo "pay attention!! the user doesn't exist mainly ,try another user"
			        break 1 
			        done 
			        fi 
			        done 	
				;; 
			"Add_user_to_group") 
 
				while true; do 
		      	    read -p "Enter the user you want to add to a group:" U7
				if id "$U7" &>/dev/null; then
			         
		            read -p "Enter the name of the group:" U8 
			        echo "`sudo usermod -aG  $U8  $U7`" 
			        echo  "congratulations!! the user has been added to the new group successfully" 
			        break 1 	
		        	else 
				while true; do 
				echo "pay attention!! the user doesn't exist mainly ,try another user" 
			        break 1 
			        done 
			        fi 
			        done 	
			        ;;
			"Delete_user") 
		               
			       while true; do  
	                       read -p "Enter the name of the user you want to delete:" U9 
			       if id "$U9" &>/dev/null; then
			       echo "`sudo userdel $U9`"
			       echo  "congratulations!! the user has been deleted successfully" 
			       break 1  
		               else 
			       while true; do 
			       echo "pay attention!! the user doesn't exist mainly ,try another user" 
		               break 1 
		               done 
		               fi 
		               done 	       
                               ;; 

		       "Remove_user_from_group")
                                 
			       while true; do 	
				read -p "Enter the name of the user you want to remove from a group:" U10 
				if id "$U10" &>/dev/null; then
			
				read -p "Enter the name of the group:" U11
				echo "`sudo gpasswd -d $U10 $U11`" 
			         break  1	
		        	else 
				while true; do 
				echo "pay attention!! the user doesn't exist mainly ,try another user" 
			        break 1 
			        done 
			        fi 
			        done 	
				;; 

                         "Go_back")  
                               break 2 
		                ;; 
			*) 
			echo "your input is out of the scope" 

         	esac 
                                                  
done 
done 

elif [  "$choice" -eq 2  ]; then 

	while true; do 
		PS3="Choose one of the above group controls from(1-6) to fully control groups or choose 7 to go back:" ; export PS3
		 
	select var2 in Add_group Delete_group Change_group_name Change_group_id List_all_groups List_user_groups Go_back 
	do 
		case $var2 in 
			"Add_group") 

			       while true ; do 	
				read -p "Enter the name of the group you want to add:" U12 
				if getent group "$U12" > /dev/null 2>&1; then 
				while true ; do 	
				echo "pay attention!! the group exisits,try another new group"
			         break 1 
			         done 
			         else 	 
				echo "`sudo groupadd $U10`" 
				echo  "congratulations!! the group has been added successfully" 
			        break 1 
			        fi 
			        done 	
				;; 
			"Delete_group") 
			       while true ;do 	
				read -p "Enter the name of the group to be deleted:" U13
			       if getent group "$U13" > /dev/null 2>&1; then
				echo "`sudo groupdel $U13`" 
				 echo "congratulations!! the group has been deleted successfully" 
			       break 1 
		               else 
			        while true; do 
			       echo "pay attention!!the group doesn't exist mainly,try another existent group" 
	                        break 1 
	                        done 
	                        fi 
	                        done 			

				;; 
			"Change_group_name") 
		        while true ; do	
			read -p "Enter the name of the group to be changed:" U14 
			if getent group $U14 > /dev/null 2>&1; then
			read -p "Enter the name of the new group:" U15
			echo "` sudo groupmod -n $U15 $U14`" 
		        echo  "congratulations!! the group name has been changed successfully" 
		       break 1 
	                else 
	                while true; do 			
			echo "pay attention!!, the group doesn't exist mainly,try another existent group"
		        break 1 
		        done 
		        fi 
		        done 	
			;; 
			
		      "Change_group_id") 
		       
		        while true; do 	
		       read -p "Enter the name of the group you want to change its id:" U14 
		       if getent group "$U14" > /dev/null 2>&1; then
	         
	               read -p "Enter new id you want to assign for the group:" U15 
	               echo "`sudo groupmod -g $U14 $U15`" 
		       	echo "congratulations!! the group id has been changed successfully"
		       break 1 
	               else 
		       while true; do 
		       echo "pay attention!!, the group doesn't exist mainly,try another existent group"
	               break 1 
	               done 
		       fi 
		       done 
	                   	      
		       ;; 
	              "List_all_groups") 
		        echo "`cat /etc/group`" 

		       ;; 
                       
	              "List_user_groups") 
		       
		      while true; do  
		      read -p "Enter the name of the user you want to list his groups:" U16
		      if id "$U16" &>/dev/null; then           
		       echo "`groups $U16`" 
		       echo  "congratulations!! the users group has been listed successfully" 
		       break 1 
	                else 
			while true; do        	
			echo "pay attention!! the user doesn't exist mainly, try another user"
		         break 1 
		         done 
		         fi 
		         done 	 
		      ;;	       

	             "Go_back") 
		      break 2
	               ;; 
	            
 	              *) 
                      echo "your input is out of scope" 
                 
                      ;; 
                  
	      esac 
      done 
      done
       

elif [ $choice -eq 3   ] ; then break 1 

else 

while true ; do 
 echo "your input is out of scope, try again " 
break 1 
done 

fi 
done 








