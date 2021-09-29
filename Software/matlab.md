# install matlab and environment setting
## ionstall matlab
```
# start license mamger
/opt/matlab/R2021b_license/etc/glnxa64/lmgrd -c /opt/matlab/R2021b_license/etc/license.dat -l /var/tmp/lm_TMW.log
```
> -c : license file directory  
> -l : log file   

Reference : 
- https://kr.mathworks.com/matlabcentral/answers/102968-how-do-i-start-or-stop-the-network-license-manager
- https://kr.mathworks.com/support/bugreports/581959
- 


## install gurobi optimizer

## Module environment
```

#%Module1.0#####################################################################
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


setenv          MODULESHOME $prefix
prepend-path    PATH        /opt/matlab/R2021b/bin
prepend-path    GUROBI_HOME /opt/gurobi/gurobi_optimizer/9.1.2
prepend-path    PATH /opt/gurobi/gurobi_optimizer/9.1.2/bin
prepend-path    LD_LIBRARY_PATH /opt/gurobi/gurobi_optimizer/9.1.2/lib
prepend-path    GUROBI_PATH /opt/gurobi/gurobi_optimizer/9.1.2

# enable module versioning modulepath
#module use /usr/share/modules/versions

```

# COBRA toolkit
```
>> initCobraToolbox(false)
```
```


