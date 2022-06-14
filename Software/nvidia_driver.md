
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
driver API: GPU driver installer, nvidia-smi
runtime API: CUDA toolkit installer, nvcc

## uninstall nvidia-driver
https://partners-intl.aliyun.com/help/en/doc-detail/163825.htm#concept-wlr-tch-ygb  
