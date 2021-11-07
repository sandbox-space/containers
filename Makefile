all: php mariadb nginx s3cmd

php: php_72 php_80
mariadb: mariadb_10_5 mariadb_10_6
nginx: nginx_1_19 nginx_1_20 nginx_1_21

php_72:
	cd php/7.2 && make all

php_80:
	cd php/8.0 && make all

mariadb_10_5:
	cd mariadb/10.5 && make all

mariadb_10_6:
	cd mariadb/10.6 && make all

nginx_1_19:
	cd nginx/1.19 && make all

nginx_1_20:
	cd nginx/1.20 && make all

nginx_1_21:
	cd nginx/1.21 && make all

s3cmd:
	cd s3cmd && make all