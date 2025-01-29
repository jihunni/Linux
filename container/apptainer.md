# Apptainer
- To build from an image cached by the Docker daemon in a definition file
  Ref : https://apptainer.org/docs/user/main/definition_files.html
  ```
  Bootstrap: docker
  From: some-image-that-uses-root-and-opt

  %setup
    # NOTE: This is executed on the host, not the container
  %files
     # Copy over files from the host to the container
     # Copy over the timezone info
     /etc/localtime
     # Copy over the hosts file
     /etc/hosts
     # Copy over the apt sources list
     /etc/apt/sources.list
     /archive/software/Miniconda3-latest-Linux-x86_64.sh /opt/miniconda.sh
     environment.yaml /opt/environment.yaml


  %post
    # Perform the bulk of the build steps within the container
      mkdir -p /global/path/directories/my/script/uses
      chmod -R 775 /opt
      chmod -R 775 /root
      chmod -R 775 /
      touch /bin/nvidia-smi #these commands and below have to do with using Nvidia drivers
      touch /usr/bin/nvidia-smi
      touch /usr/bin/nvidia-debugdump
      touch /usr/bin/nvidia-persistenced
      touch /usr/bin/nvidia-cuda-mps-control
      touch /usr/bin/nvidia-cuda-mps-server
      mkdir /etc/dcv
      mkdir /var/lib/dcv-gl
      mkdir /usr/lib64
    # General setup
      # Switch shell to bash
      ln -sf /bin/bash /bin/sh

     # Install build essentials and other required packages (needed for compiling biotite cython files)

     apt-get install -y build-essential gcc g++
     # Install make (so we can run `make format`, `make clean`, etc.)
     apt-get install -y make
     # required X libs
     apt-get install -y libx11-6 libxau6 libxext6 libxrender1

     #  git
     apt-get install -y git
     apt-get install -y libaio-dev
     apt-get clean

     # install python library using PIP
     pip install [package_name] --break-system-packages

  ```
- build a image (sif file)
  ```
  apptainer build [container_name.sif] [continaer_spec.spec]
  ```
  - Error handling
    - `/.singularity.d/libs/faked: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found`
      Ref : https://github.com/apptainer/apptainer/issues/2103   
      ```
      sudo apptainer config fakeroot --add $USER
      ```
      
- To fetch a docker image
  Ref : https://apptainer.org/docs/user/main/docker_and_oci.html
  ```
  # To run the container 
  $ apptainer run [docker_image_address]

  # To obtain the Docker container as a SIF file in a specific location, which you can move, share, and keep for later,
  $ apptainer pull [docker_image_address]
  
  ```

- Run container
  ```
  # To access a shell
  apptainer [global options...] shell [shell options...] <container> (--writable --fakeroot)

  # To run a job in current cmd
  [apptainer_sif] [arguemnt]
  (e.g.) /path/to/image.sif myscript.py [argument]
  apptainer exec –nv /path/to/image.sif program [arguments]
  ```
- fakeroot feature
  Ref : https://apptainer.org/docs/user/main/fakeroot.html   
- Persistent Overlays
