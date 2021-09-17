# 
```
# systemctl status -l rstudio-server
● rstudio-server.service - RStudio Server
   Loaded: loaded (/usr/lib/systemd/system/rstudio-server.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-09-14 14:55:57 KST; 25min ago
  Process: 63009 ExecStop=/usr/bin/killall -TERM rserver (code=exited, status=0/SUCCESS)
  Process: 63011 ExecStart=/usr/lib/rstudio-server/bin/rserver (code=exited, status=0/SUCCESS)
 Main PID: 63012 (rserver)
    Tasks: 28
   Memory: 10.7G
   CGroup: /system.slice/rstudio-server.service
           ├─61538 /usr/lib/rstudio-server/bin/rsession -u gyuho --session-use-secure-cookies 0 --session-root-path / --session-same-site 0 --launcher-token 9ADD87F3 --r-restore-workspace 2 --r-run-rprofile 2
           ├─63012 /usr/lib/rstudio-server/bin/rserver
           ├─64027 /usr/lib/rstudio-server/bin/rsession -u assistant_manager --session-use-secure-cookies 0 --session-root-path / --session-same-site 0 --launcher-token 884BBFC6 --r-restore-workspace 2 --r-run-rprofile 2
           ├─64700 /usr/lib/rstudio-server/bin/rsession -u swl409 --session-use-secure-cookies 0 --session-root-path / --session-same-site 0 --launcher-token 884BBFC6
           └─64801 bash -l

```

# login error
```
# remove the R login session info with error
rm -rf /home/gyuho/.local/*

# copy new login session info
cp -r /home/assistant_manager/.local/*  /home/gyuho/.local/

# change ownership from root to user
chown gyuho .local
```

# reference
https://onesixx.com/resuming-r-session/
