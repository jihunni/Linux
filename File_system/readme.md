# Linux File System
## Logical Volume Manager (LVM)
Ref (concept): https://tech.cloud.nongshim.co.kr/2018/11/23/lvmlogical-volume-manager-1-%EA%B0%9C%EB%85%90/  
Ref (Ubuntu setting) : https://rootjs.tistory.com/26
```
root@life3:/# lsblk
NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0                       7:0    0    47M  1 loop /snap/snapd/16292
loop1                       7:1    0    62M  1 loop /snap/core20/1587
loop2                       7:2    0  79.9M  1 loop /snap/lxd/22923
sda                         8:0    0  87.3T  0 disk 
├─sda1                      8:1    0     1G  0 part /boot/efi
├─sda2                      8:2    0     2G  0 part /boot
└─sda3                      8:3    0  87.3T  0 part 
  └─ubuntu--vg-ubuntu--lv 253:0    0   100G  0 lvm  /
sr0                        11:0    1  1024M  0 rom  
nvme0n1                   259:0    0 931.5G  0 disk 
├─nvme0n1p1               259:1    0     1G  0 part 
├─nvme0n1p2               259:2    0     1G  0 part 
├─nvme0n1p3               259:3    0 897.5G  0 part 
└─nvme0n1p4               259:4    0    32G  0 part 

root@life3:/home# lvdisplay
  --- Logical volume ---
  LV Path                /dev/ubuntu-vg/ubuntu-lv
  LV Name                ubuntu-lv
  VG Name                ubuntu-vg
  LV UUID                CeDp3T-svxT-5RQz-23He-4sWh-31O2-4dhbYi
  LV Write Access        read/write
  LV Creation host, time ubuntu-server, 2023-02-15 11:35:39 +0000
  LV Status              available
  # open                 1
  LV Size                100.00 GiB
  Current LE             25600
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     4096
  Block device           253:0
   
root@life3:/home# lvcreate -L 87.21t -n data ubuntu-vg
  Rounding up size to full physical extent 87.21 TiB
  Logical volume "data" created.
root@life3:/home# lvdisplay
  --- Logical volume ---
  LV Path                /dev/ubuntu-vg/ubuntu-lv
  LV Name                ubuntu-lv
  VG Name                ubuntu-vg
  LV UUID                CeDp3T-svxT-5RQz-23He-4sWh-31O2-4dhbYi
  LV Write Access        read/write
  LV Creation host, time ubuntu-server, 2023-02-15 11:35:39 +0000
  LV Status              available
  # open                 1
  LV Size                100.00 GiB
  Current LE             25600
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     4096
  Block device           253:0
   
  --- Logical volume ---
  LV Path                /dev/ubuntu-vg/data
  LV Name                data
  VG Name                ubuntu-vg
  LV UUID                niF6nx-qk2O-3B5E-dGyl-aG74-zQ3q-4zGTU8
  LV Write Access        read/write
  LV Creation host, time life3, 2023-02-15 12:30:15 +0000
  LV Status              available
  # open                 0
  LV Size                87.21 TiB
  Current LE             22861579
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     4096
  Block device           253:1
   
root@life3:/home# mkfs.ext4 /dev/ubuntu-vg/data
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 23410256896 4k blocks and 1463142400 inodes
Filesystem UUID: 07bf636c-2b6e-49b4-a4a0-323d736e69a5
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
	4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968, 
	102400000, 214990848, 512000000, 550731776, 644972544, 1934917632, 
	2560000000, 3855122432, 5804752896, 12800000000, 17414258688

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (262144 blocks): done
Writing superblocks and filesystem accounting information: done         

root@life3:/home# lsblk
NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0                       7:0    0    47M  1 loop /snap/snapd/16292
loop1                       7:1    0    62M  1 loop /snap/core20/1587
loop2                       7:2    0  79.9M  1 loop /snap/lxd/22923
sda                         8:0    0  87.3T  0 disk 
├─sda1                      8:1    0     1G  0 part /boot/efi
├─sda2                      8:2    0     2G  0 part /boot
└─sda3                      8:3    0  87.3T  0 part 
  ├─ubuntu--vg-ubuntu--lv 253:0    0   100G  0 lvm  /
  └─ubuntu--vg-data       253:1    0  87.2T  0 lvm  
sr0                        11:0    1  1024M  0 rom  
nvme0n1                   259:0    0 931.5G  0 disk 
├─nvme0n1p1               259:1    0     1G  0 part 
├─nvme0n1p2               259:2    0     1G  0 part 
├─nvme0n1p3               259:3    0 897.5G  0 part 
└─nvme0n1p4               259:4    0    32G  0 part

root@life3:/home# mount /dev/ubuntu-vg/data /home

root@life3:/home# df -h
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                               38G  2.6M   38G   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   98G   11G   83G  12% /
tmpfs                              189G     0  189G   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/sda2                          2.0G  127M  1.7G   7% /boot
/dev/sda1                          1.1G  5.3M  1.1G   1% /boot/efi
tmpfs                               38G  4.0K   38G   1% /run/user/1000
/dev/mapper/ubuntu--vg-data         87T   24K   83T   1% /home


```


Question : what's the difference?
/bin/   
/sbin/   
/usr/bin/   
/usr/local/bin/   
/usr/local/sbin/   

Answer   
[link1](https://unix.stackexchange.com/questions/8656/usr-bin-vs-usr-local-bin-on-linux) [link2](https://unix.stackexchange.com/questions/11544/what-is-the-difference-between-opt-and-usr-local) [link3](https://superuser.com/questions/122420/usr-local-or-opt)   
- `/bin` (and `/sbin`) were intended for programs that needed to be on a small / partition before the larger `/usr`, etc. partitions were mounted. These days, it mostly serves as a standard location for key programs like `/bin/sh`, although the original intent may still be relevant for e.g. installations on small embedded devices.
- `/sbin`, as distinct from `/bin`, is for system management programs (not normally used by ordinary users) needed before /usr is mounted.
- `/usr/bin` is for **distribution-managed** normal user programs. 
- There is a `/usr/sbin` with the same relationship to `/usr/bin` as `/sbin` has to `/bin`.
- `/usr/local` : a place to install files built **by the administrator**, and that has to be compiled and installed Unix-styple and compiles to FHS, typically by using the `make` command (e.g., `./configure; make; make install`). The idea is to avoid clashes with files that are part of the operating system, which would either be overwritten or overwrite the local ones otherwise (e.g., `/usr/bin/foo` is part of the OS while `/usr/local/bin/foo` is a local alternative).   All files under `/usr` are shareable between OS instances, although this is rarely done with Linux. This is a part where the FHS is slightly self-contradictory, as `/usr` is defined to be read-only, but `/usr/local/bin` needs to be read-write for local installation of software to succeed. The SVR4 file system standard, which was the FHS' main source of inspiration, is recommending to avoid `/usr/local` and use `/opt/local` instead to overcome this issue.
- `/usr/local/bin` is for normal user programs **not managed by the distribution package manager**, e.g. locally compiled packages. You should not install them into `/usr/bin` because future distribution upgrades may modify or delete them without warning.
- `/usr/local/sbin`, as you can probably guess at this point, is to `/usr/local/bin` as `/usr/sbin` to `/usr/bin`.
- `/opt` : a directory for installing unbundled packages (i.e. **packages not part of the Operating System distribution**, but provided by an independent source), each one in its own subdirectory. (e.g. e.g. a java web-application that comes with it's own applicationserver and loads of resources in a zip archive) They are already built whole packages provided by an independent third party software distributor. Unlike `/usr/local` stuff, these packages follow the directory conventions (or at least they should). For example, `someapp` would be installed in `/opt/someapp`, with one of its command being `/opt/someapp/bin/foo`, its configuration file would be in /`etc/opt/someapp/foo.conf`, and its log files in `/var/opt/someapp/logs/foo.access`. In other word, it is for monolithic non-distribution packages, although before they were properly integrated various distributions put Gnome and KDE there. Generally you should reserve it for large, poorly behaved third party packages such as Oracle.


Comment
- check `man hier`   
- Consider that File system for server uses partision. Each dictory may use different physical disk. For example, `/bin/` and `/usr/local/bin` could use different disk.


# mount
Ref : https://bluexmas.tistory.com/632
- Permanent mount
	Ref: https://devconnected.com/how-to-mount-and-unmount-drives-on-linux/
	To list up the partition
	```
	$ sudo fdisk -l
	```
	
	```
	$ sudo nano /etc/fstab

	# <file system>              <mount point>              <type>  <options>   <dump>  <pass>
	UUID=0935df16-40b0-48      /home/user/mountpoint      ext4    defaults    0       0 
	```
	- Filesystem : you can either specify a UUID (for universal unique identifier), a label (if you chose a label for your disk), a network ID or a device name (which is not recommended at all);
	- Mountpoint : the directory on the filesystem that you are going to use in order to access data stored on the disk;
	- Filesystem type : the type of filesystem you use to format your disk;
	- Options : some options that you can specify in order to tune your mount (“ro” for a read-only mount or “noexec” to prevent binary execution);
	- Dump : in order to enable to disable filesystem dumping on the system (using the dump command);
	- Pass Num : sets the order used in order for the “fsck” utility to check your filesystem. If you are not mounting the root device, you should set this option to “2” or “0” as “1” is reserved for the root device.

# Samba
Prepare an environment to install Samba
```
$ yum update –y
$ yum clean all
$ yum install –y epel-release
$ yum update –y
```

setting file : /etc/samba/smb.conf

```
# samba 설치
yum -y install samba

# samba 서비스 실행
systemctl start smb
systemctl enable smb

# samba 계정 등록
useradd smbuser
passwd smbuser
smbpasswd -a smbuserq

# 공유 폴더 생성 및 권한 설정
mkdir /share
mkdir /share/data
chown -R smbuser.root /share
```
> smbpasswd -a : 
>            This option specifies that the username following should be added to the local smbpasswd file, with the new password typed (type <Enter> for
           the old password). This option is ignored if the username following already exists in the smbpasswd file and it is treated like a regular
           change password command. Note that the default passdb backends require the user to already exist in the system password file (usually
           /etc/passwd), else the request to add the user will fail.        
          This option is only available when running smbpasswd as root.
  
## reference: 
  - https://blog.naver.com/ncloud24/221499582757
  - https://nirsa.tistory.com/195
           
# Conpression
## rar
- install (ubuntu)
Ref : https://m.blog.naver.com/chandong83/220868668544
- usage
Ref : https://lascrea.tistory.com/144
