
```
sudo apt install nvidia-driver-470
```

# Life3 sever
Note that installing nvidia driver is required after the major update on linux kernel
## install nvidia driver (3090)
Ref : https://www.cyberciti.biz/faq/how-to-install-nvidia-driver-on-centos-7-linux/

```
check
# lshw -numeric -C display
  *-display                 
       description: VGA compatible controller
       product: ASPEED Graphics Family [1A03:2000]
       vendor: ASPEED Technology, Inc. [1A03]
       physical id: 0
       bus info: pci@0000:03:00.0
       version: 41
       width: 32 bits
       clock: 33MHz
       capabilities: pm msi vga_controller cap_list rom
       configuration: driver=ast latency=0
       resources: irq:17 memory:98000000-9bffffff memory:9c000000-9c01ffff ioport:2000(size=128)
  *-display
       description: VGA compatible controller
       product: NVIDIA Corporation [10DE:2204]
       vendor: NVIDIA Corporation [10DE]
       physical id: 0
       bus info: pci@0000:d8:00.0
       version: a1
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress vga_controller bus_master cap_list rom
       configuration: driver=nvidia latency=0
       resources: iomemory:39ff0-39fef iomemory:39ff0-39fef irq:141 memory:fa000000-faffffff memory:39ffe0000000-39ffefffffff memory:39fff0000000-39fff1ffffff ioport:f000(size=128) memory:fb000000-fb07ffff
```

```
Stop GUI
# systemctl isolate multi-user.target
```


To install, visit the Nvidia download page [link](https://www.nvidia.com/Download/index.aspx)  
GeForce - GeForce RTX 30 Series - GeFOrce RTX 3090 - Linux 64-bite  
Download on `/home/root/Downloads/`

```
# Reboot
```

```
[root@life3 Downloads]# nvidia-smi
Sat Dec 11 11:30:22 2021       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 495.44       Driver Version: 495.44       CUDA Version: 11.5     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:D8:00.0 Off |                  N/A |
| 30%   28C    P0    88W / 350W |      0MiB / 24268MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+

# nvidia-settings
# systemctl restart multi-user.target

```
## driver API and runtime API
ref : https://bo-10000.tistory.com/73
- driver API: GPU driver installer, `nvidia-smi`
- runtime API: CUDA toolkit installer, `nvcc`

## uninstall nvidia-driver
https://partners-intl.aliyun.com/help/en/doc-detail/163825.htm#concept-wlr-tch-ygb  

# CUDA installation (Life3 server)
Ref : https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=CentOS&target_version=7&target_type=rpm_network
```
sudo yum-config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
sudo yum clean all
sudo yum -y install nvidia-driver-latest-dkms
sudo yum -y install cuda
```
# CUDA installation (GPU1 workstation)
Ref : https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=CentOS&target_version=7&target_type=rpm_network
- Trial and Error : it is required to kill all jobs in GPU (`nvidia-smi`)
- Success
```
===========
= Summary =
===========

Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-12.0/

Please make sure that
 -   PATH includes /usr/local/cuda-12.0/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-12.0/lib64, or, add /usr/local/cuda-12.0/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-12.0/bin
***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least 525.00 is required for CUDA 12.0 functionality to work.
To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
    sudo <CudaInstaller>.run --silent --driver

Logfile is /var/log/cuda-installer.log
```
```
nvidia-s,i
nvcc --version
```
# CUDA installation (GPU2 workstation)
```
sudo apt install nvidia-cuda-toolkit
```
```
===========
= Summary =
===========

Driver:   Installed
Toolkit:  Installed in /usr/local/cuda-12.0/

Please make sure that
 -   PATH includes /usr/local/cuda-12.0/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-12.0/lib64, or, add /usr/local/cuda-12.0/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-12.0/bin
To uninstall the NVIDIA Driver, run nvidia-uninstall
Logfile is /var/log/cuda-installer.log

```
