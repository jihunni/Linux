general code
```
conda info --envs
conda env list
conda init [shell_Name]
conda create --name [virtual_env_name] --clone base python=3.9
conda env remove -n [virtual_env_name]
conda remove --name [environment_name] --all
conda update --all
source conda activate [env_name]
```

running code
```
conda init bash
conda activate example
```

To update conda
```
conda update conda
```

```
conda list #패키지 리스트 확인
conda install [library_name]
conda remove [library_name]
conda update [library_name]
conda update --all #
pip install [library_name]
```
# new environment
```
# Jupyter에 새 kernel 등록하기
(pytorch)$ python -m ipykernel install --user --name pytorch --display-name "PyTorch"
```
![image](https://user-images.githubusercontent.com/48517782/143440794-56d4a630-762c-44ef-a65d-b3b16c377a2e.png)
> python -m ipykernel : ipykernel 모듈을 파이썬 스크립트로 실행합니다.  
> —name pytorch : Jupyter 내부적으로 쓰이는 kernel의 이름을 지정합니다. 같은 이름을 쓰면 덮어쓰기가 됩니다.  
> --display-name "PyTorch" : Jupyter Notebook 위에서 사용자에게 보이는 kernel의 이름을 정합니다. 내부적으로 쓰이는 이름과 상관없이 띄어쓰기 등 특수문자도 포함하여 자유롭게 지을 수 있습니다.  

# install basic library
Ref: https://gentlesark.tistory.com/29
- Jupyter notebook
	```
	$ pip install notebook
	```
- Jupyter Lab
	```
	install jupter lab
	$ conda install -c conda-forge jupyterlab --> may not work
	$ pip install jupyterlab
	
	execute jupyter lab
	$ jupyter lab
	```
	
	To install add-on
	```
	# conda install nodejs
	# conda install npm
	```
	
# Jupyter Environmental setting
Ref : https://bioinfoblog.tistory.com/13
```
jupyter notebook --generate-config
vi ~/.jupyter/jupyter_notebook_config.py
jupyter lab --no-browser
```
```
jupyter server list
jupyter notebook list
```

# Trouble shooting
```
$ conda activate example_env
CommandNotFoundError: Your shell has not been properly configured to use 'conda activate'.
To initialize your shell, run

    $ conda init <SHELL_NAME>

Currently supported shells are:
  - bash
  - fish
  - tcsh
  - xonsh
  - zsh
  - powershell

See 'conda init --help' for more information and options.

IMPORTANT: You may need to close and restart your shell after running 'conda init'.
```

Method1:   
Then, Try 'conda init bash' with sudo
Then, Try `source conda activate example_env`

Ref:
- https://hamonikr.org/board_bFBk25/78585
- https://willbesoon.tistory.com/119


Method2 : 
Run bashrc again (it may be updated after the installation of anaconda3)
```
. ~/.bashrc
```

If there is no bashrc,
```
$ cp /etc/skel/.bashrc ~
$ chmod 755 .bashrc
$ vi  ~/.profile
	> source ~/.bashrc
```
Ref:  
- https://askubuntu.com/questions/1143142/conda-init-gives-me-no-action-taken. 
- https://stackoverflow.com/questions/65196475/conda-init-doesnt-initialize-shell

# install library in conda env
Ref : https://docs.conda.io/projects/conda/en/latest/commands/install.html
```
# Anaconda Prompt
pip install package-name

# general in shell
conda install -c [channel] -n [environment_name] [package-name]

# example
conda install -c bioconda pyfasta
conda install -n pytorch -c conda-forge rdkit
```
install with conda-forge
```
conda install --channel=conda-forge physics-tenpy
```

## ML/DL library
- pytorch : https://pytorch.org/get-started/locally/ 
 ```
	 import torch

	torch.cuda.is_available()
	>>> True

	torch.cuda.current_device()
	>>> 0

	torch.cuda.device(0)
	>>> <torch.cuda.device at 0x7efce0b03be0>

	torch.cuda.device_count()
	>>> 1

	torch.cuda.get_device_name(0)
	>>> 'GeForce GTX 950M'
 ```
- tensorflow : https://docs.anaconda.com/anaconda/install/multi-user/  
	```
	conda create -n tf-gpu tensorflow-gpu
	conda activate tf-gpu
	```
- pytorch_geometric : 
	```
	pip install torch-scatter -f https://data.pyg.org/whl/torch-1.10.0+cu113.html
	pip install torch-sparse -f https://data.pyg.org/whl/torch-1.10.0+cu113.html
	pip install torch-geometric
	```
- pytorch, pytorch_geometric, rdkit
	rdkit env collide with pytorch env. 
	```
	In pytorch and pytorch_geometric env,
	# conda install -c conda-forge mamba
	# mamba install -c conda-forge rdkit
	```
- tensorboard
	```
	pip install tensorboard
	```
- slack
	Ref : https://pypi.org/project/slackclient/
	```
	# pip install slackclient
	```
- 
## Bioinformatics library
	- R studio
		Ref : https://docs.anaconda.com/anaconda/navigator/tutorials/create-r-environment/
	- biopython
		```
		conda install -c conda-forge biopython
		```

## Natural Language Processing library
	```
	conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch
	conda install -c conda-forge transformers
	conda install -c anaconda mxnet
	pip install mxnet gluonnlp pandas tqdm sentencepiece
	```

# distribute conda environment
Ref : https://www.anaconda.com/blog/moving-conda-environments
	
	To distribute environment via Environment.yml
	```
	# To produce yml file
	$ conda env export > conda_environment.yml
	
	# To reproduce the conda virtual environment through yml file
	$ conda env create -f conda_environment.yml
	```

# trouble shooting
- When the directory of anaconda is changed and conda is executed, `bash: ./conda: /opt/anaconda/2021.11-Linux-x86_64/bin/python: bad interpreter: No such file or directory` pop up:
	```
	# vi conda
	changes !/ directory
	
	```
	
# recent anaconda env setting
check list:
- python version
- pytorch version and cuda version
- pytorch geometric version
- rdkit 
```
# conda create --name torch1.11.0_cuda11.3 python=3.9
# conda install pytorch==1.11.0 torchvision==0.12.0 torchaudio==0.11.0 cudatoolkit=11.3 -c pytorch
# conda install pyg -c pyg
```

not work
```
# conda create --name torch1.10.0_cuda11.3 python=3.9
# conda install pytorch==1.10.0 torchvision==0.11.0 torchaudio==0.10.0 cudatoolkit=11.3 -c pytorch -c conda-forge
# conda install pyg -c pyg
```


```
# conda activate torch1.9.0_cuda11.3
# conda install pytorch==1.9.0 torchvision==0.10.0 torchaudio==0.9.0 cudatoolkit=11.3 -c pytorch -c conda-forge
# conda install pyg -c pyg
```
