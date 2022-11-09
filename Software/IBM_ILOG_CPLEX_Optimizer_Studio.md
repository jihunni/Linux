# Install on Linux
```
/opt/ibm/ILOG/CPLEX_Studio_Community221
```
If you want to use the CPLEX or CP Optimizer engines through their Python 
APIs, you need to tell Python where to find them.  To do so, enter the 
following command into a terminal :
```
python /opt/ibm/ILOG/CPLEX_Studio_Community221/python/setup.py install
```

Module ENV     
Ref: https://www.ibm.com/support/pages/entering-your-api-key-and-setting-cplexstudiokey-environment-variable
```
set version     22.1.0
setenv  CPLEX_STUDIO_DIR221     /opt/ibm/ILOG/CPLEX_Studio_Community221/
setenv  CPLEX_STUDIO_KEY        API..KEY...
```
