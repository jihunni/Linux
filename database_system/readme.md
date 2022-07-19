# psql guide
ref : https://dbrang.tistory.com/749
- access to psql
  general
  ```
  $ psql -d [database_name] -U [role_name]
  ```
  example
  ```
  $ psql -d pubchem_vina -U jihun
  $ psql -d pubchem_vina -U pubchem_vina
  ```
- 

# PostgreSQL basics
- datatype
  ref : https://www.postgresql.org/docs/current/datatype.html
  - float
  - double
  - timestamp
  - 
- 
# Database
- create table
  ```
  CREATE TABLE ACCOUNT_TEST(
	USER_ID SERIAL PRIMARY KEY,
	USERNAME VARCHAR(50) UNIQUE NOT NULL,
	PASSWORD VARCHAR(50) NOT NULL,
	EMAIL VARCHAR(355) UNIQUE NOT NULL,
	CREATED_ON TIMESTAMP NOT NULL,
	LAST_LOGIN TIMESTAMP
  );
  ```
  ```
  CREATE TABLE vina(
	receptor_id VARCHAR(20) NOT NULL,
  ligand_id VARCHAR(20) NOT NULL,
  binding_affinity  FLOAT(8)
  );
  ```
- alter table
	```
	ALTER TABLE pubchem_vina.docking
		ADD CONSTRAINT unique_id UNIQUE (receptor_ensembl_id, pubchem_compud_cid);
	```
- insert instance
  Ref : https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-insert/.  
  syntax
  ```
  INSERT INTO table_name(column1, column2, …)
  VALUES (value1, value2, …);
  ```
  Ref: https://edudeveloper.tistory.com/131
  ```
  def insertDB(schema,table,colum,data):
    sql = "INSERT INTO {schema}.{table} ({colum}) VALUES ({data}) ;".format(schema=schema,table=table,colum=colum,data=data)
    print(sql)
    try:
        cursor.execute(sql)
        db_connect.commit()
    except Exception as e :
        print(" insert DB  ",e) 
  ```
  
  example
  ```
  INSERT INTO links (url, name)
  VALUES('http://www.oreilly.com','O''Reilly Media');
  ```
  ```
  INSERT INTO pubchem_vina.docking (receptor_ensembl_id, pubchem_compud_cid, binding_energy) VALUES (0, 'ENSG00000137513', -6.472) ;
  ```
- delete
	remove all tuples in a table
	```
	delete from pubchem_vina.docking * ;
	```
- 
- query
	```
	SELECT * FROM pubchem_vina.docking;
	SELECT * FROM pubchem_vina.docking ORDER BY binding_energy ASC;
	SELECT * FROM pubchem_vina.docking ORDER BY binding_energy DESC;
	SELECT COUNT(pubchem_compud_cid) FROM  pubchem_vina.docking;
	```
- To export query results in a file  
	ref : https://linuxconfig.org/saving-an-output-of-postgresql-query-to-a-text-file  
	```
	\o /home/jihun/data/query_output.txt
	EXECUTE QUERY
	\o
	```

# PostgreSQL Python : 
connect to PostgreSQL Database Severy
https://www.postgresqltutorial.com/postgresql-python/connect/

install python library 'psycopg2'
```
pip install psycopg2
```

conda env
```
conda activate postgresql
python
```

To connect a database in python
```
import psycopg2
conn = psycopg2.connect(host='localhost',database='database_name',user='userID',password='userPassword')
```
To insert
```
import psycopg2 
db_connect = psycopg2.connect(host='localhost',database='DB_name',user='user_name',password='user_password')
cursor=db_connect.cursor()

def insertDB(schema,table,colum,data):
    sql = "INSERT INTO {schema}.{table} ({colum}) VALUES ({data}) ;".format(schema=schema,table=table,colum=colum,data=data)
    print(sql)
    try:
        cursor.execute(sql)
        db_connect.commit()
    except Exception as e :
        print(" insert DB  ",e) 

insertDB(schema='pubchem_vina',table='docking', colum='receptor_ensembl_id, pubchem_compud_cid, binding_energy', data=f"'{receptor_id}', '{ligand_id}', {binding_energy}")

db_connect.close ()
```
To query
```
import psycopg2 
import pandas as pd
db_connect = psycopg2.connect(host='localhost',database='DB_name',user='user_name',password='user_password')
cursor=db_connect.cursor()

def queryDB():
	""" query parts from the parts table """
	sql = "SELECT binding_energy FROM pubchem_vina.docking ;"
	print(sql)
	try:
		cursor.execute(sql)
		rows = cursor.fetchall()
		print("The number of parts: ", cursor.rowcount)
		cursor.close()
		return rows
	except Exception as e :
		print(" query DB  ",e) 
	finally:
		if db_connect is not None:
		    db_connect.close()

query_result = queryDB() 
	# a list of tuples
	# e.g. [(-6.5,), (-4.3,) ]
query_result = [float(x[0]) for x in query_result]
query_result = pd.Series(query_result)
query_result.to_csv('PostgreSQL_query_out.csv', sep=',', na_rep='Na', index=False, header=True)
```
