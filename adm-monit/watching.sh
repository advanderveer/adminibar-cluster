#watch indefinately for changes using curl long polling
while :; do curl -L http://127.0.0.1:4001/v2/keys/services/adm?wait=true\&recursive=true; echo "hi"; done