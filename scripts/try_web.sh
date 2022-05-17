#!/usr/bin/bash

. /etc/init.d/functions

function checkURL(){

       checkURL=$1;
       a=$(curl -I  www.baidu.com) 
       echo $a
       return_web=($(curl -I -s --connect-timeout 3 ${checkURL}|head -2))
       
       echo $return_web
       if [[ "${return_web[1]}" == '200' &&"${return_web[2]}" == 'ok' ]]
           then
	      action "${checkURL}" /bin/true
      else

	      action "${checkURL}" /bin/false
              echo "retying again...";sleep 3;

         return_again=($(curl -I -s --connect-timeout 3 ${checkURL}|head -1 |tr "\r" "\n"))
         echo $return_again
         if [[ "${return_again[1]}" == '200' &&"${return_again[2]}" == 'ok' ]]
              then
                 action "${checkURL},retried again" /bin/true
         else

              action "${checkURL},retried again" /bin/false
              
         fi
     
      fi
      sleep 1;




}

checkURL http://www.gkx.com
