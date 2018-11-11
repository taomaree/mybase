# mybase
docker base image 

# branch
mybase:latest   ubuntu 18.10 openssl 1.1.1 rsyslog-kafka
mybase:18.04    ubuntu 18.04 openssl 1.1.0 rsyslog-kafka
mybase:16.04    ubuntu 16.04 openssl 1.0.2 rsyslog

# build latest 
git checkout master
docker build -t mybase .

# build 18.04
git checkout -b 18.04 origin/18.04
docker build -t mybase:18.04 .

# build 16.04
git checkout -b 16.04 origin/16.04
docker build -t mybase:16.04 .



