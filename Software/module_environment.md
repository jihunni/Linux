# Installation
Ref: https://modules.readthedocs.io/en/latest/INSTALL.html
- to add additional modulefiles path, add this line to the following file.
	```
	$ vi cd /usr/local/Modules/etc/initrc
	
	module use --append /opt/Modules/modulefiles
	```
# module environment
- setting variable  
	set : assign variable
	prepend-path : save path. Here, assigning variable is impossible.

- example
	```
	##
	## modules modulefile
	##
	proc ModulesHelp { } {
		  global version prefix

		  puts stderr "\tmodules - loads the modules software & application environment"
		  puts stderr "\n\tThis adds $prefix/* to several of the"
		  puts stderr "\tenvironment variables."
		  puts stderr "\n\tVersion $version\n"
	}

	module-whatis   "loads the modules environment"

	# for Tcl script use only
	set version     R2021b
	set prefix      /opt/matlab/R2021b/bin
	set GUROBI_HOME /opt/gurobi/gurobi912

	setenv          MODULESHOME $prefix
	prepend-path    PATH            /opt/matlab/R2021b/bin
	prepend-path    GUROBI_HOME     $GUROBI_HOME
	prepend-path    GUROBI_PATH     $GUROBI_HOME
	prepend-path    PATH            ${GUROBI_HOME}/bin
	prepend-path    LD_LIBRARY_PATH ${GUROBI_HOME}/lib

	# enable module versioning modulepath
	#module use /usr/share/modules/versions

	```

# centos7
path : /usr/share/Modules/init
