# install jdk
```
Shell# wget [address]
Shell# tar -xvf [jdk file].tar
shell# cp -r ~/Downloads/jdk-17+35/ ./jdk-17+35/
shell# sudo ln -s /opt/jvm/jdk-17+35/ java
shell# cd /etc/profile.d/

shell# vi apps-bin-path.sh
# JAVA
JAVA_HOME=/opt/java/
export PATH=${JAVA_HOME}/bin:$PATH

shell# source apps-bin-path.sh 

```

# install Cytoscape
```
sudo sh Cytoscape_3_6_1_unix.sh
$ Cytoscape &
```
