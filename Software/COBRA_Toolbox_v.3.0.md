# Installation on Ubuntu
  ```
  # git config --system --add safe.directory /opt/cobra_toolbox/cobratoolbox
  ```
# I/O
## Reading a model (timing: 1 second to a few minutes)
```
fileName = 'ecoli_core_model.mat';
model = readCbModel(fileName);
```
> `readCbModel` checks the model for consistency with COBRA Toolbox and automatically performs necessary conversion for mdels.  
> The readCbModel function has a second optional input that specifies the file type being loaded. In the above example the file type does not need to be specified since the input default is a 'Matlab' file type. To load file types other than a MAT-file, specificy the file type for input as: ‘SBML’, ‘SimPheny’, ‘SimPhenyPlus’, ‘SimPhenyText’, or 'Excel’.   
> `.mat` file might contain information not present in the corresponding `SBML` output
> The loading of a MAT-file, even of some large models, can take only seconds, whereas large SBML files can take a few minutes to load. 
```
# call the readCbModel function without a fileName to get a dialog box. 
# (This is provided when the Java feature is available.)
if usejava('desktop') % This line of code is to avoid execution of example in non gui-environments    
    model = readCbModel();
end
```

To view the data stored in the model
```
if usejava('desktop') % This line of code is to avoid execution of example in non gui-environments    
    open model
end
```
> rxns, the identifiers of the reactions  
> mets, the identifiers of the metabolites  
> genes, the list of genes in your model (can be empty)  
> rules, the Gene-protein-reaction rules in a computer readable format present in your model.  
> S, the stoichiometric matrix  
> lb, the lower bounds of the reactions  
> ub, the upper bounds of the reactions  
> osense, the objective sense (by convention, -1 indicates maximisation, 1 minimisation)  
> b, Accumulation (positive) or depletion (negative) of the corresponding metabolites. 0 Indicates no concentration change.   
> csense, indicator whether the b vector is a lower bound ('G'), upper bound ('L'), or hard constraint 'E' for the metabolite.  

## Writing a model (timing: 1 second to a few minutes)
```
if usejava('desktop') % This line of code is to avoid execution of example in non gui-environments
    writeCbModel(model)
    writeCbModel(model,'text' / 'xls' / 'sbml')
    writeCbModel(model, 'fileName', 'Acidaminococcus.xlls')
    writeCbModel(model, 'fileName', 'Acidaminococcus.sbml','format','sbml')
end
```
> To use the function to write a file types other than a MAT-file, specificy the file type for input as: ‘text’,’xls’, or ‘sbml’. 

## clean up
```
currentDir = pwd;
cd(fileparts(which('tutorial_IO.mlx')));

% Delete the files used in this tutorial (if they are present).
try
    delete('ecoli_core_model.mat');
    delete('Acidaminococcus.xml');
    delete('Acidaminococcus.sbml');
end
```
