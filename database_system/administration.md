# psql guide
Ref: https://dbrang.tistory.com/749.  
connect to psql with username role as 'postgres'
- method 1
   ```
   $ psql -d postgres -U postgres
   ```
- method 2
   ```
   # su postgres
   # psql
   ```

# MANAGE DATABASES
## PostgreSQL Show Databases
Ref : https://www.postgresqltutorial.com/postgresql-administration/postgresql-show-databases/
```
postgres=# \l
postgres=# \l+
```

## Crate database
Ref : https://www.postgresqltutorial.com/postgresql-administration/postgresql-create-database/.    

Syntax
```
CREATE DATABASE database_name
WITH
   [OWNER =  role_name]
   [TEMPLATE = template]
   [ENCODING = encoding]
   [LC_COLLATE = collate]
   [LC_CTYPE = ctype]
   [TABLESPACE = tablespace_name]
   [ALLOW_CONNECTIONS = true | false]
   [CONNECTION LIMIT = max_concurrent_connection]
   [IS_TEMPLATE = true | false ]
```

Example
```
CREATE DATABASE pubchem_vina;
```
> Note : Do not forget to put semicolon(;) at the end of command.  
> Note : SQL takes only smaller letters


# MANAGE SCHEMAS
Ref: https://kimdubi.github.io/postgresql/pg_schema/
```
CREATE SCHEMA pubchem_vina
    AUTHORIZATION pubchem_vina;
```
```
CREATE TABLE pubchem_vina.docking
(
    receptor_id character varying NOT NULL,
    ligand_id character varying NOT NULL,
    binding_energy double precision NOT NULL
);

ALTER TABLE IF EXISTS pubchem_vina.docking
    OWNER to pubchem_vina;
```
# MANAGE TABLESPACES
# ROLES & PRIVILEGES
Ref : https://www.postgresqltutorial.com/postgresql-roles/  

- query all roles in database system
   ```
   # SELECT rolname FROM pg_roles;
             rolname
   ---------------------------
    pg_monitor
    pg_read_all_settings
    pg_read_all_stats
    pg_stat_scan_tables
    pg_read_server_files
    pg_write_server_files
    pg_execute_server_program
    pg_signal_backend
    postgres
    bob

    to list all existing roles in the current PostgreSQL database server.
    # \du
     Role name |                         Attributes                         | Member of
   -----------+------------------------------------------------------------+-----------
    postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
   Code language: Shell Session (shell)

   ```
- create a role
   ```
   # CREATE ROLE role_name;

   ```
- change password
   ```
   postgres=# ALTER USER postgres PASSWORD 'myPassword';
   ALTER ROLE
   ```
-  allow an user `app_readon` to have a read-only role  
   [Youtube video](https://www.youtube.com/watch?v=-2kYJ0gZmCo&ab_channel=E-MultiSkillsDatabaseTutorials)
   ```
   CREATE USER app_user WITH PASSWORD 'user';
   CREATE ROLE app_readonly;
   GRANT app_readonly To app_user;
   GRANT USAGE ON SCHEMA transfac To app_readonly;
   GRANT SELECT ON ALL TABLES in SCHEMA transfac To app_readonly;
   ```

# 21. Database Roles
PostgreSQL manages database access permissions using the concept of roles. A role can be thought of
as either a database user, or a group of database users, depending on how the role is set up. Roles can
own database objects (for example, tables and functions) and can assign privileges on those objects to
other roles to control who has access to which objects. Furthermore, it is possible to grant membership
in a role to another role, thus allowing the member role to use privileges assigned to another role.
The concept of roles subsumes the concepts of “users” and “groups”. In PostgreSQL versions before
8.1, users and groups were distinct kinds of entities, but now there are only roles. Any role can act
as a user, a group, or both.  
This chapter describes how to create and manage roles. More information about the effects of role
privileges on various database objects can be found in Section 5.7.  

## 21.1. Database Roles
Database roles are conceptually completely separate from operating system users. In practice it might
be convenient to maintain a correspondence, but this is not required. Database roles are global across
a database cluster installation (and not per individual database). To create a role use the CREATE
ROLE SQL command:

```
CREATE ROLE name;
DROP ROLE name;
```
> name follows the rules for SQL identifiers: either unadorned without special characters, or double-quoted. (In practice, you will usually want to add additional options, such as LOGIN, to the command. More details appear below.)


```
SELECT rolname FROM pg_roles;
```

# BACKUP & RESTORE


# pgAdmin4
```
xdg-open http://127.0.0.1/pgadmin4
```
