#!/bin/sh

service mysql start

while ! mysqladmin ping --silent; do
    sleep 1
done

sed "s/_FLAG_/${FLAG}/g" lab.sql.tmpl > lab.sql

mysql -uroot < lab.sql
gunicorn app:app -b 0.0.0.0:$PORT

