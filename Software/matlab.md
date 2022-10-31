# install matlab and environment setting
## matlab license manger (Life1 server)
- download the installer in matlab homepage (link : https://kr.mathworks.com/downloads/web_downloads)
- execute the installer and select the option `install license manger`
- run the license mamager
	```
	# start license mamger
	/opt/matlab/R2022b_license/etc/glnxa64/lmgrd -c /opt/matlab/R2022b_license/etc/license.dat -l /var/tmp/lm_TMW.log
	```
	> -c : license file directory  
	> -l : log file  

## install matlab
 Reference : 
- https://kr.mathworks.com/matlabcentral/answers/102968-how-do-i-start-or-stop-the-network-license-manager
- https://kr.mathworks.com/support/bugreports/581959
- symbolic link in `/usr/local/bin`
- install with installer - login - select the version - install
## install gurobi optimizer
- install Gurobi
	/opt/gurobi
- To activate Academic License,
	- get license key from Homepage
	- activate the license key
		```
		$ /opt/gurobi/gurobi912/linux64/bin/grbgetkey
		```
	
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

# restart license manager 
Ref : https://kr.mathworks.com/matlabcentral/answers/102968-how-do-i-start-or-stop-the-network-license-manager
General code
```
Shell# cd /usr/local/MATLAB/R2019a/etc/glnxa64
Shell# lmgrd -c <PATH_TO_LICENSE_FILE> -l <PATH_TO_LOG_FILE>
```

running code
```
Shell# cd /opt/matlab/R2021b_license/etc/glnxa64/
Shell# ./lmgrd -c ../license.dat 
21:53:14 (lmgrd) -----------------------------------------------
21:53:14 (lmgrd)   Please Note:
21:53:14 (lmgrd) 
21:53:14 (lmgrd)   This log is intended for debug purposes only.
21:53:14 (lmgrd)   In order to capture accurate license
21:53:14 (lmgrd)   usage data into an organized repository,
21:53:14 (lmgrd)   please enable report logging. Use Flexera's
21:53:14 (lmgrd)   software license administration  solution,
21:53:14 (lmgrd)   FlexNet Manager, to  readily gain visibility
21:53:14 (lmgrd)   into license usage data and to create
21:53:14 (lmgrd)   insightful reports on critical information like
21:53:14 (lmgrd)   license availability and usage. FlexNet Manager
21:53:14 (lmgrd)   can be fully automated to run these reports on
21:53:14 (lmgrd)   schedule and can be used to track license
21:53:14 (lmgrd)   servers and usage across a heterogeneous
21:53:14 (lmgrd)   network of servers including Windows NT, Linux
21:53:14 (lmgrd)   and UNIX.
21:53:14 (lmgrd) 
21:53:14 (lmgrd) -----------------------------------------------
21:53:14 (lmgrd) 
21:53:14 (lmgrd) 
21:53:14 (lmgrd) Server's System Date and Time: Sat Nov 06 2021 21:53:14 KST
21:53:14 (lmgrd) SLOG: Summary LOG statistics is enabled.
21:53:14 (lmgrd) The license server manager (lmgrd) running as root:
21:53:14 (lmgrd) 	This is a potential security problem
21:53:14 (lmgrd) 	and is not recommended.
[root@life1 glnxa64]# 21:53:14 (lmgrd) FlexNet Licensing (v11.16.2.1 build 244538 x64_lsb) started on life1 (linux) (11/6/2021)
21:53:14 (lmgrd) Copyright (c) 1988-2018 Flexera. All Rights Reserved.
21:53:14 (lmgrd) World Wide Web:  http://www.flexerasoftware.com
21:53:14 (lmgrd) License file(s): ../license.dat
21:53:14 (lmgrd) lmgrd tcp-port 27000
21:53:14 (lmgrd) (@lmgrd-SLOG@) ===============================================
21:53:14 (lmgrd) (@lmgrd-SLOG@) === LMGRD ===
21:53:14 (lmgrd) (@lmgrd-SLOG@) Start-Date: Sat Nov 06 2021 21:53:14 KST
21:53:14 (lmgrd) (@lmgrd-SLOG@) PID: 10859
21:53:14 (lmgrd) (@lmgrd-SLOG@) LMGRD Version: v11.16.2.1 build 244538 x64_lsb ( build 244538 (ipv6))
21:53:14 (lmgrd) (@lmgrd-SLOG@) 
21:53:14 (lmgrd) (@lmgrd-SLOG@) === Network Info ===
21:53:14 (lmgrd) (@lmgrd-SLOG@) Listening port: 27000
21:53:14 (lmgrd) (@lmgrd-SLOG@) 
21:53:14 (lmgrd) (@lmgrd-SLOG@) === Startup Info ===
21:53:14 (lmgrd) (@lmgrd-SLOG@) Server Configuration: Single Server
21:53:14 (lmgrd) (@lmgrd-SLOG@) Command-line options used at LS startup: -c ../license.dat 
21:53:14 (lmgrd) (@lmgrd-SLOG@) License file(s) used:  ../license.dat
21:53:14 (lmgrd) (@lmgrd-SLOG@) ===============================================
21:53:14 (lmgrd) Starting vendor daemons ... 
21:53:14 (lmgrd) Started MLM (internet tcp_port 42249 pid 10861)
21:53:14 (MLM) FlexNet Licensing version v11.16.2.1 build 244538 x64_lsb
21:53:14 (MLM) SLOG: Summary LOG statistics is enabled.
21:53:14 (MLM) SLOG: FNPLS-INTERNAL-CKPT1
21:53:14 (MLM) SLOG: VM Status: 0
21:53:14 (MLM) SLOG: FNPLS-INTERNAL-CKPT5
21:53:14 (MLM) SLOG: TPM Status: 0
21:53:14 (MLM) SLOG: FNPLS-INTERNAL-CKPT6
21:53:14 (MLM) Server started on life1 for:	MATLAB		
21:53:14 (MLM) Bioinformatics_Toolbox Statistics_Toolbox 
21:53:14 (MLM) EXTERNAL FILTERS are OFF
21:53:14 (lmgrd) MLM using TCP-port 42249
21:53:14 (MLM) License verification completed successfully.
21:53:14 (MLM) SLOG: Statistics Log Frequency is 240 minute(s).
21:53:14 (MLM) SLOG: TS update poll interval is 600 seconds.
21:53:14 (MLM) SLOG: Activation borrow reclaim percentage is 0.
21:53:14 (MLM) (@MLM-SLOG@) ===============================================
21:53:14 (MLM) (@MLM-SLOG@) === Vendor Daemon ===
21:53:14 (MLM) (@MLM-SLOG@) Vendor daemon: MLM
21:53:14 (MLM) (@MLM-SLOG@) Start-Date: Sat Nov 06 2021 21:53:14 KST
21:53:14 (MLM) (@MLM-SLOG@) PID: 10861
21:53:14 (MLM) (@MLM-SLOG@) VD Version: v11.16.2.1 build 244538 x64_lsb ( build 244538 (ipv6))
21:53:14 (MLM) (@MLM-SLOG@) 
21:53:14 (MLM) (@MLM-SLOG@) === Startup/Restart Info ===
21:53:14 (MLM) (@MLM-SLOG@) Options file used: None
21:53:14 (MLM) (@MLM-SLOG@) Is vendor daemon a CVD: No
21:53:14 (MLM) (@MLM-SLOG@) Is FlexNet Licensing Service installed and compatible: No
21:53:14 (MLM) (@MLM-SLOG@) FlexNet Licensing Service Version: -NA-
21:53:14 (MLM) (@MLM-SLOG@) Is TS accessed: No
21:53:14 (MLM) (@MLM-SLOG@) TS access time: -NA-
21:53:14 (MLM) (@MLM-SLOG@) Number of VD restarts since LS startup: 0
21:53:14 (MLM) (@MLM-SLOG@) 
21:53:14 (MLM) (@MLM-SLOG@) === Network Info ===
21:53:14 (MLM) (@MLM-SLOG@) Listening port: 42249
21:53:14 (MLM) (@MLM-SLOG@) Daemon select timeout (in seconds): 1
21:53:14 (MLM) (@MLM-SLOG@) 
21:53:14 (MLM) (@MLM-SLOG@) === Host Info ===
21:53:14 (MLM) (@MLM-SLOG@) Host used in license file: life1
21:53:14 (MLM) (@MLM-SLOG@) HostID node-locked in license file: 2cea7f9647c1 
21:53:14 (MLM) (@MLM-SLOG@) HostID of the License Server: "2cea7f9647c1 2cea7f9647c0"
21:53:14 (MLM) (@MLM-SLOG@) Running on Hypervisor: Not determined - treat as Physical
21:53:14 (MLM) (@MLM-SLOG@) ===============================================
21:54:01 (MLM) TCP_NODELAY NOT enabled

```

# COBRA toolkit
```
>> initCobraToolbox(false)
```


## trouble shooting
```
RXNID_array =

  20×2 cell array

    {'R_HMR_4485'}    {'up'  }
    {'R_HMR_2247'}    {'up'  }
    {'R_HMR_9810'}    {'up'  }
    {'R_HMR_5288'}    {'up'  }
    {'R_HMR_9338'}    {'up'  }
    {'R_HMR_5561'}    {'up'  }
    {'R_HMR_5324'}    {'up'  }
    {'R_HMR_4028'}    {'up'  }
    {'R_HMR_9197'}    {'up'  }
    {'R_HMR_3928'}    {'up'  }
    {'R_HMR_4880'}    {'up'  }
    {'R_HMR_9076'}    {'down'}
    {'R_HMR_0174'}    {'up'  }
    {'R_HMR_2309'}    {'up'  }
    {'R_HMR_5870'}    {'up'  }
    {'R_HMR_4257'}    {'up'  }
    {'R_HMR_7024'}    {'up'  }
    {'R_HMR_3372'}    {'up'  }
    {'R_HMR_2393'}    {'up'  }
    {'R_HMR_4122'}    {'up'  }

iteration of random model: 3211 	 timestamp: 1 	 RXNID: HMR_4485 
RXNID: HMR_4485 	, direction : up 	,up : 1000.000000 	, lb : -1000.000000 
RXNID: HMR_4485 	, direction : up 	,up : 3000.000000 	, lb : -3000.000000 	 (changed) 
totalFluxDiff: 0.000000
iteration of random model: 3211 	 timestamp: 2 	 RXNID: HMR_2247 
RXNID: HMR_2247 	, direction : up 	,up : 1000.000000 	, lb : 0.000000 
RXNID: HMR_2247 	, direction : up 	,up : 3000.000000 	, lb : 1.000000 	 (changed) 
totalFluxDiff: 450.725693
Warning: Directory already exists. 
iteration of random model: 3211 	 timestamp: 3 	 RXNID: HMR_9810 
RXNID: HMR_9810 	, direction : up 	,up : 1000.000000 	, lb : -1000.000000 
RXNID: HMR_9810 	, direction : up 	,up : 3000.000000 	, lb : -3000.000000 	 (changed) 
totalFluxDiff: 450.725693
Warning: Directory already exists. 
iteration of random model: 3211 	 timestamp: 4 	 RXNID: HMR_5288 
RXNID: HMR_5288 	, direction : up 	,up : 1000.000000 	, lb : 0.000000 
RXNID: HMR_5288 	, direction : up 	,up : 3000.000000 	, lb : 1.000000 	 (changed) 
totalFluxDiff: 4207763.783969
Warning: Directory already exists. 
iteration of random model: 3211 	 timestamp: 5 	 RXNID: HMR_9338 
RXNID: HMR_9338 	, direction : up 	,up : 1000.000000 	, lb : -1000.000000 
RXNID: HMR_9338 	, direction : up 	,up : 3000.000000 	, lb : -3000.000000 	 (changed) 
totalFluxDiff: 4207763.783969
Warning: Directory already exists. 
iteration of random model: 3211 	 timestamp: 6 	 RXNID: HMR_5561 
RXNID: HMR_5561 	, direction : up 	,up : 1000.000000 	, lb : -1000.000000 
RXNID: HMR_5561 	, direction : up 	,up : 3000.000000 	, lb : -3000.000000 	 (changed) 
totalFluxDiff: 4207763.783970
Warning: Directory already exists. 
iteration of random model: 3211 	 timestamp: 7 	 RXNID: HMR_5324 
RXNID: HMR_5324 	, direction : up 	,up : 1000.000000 	, lb : 0.000000 
RXNID: HMR_5324 	, direction : up 	,up : 3000.000000 	, lb : 1.000000 	 (changed) 

>> MOMA(model, CancerModel)
OPTIMAL
Error using solveCobraQP (line 1049)
[gurobi] Primal optimality condition in solveCobraQP not satisfied, residual = 0.00081452, while feasTol = 1e-06

Error in MOMA (line 219)
    QPsolution = solveCobraQP(QPproblem, 'printLevel', verbFlag-1, 'method', 0);
```

