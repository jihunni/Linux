general code
```
conda info --envs
conda env list
conda init [shell_Name]
conda create --name [virtual_env_name] --clone base
conda env remove -n [virtual_env_name]
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

# install library
Ref: https://gentlesark.tistory.com/29
- Jupyter notebook
- Jupyter Lab
	```
	install jupter lab
	$ conda install -c conda-forge jupyterlab
	$ pip install jupyterlab
	
	execute jupyter lab
	$ jupyter lab
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
Then, Try 'conda init bash' with sudo
Then, Try `source conda activate example_env`

Ref:
- https://hamonikr.org/board_bFBk25/78585
- https://willbesoon.tistory.com/119

# install bioconda
```
# Anaconda Prompt
pip install package-name

# general in shell
conda install [package-name]

# example
conda install -c bioconda pyfasta
```

