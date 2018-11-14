#!/bin/bash
x=1
while true
do
echo $x > /var/www/html/worker1.txt
((x=x+100))
php /affichage.php
sleep 10
done
