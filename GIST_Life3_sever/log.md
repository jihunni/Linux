- 2022.08.24
  -  install `CUDA`
  -  update `cmake` (2.8.12.2 -> 3.24.1)
  	- /usr/local/share/cmake-3.24/
- 2022.08.26
  - yum update 
- 2022.08.31
	- gcc update  
		Ref : https://www.softwarecollections.org/en/scls/rhscl/devtoolset-7/  
		https://ryotta-205.tistory.com/50   
		```
		$ sudo yum install centos-release-scl
		$ sudo yum-config-manager --enable rhel-server-rhscl-7-rpms
		$ sudo yum install devtoolset-8
		$ scl enable devtoolset-8 bash
		```
	- 
