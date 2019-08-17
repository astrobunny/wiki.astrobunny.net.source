#!/bin/bash
set -e
git config --global user.email "davidsiaw@gmail.com"
git config --global user.name "David Siaw (via Circle CI)"

docker create -v /app/data -v /app/images --name sources alpine:3.4 /bin/true
docker cp data/. sources:/app/data
docker cp images/. sources:/app/images
git clone git@github.com:astrobunny/wiki.astrobunny.net.git build
cp -r build/.git ./gittemp
docker run --volumes-from sources --name builder davidsiaw/hibiol build
rm -rf build
docker cp builder:/app/release build
cp -r ./gittemp build/.git
pushd build
echo wiki.astrobunny.net > CNAME
cp not_found/index.html 404.html
git add .
git add -u
git commit -m "update `date`"
git push
