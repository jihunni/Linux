# PyPI
# Distribution
## setuptools : to build a setup file
Ref : https://pythonhosted.org/an_example_pypi_project/setuptools.html  
Document : https://packaging.python.org/en/latest/guides/distributing-packages-using-setuptools/  

```
import os
from setuptools import setup

# Utility function to read the README file.
# Used for the long_description.  It's nice, because now 1) we have a top level
# README file and 2) it's easier to type in the README file than to put a raw
# string in below ...
def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name = "an_example_pypi_project",
    version = "0.0.4",
    author = "Andrew Carter",
    author_email = "andrewjcarter@gmail.com",
    description = ("An demonstration of how to create, document, and publish "
                                   "to the cheese shop a5 pypi.org."),
    license = "BSD",
    keywords = "example documentation tutorial",
    url = "http://packages.python.org/an_example_pypi_project",
    packages=['an_example_pypi_project', 'tests'],
    long_description=read('README'),
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Topic :: Utilities",
        "License :: OSI Approved :: BSD License",
    ],
    install_requires = [
		'argparse',
		'biopython>=1.79', 
		'rdkit-pypi==2022.3.2.1',
		'pandas==1.3.4',
		'numpy==1.20.3',
		'appdirs>=1.4.4',
	],
    entry_points={
        'console_scripts': ['bgcfinder = BGCfinder.main:main', 'bgc-download = BGCfinder.download:download']
    }
)
```

```
some_root_dir/
|-- README
|-- setup.py
|-- an_example_pypi_project
|   |-- __init__.py
|   |-- useful_1.py
|   |-- useful_2.py
|-- tests
|-- |-- __init__.py
|-- |-- runall.py
|-- |-- test0.py
```

```
$ pip install wheel && pip install twine
$ python setup.py bdist_wheel
$ twine upload dist/packagename-1.0.0.0-py3-none-any.whl
```
## Distribute : To upload the package on PyPi
Ref : https://harry24k.github.io/pip/
Install
```
pip install wheel
pip install twine
```

To create the files for distribution
```
python setup.py bdist_wheel
```

To distribute the package on Test.pypi (Warning! Remove the folder `build`, which may collide with the previous version )
```
twine upload --repository-url https://test.pypi.org/legacy/ dist/*
```

To distirbute the package on Pypi
```
twine upload dist/*
```
