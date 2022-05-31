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
- insert
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
	```
- 

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
