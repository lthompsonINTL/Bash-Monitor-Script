#!/bin/bash

#######################################################################################
######################## IP\ URL Monitoring Tool ######################################
#######################################################################################
#######################################################################################

# This application will ping a IP or URL. Once 3 ping failures occur an email notifacation (using Mailx) acknowledging a degraded network will be sent. After 5 ping failures occur, an email notifacation 
# acknowledging a failed network will be sent. The target URL or IP address must be added below.


################################################################################


SuccessCounter=0

DegradedCounter=0

FailedCounter=0


################################################################################

DegradedPing ()

{

 echo "DegradedPing: write to log reporting failure and email degraded notifcation"
 echo "The network connection to Google.com is degraded. Please investigate" | mailx -s "Network Connection to Google.com degraded" Leslie.J.Thompson@marriott.com


DegradedCounter=0

PingTest

}


################################################################################

FailedPings ()

{

 echo "FailedPings: write to log reporting failure and email failed notifcation"
 echo "The network connection to Google.com is down! Please investigate" | mailx -s "Network Connection to Google.com IS DOWN!" Leslie.J.Thompson@marriott.com

FailedCounter=0

PingTest

}


#################################################################################


PingTest ()

{


while [ 1 -gt 0 ]

do


  sleep 1
  


  ping -c 1 www.google.com;

  #status= $?

      if  [[ $? -eq 0 ]];

      then
   	
	echo ""
	echo "Google Ping successful"
	echo ""

        DegradedCounter=$((DegradedCounter-1))
        FailedCounter=$((FailedCounter-1))



       else
	
        echo ""
        echo "Google Ping failed"
        echo "" 

        DegradedCounter=$((DegradedCounter+1))
        FailedCounter=$((FailedCounter+1))

        echo "Degraded pings $DegradedCounter" 
	echo "Failed pings $FailedCounter"

	
      fi


	
       if [[ $DegradedCounter -eq 3 ]]; then
           

        echo ""
        echo "Ping failed 3 times"	
	echo "" 

        DegradedPing           
        

        elif [[ $FailedCounter -eq 5 ]]; then

        echo "Ping failed 5 times"
 
        FailedPings

                
        else

	     PingTest

      fi


# for production, the wait time should be 2 min


sleep 5

done

}


###################################################################################

echo "  "
echo "************************************"
echo "***********pinging google***********"
echo "************************************"
echo "  "


ping -c 1 www.google.com; echo $?

PingTest

