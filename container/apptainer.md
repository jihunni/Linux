# Apptainer
- build container
  ```
  apptainer build [container_name.sif] [continaer_spec.spec]
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
  apptainer [global options...] shell [shell options...] <container>

  # To run a job in current cmd
  [apptainer_sif] [arguemnt]
  (e.g.) /path/to/image.sif myscript.py [argument]
  apptainer exec –nv /path/to/image.sif program [arguments]
  ```
- 
