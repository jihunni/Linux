# OpenMPI | [homepage](https://www.open-mpi.org/)
## install OpenMPI 

```
shell# ./configure --prefix=/opt/OpenMPI/4.1.1/
Open MPI configuration:
-----------------------
Version: 4.1.1
Build MPI C bindings: yes
Build MPI C++ bindings (deprecated): no
Build MPI Fortran bindings: mpif.h, use mpi
MPI Build Java bindings (experimental): no
Build Open SHMEM support: false (no spml)
Debug build: no
Platform file: (none)

Miscellaneous
-----------------------
CUDA support: no
HWLOC support: internal
Libevent support: internal
PMIx support: Internal

Transports
-----------------------
Cisco usNIC: no
Cray uGNI (Gemini/Aries): no
Intel Omnipath (PSM2): no
Intel TrueScale (PSM): no
Mellanox MXM: no
Open UCX: no
OpenFabrics OFI Libfabric: no
OpenFabrics Verbs: yes
Portals4: no
Shared memory/copy in+copy out: yes
Shared memory/Linux CMA: yes
Shared memory/Linux KNEM: no
Shared memory/XPMEM: no
TCP: yes

Resource Managers
-----------------------
Cray Alps: no
Grid Engine: no
LSF: no
Moab: no
Slurm: yes
ssh/rsh: yes
Torque: no

OMPIO File Systems
-----------------------
DDN Infinite Memory Engine: no
Generic Unix FS: yes
IBM Spectrum Scale/GPFS: no
Lustre: no
PVFS2/OrangeFS: no


shell# make all install
```
