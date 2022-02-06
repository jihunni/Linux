# Moudle environment

# slum

# Programminfg Language and IDE

- Python (Anaconda3)
  software directory : 
  module directiroy : 
  
  ```
  $ module av
  $ module load anaconda3
  $ python
  Python 3.8.8 (default, Apr 13 2021, 19:58:26) 
  [GCC 7.3.0] :: Anaconda, Inc. on linux
  Type "help", "copyright", "credits" or "license" for more information
  ```
  When you use Python, you sholud check whether python is derived from Anaconda. 
  - build virtual environment
    ```
    conda info --envs
    conda init [shell_Name]
    conda create --name [env_name] --clone base
    conda activate [env_name]
    
    
    ```
  - Jupyter notebook
    ```
    $ jupyter-notebook
    [I 15:05:31.980 NotebookApp] Writing notebook server cookie secret to /home/jihun/.local/share/jupyter/runtime/notebook_cookie_secret
    [I 2021-10-13 15:05:32.384 LabApp] JupyterLab extension loaded from /opt/anaconda3/2021.05/lib/python3.8/site-packages/jupyterlab
    [I 2021-10-13 15:05:32.384 LabApp] JupyterLab application directory is /opt/anaconda3/2021.05/share/jupyter/lab
    [I 15:05:32.390 NotebookApp] Serving notebooks from local directory: /home/jihun
    [I 15:05:32.390 NotebookApp] Jupyter Notebook 6.3.0 is running at:
    [I 15:05:32.390 NotebookApp] http://localhost:8888/?token=2921873a5039386d0e8eda948810ad5f2518293076a265fa
    [I 15:05:32.390 NotebookApp]  or http://127.0.0.1:8888/?token=2921873a5039386d0e8eda948810ad5f2518293076a265fa
    [I 15:05:32.390 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
    [C 15:05:32.480 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///home/jihun/.local/share/jupyter/runtime/nbserver-231795-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/?token=2921873a5039386d0e8eda948810ad5f2518293076a265fa
     or http://127.0.0.1:8888/?token=2921873a5039386d0e8eda948810ad5f2518293076a265fa
    START /usr/bin/firefox "/home/jihun/.local/share/jupyter/runtime/nbserver-231795-open.html"
    Failed to open connection to "session" message bus: Using X11 for dbus-daemon autolaunch was disabled at compile time, set your DBUS_SESSION_BUS_ADDRESS instead
    Running without a11y support!

    ```
  
  software list:
  - Pyfasta
  - psycopg2
    
- R
  version : 3.6.0
  Library directory : /opt/R_shared_library/3.6.0
  ```
  $ module av
  $ module load R
  $ R
  > .libPaths()
  "/opt/R_shared_library/3.6.0" "/usr/lib64/R/library" "/usr/share/R/library"
  ```
  installed libraries:
    - tidyverse
    - readr
    - ggplot2
   installed libraries (bioconductor) : [bioconductor list](https://bioconductor.org/packages/3.13/BiocViews.html#___Software)
    - TxDb.Hsapiens.UCSC.hg38.knownGene

- MATLAB (2021b) 
 ```
 $ ssh -X ID@IP
 $ module load matlab
 $ matlab
 MATLAB is selecting SOFTWARE OPENGL rendering.
 ```
 ![image](https://user-images.githubusercontent.com/48517782/135204312-d90c8bd9-68ea-49a6-9702-743d4364f07d.png)
 > If you execute `$ module load matlab`, then the paths for `Gurobi Optimizer` are automatically set up. Check by `$ env`
# software for database
- GDC_data_transfer_tool
  software directory : /opt/GDC_data_transfer_tool/1.6.1/
  ```
  $ module av
  $ module load GDC_data_transfer_tool/1.6.1
  $ gdc-client [command]
  ```

# software for bioinformaitcs analysis
- star   
  software directory : /opt/  
  module directory : /opt/Modules/modulefiles/  
  ```
  $ module av
  $ module load star
  $ STAR [command]
  
  ```
- foldseek [github](https://github.com/steineggerlab/foldseek)   
  software directory : /opt/alpha/foldseek/bin   
  module directory : /opt/Modules/modulefiles/foldseek/alpha_20210724   
  ```
  $ module av
  $ module load foldseek
  $ foldseek [command]
  ```
- SRA_toolkit | [NCBI homepage](https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit)  
  software directory : /opt/SRA_toolkiet    
  module directory : /opt/Modules/modulefiles/SRA_toolkiet  
  readme directory : /opt/SRA_toolkit/2.11.1-centos_linux64/README.md  
  ```
  $ module av
  $ module load SRA_toolkit
  $ fastq-dump [command]
  ```
- FastQC
  software directory : /opt/FastQC/0.11.9/  
  moduel directory : /opt/Modules/modulefiles/FastQC/0.11.9/  
  
  1. Enable X11 forwarding by writing option `-X`
    ```
    ssh -X id@xx.xxxx.xx.x 
    ```
  
  2. module load FastQC
    ```
    $ module load FastQC
    ```
  
  3. execute Fastqc
    ```
    $ fastqc
    ```
  
- BWA-MEM2
  sequence alignment program with high speed
  software directory : /opt/BWA-MEM2/2.2.1/
  moduel directory : /opt/Modules/modulefiles/BWA-MEM2/2.2.1/ 
  readme directory : /opt/Modules/modulefiles/BWA-MEM2/2.2.1/README.md

  ```
  $ module load BWA-MEM2
  $ bwa-mem2 [command]
  ```
- kalisto  
  heuristic sequence alignment  
  software directory : /opt/kallisto/2021.10.18/  
  moduel directory : /opt/Modules/modulefiles/kallisto  
  readme directory :   
  ```
  $ module load kalisto
  $ kalisto [command]
  ```
- Trimmomatic | [homepage](http://www.usadellab.org/cms/?page=trimmomatic)
  ```
  $ module load trimmomatic
  $ java -jar trimmomatic-0.39.jar [command]
  ```
- HMMRATAC | [paper](https://academic.oup.com/nar/article/47/16/e91/5519166), [github](https://github.com/LiuLabUB/HMMRATAC)
  directory : /opt/HMMRATAC/1.2.10
  ```
  java -jar /opt/HMMRATAC/1.2.10/HMMRATAC_V1.2.10_exe.jar [command]
  ```
- THE ENCODE BLACK LIST  
 directory : /opt/The_ENCODE_Blacklist/20210922  
 black list : /opt/The_ENCODE_Blacklist/20210922/lists
 ```
 $ ls
	Blacklist_v1           dm6-blacklist.v2.bed       metadata
	ce10-blacklist.v2.bed  hg19-blacklist-README.pdf  mm10-blacklist.v2.bed
	ce11-blacklist.v2.bed  hg19-blacklist.v2.bed
	dm3-blacklist.v2.bed   hg38-blacklist.v2.bed

 ```
- Cytoscape 
 You need to connect SSH with `-X` or `-Y`  option (graphic interface option)
 ```
	$ ssh -X ID@IP
	$ Cytoscape &
 ```

- bedops
	```
	$ module load bedops/2.4.40
	$ bedmap [command]
	```
- bowtie2
	```
	$ module load bowtie2
	$ bowtie2 [command]
	```
- IGV
	```
	$ module load igv/2.11.3
	$ igv.sh
	```
- IDR
	github : https://github.com/kundajelab/idr
	```
	$ module load anacona3
	$ /opt/IDR/idr-2.0.4.2/idr [command]
	$ /opt/IDR/idr-2.0.4.2/idr -h
	```
- Mothur 1.47.0
	Ref : https://mothur.org/
	```
	$ module load mothur
	$ mothur
	```
	- 
# database system
## PostgreSQL (version 13)
