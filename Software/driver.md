# ubuntu : second monitor is not recongized after updating
```
xrandr
```

```
sudo ubuntu-drivers autoinstall
```

```
sudo apt-get purge 'nvidia*'
sudo add-apt-repository ppa:graphics-drivers
sudo apt-get update
```

# reference :
- https://askubuntu.com/questions/1033785/external-monitor-not-detected-on-ubuntu-18-04
