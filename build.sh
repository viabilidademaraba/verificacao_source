#!/bin/bash
read -p "Digite a mensagem do commit: " commitmsg

flutter build web --release --base-href="/verificacao/"
cp -R build/web/* /home/vas/Projetos/vas/verificacao
cd /home/vas/Projetos/vas/verificacao
git add .
git commit -am "$commitmsg"
git push
