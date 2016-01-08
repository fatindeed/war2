# 疯狂二战

Git init commands for Apache
	cd apache_dir
	git init
	git config core.sparseCheckout true
	git remote add -f origin https://github.com/fatindeed/war2.git
	echo htdocs/* > .git/info/sparse-checkout
	git checkout master
