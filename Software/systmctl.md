# systemctl : control the systemd system and service manager
```
# general command
systemctl enable [system_name]
systemctl start [system_name]
systemctl status [system_name]
systemctl stop [ system_name]
systemctl restart [system_name]

# example
sudo /usr/pgsql-13/bin/postgresql-13-setup initdb
sudo systemctl enable postgresql-13
sudo systemctl start postgresql-13
```
