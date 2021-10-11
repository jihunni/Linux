# install PostgreSQL12 on Centos7
```
/usr/pgsql-13/bin/postgresql96-setup initdb
/var/lib/pgsql/13/data
```

PostgreSQL 관리자 암호 설정
```
$ sudo su postgres
$ psql -c " 'StrongDBPassword'암호로 사용자 postgres 변경" ALTER ROLE
```



원격 데이터베이스 연결 활성화 (선택 사항)
```
vi /var/lib/pgsql/13/data/pg_hba.conf
```
reference: 
- https://browndwarf.tistory.com/1
- https://quiz12.tistory.com/99


# remote connection
https://docs.bitnami.com/virtual-machine/infrastructure/postgresql/administration/connect-remotely/
```
```

```
# check systemctl
systemctl status postgresql-13
```

## FATAL: Peer authentication failed for user
Ref:
- https://bono915.tistory.com/entry/Postgresql-FATAL-Peer-authentication-failed-for-user-%EC%98%A4%EB%A5%98
- https://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge
```
 vi /var/lib/pgsql/13/data/pg_hba.conf
```
# Postgres
```
$ psql -U <dbuser> -h <serverip> -p 5432 <dbname> 
$ psql -U [role_name] -W [DB_name]
```

```
# log in psql
bash$ psql
psql#
```


# Install pgAdmin 4
Ref : https://www.pgadmin.org/download/pgadmin-4-rpm/

# PostgreSQL Administration
Ref : [https://www.postgresqltutorial.com/postgresql-administration/](https://www.postgresqltutorial.com/postgresql-administration/)

```
# to setup the repository for this set of builds 
rpm -i https://ftp.postgresql.org/pub/pgadmin/pgadmin4/yum/pgadmin4-redhat-repo-2-1.noarch.rpm

# Install for both desktop and web modes.
sudo yum install pgadmin4

# Install for desktop mode only.
sudo yum install pgadmin4-desktop

# Install for web mode only.
sudo yum install pgadmin4-web

# run the web setup script to configure the system to run in web mode:
sudo /usr/pgsql-13/bin/setup-web.sh

# run pgadmin4 in web
xdg-open http://127.0.0.1/pgadmin4
```

Ref (ubuntu) : 
- https://www.tecmint.com/install-postgresql-and-pgadmin-in-ubuntu/
