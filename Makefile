build:
	git checkout master
	docker build -t mybase .
	git checkout -b 18.04 origin/18.04 || git checkout 18.04
	docker build -t mybase:18.04 .
	git checkout -b 16.04 origin/16.04  || git checkout 18.04
	docker build -t mybase:16.04 .
