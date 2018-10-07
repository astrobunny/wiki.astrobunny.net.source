#!/bin/bash
set -e
git config --global user.email "davidsiaw@gmail.com"
git config --global user.name "David Siaw (via Circle CI)"

git clone git@github.com:davidsiaw/hibiol.davidsiaw.net.git build
cp -r build/.git ./gittemp
docker run -v `pwd`/build:/app/release -v `pwd`/data:/app/data -v `pwd`/images:/app/images -ti davidsiaw/hibiol build
cp -r ./gittemp build/.git
pushd build
echo hibiol.davidsiaw.net > CNAME
cp not_found/index.html 404.html
cp -r ../css/fonts css
git add .
git add -u
git commit -m "update `date`"
ssh-agent bash -c 'ssh-add ~/.ssh/id_github.com; git push'
popd
