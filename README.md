# 疯狂二战

Apache deployment on server
```sh
cd ApacheDir
git init
git config core.sparseCheckout true
git remote add -f origin https://github.com/fatindeed/war2.git
echo htdocs/* > .git/info/sparse-checkout
git checkout master
```

Tomcat deployment on server

Client deployment
```sh
cd ProjectDir/assets
set HtdocsDir=C:\Users\James\Documents\GitHub\war2\htdocs\
mklink /J Actini %HtdocsDir%Actini
mklink /J ActionSet %HtdocsDir%ActionSet
mklink /J Building %HtdocsDir%Building
mklink /J Config %HtdocsDir%Config
mklink /J Layout %HtdocsDir%Layout
mklink /J Schema %HtdocsDir%Schema
mklink /J Shape %HtdocsDir%Shape
mklink LoginServer.cfg %HtdocsDir%LoginServer.cfg
```
