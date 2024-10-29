zip -r Archive.zip .
sshpass -p "5114115dom5" scp ./Archive.zip alexpetul@192.168.1.10:/home/alexpetul
sshpass -p "5114115dom5" ssh alexpetul@192.168.1.10 -t 'unzip -o Archive.zip -d lua-project; cd lua-project; lua main.lua'
