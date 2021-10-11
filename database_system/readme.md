# database roles
Ref : https://www.postgresqltutorial.com/postgresql-roles/  


query all roles in database system
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
create a role
```
# CREATE ROLE role_name;

```
change password
```
postgres=# ALTER USER postgres PASSWORD 'myPassword';
ALTER ROLE
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
