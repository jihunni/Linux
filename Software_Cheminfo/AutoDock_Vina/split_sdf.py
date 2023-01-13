import rdkit
import os
from rdkit import Chem
from rdkit.six import StringIO
from tqdm import tqdm
import argparse

# To get SLURM_ARRAY_TASK_ID from argument
def get_arguments():
	parser = argparse.ArgumentParser(description="To get slurm array task ID")
	parser.add_argument('SLURM_ARRAY_TASK_ID', type=str, help='SLURM_ARRAY_TASK_ID')
	
	SLURM_ARRAY_TASK_ID = parser.parse_args().SLURM_ARRAY_TASK_ID

	return SLURM_ARRAY_TASK_ID

SLURM_ARRAY_TASK_ID = get_arguments()
SLURM_ARRAY_TASK_ID = int(SLURM_ARRAY_TASK_ID)

# To select a bulk sdf file to split
input_directory = '/home/jihun/data/PubChem/3dSDF/'
output_sdf_directory= '/home/jihun/data/PubChem/3dSDF_single/'
bulk_sdf_list = os.listdir(input_directory)
file_name = bulk_sdf_list[SLURM_ARRAY_TASK_ID]

# to split a bulk sdf file into sdf files with a single molecule.
input_sdf_file_name = os.path.join(input_directory, file_name)
# checking if it is a file
if not os.path.isfile(input_sdf_file_name):
	print("Error!")
suppl = Chem.SDMolSupplier(input_sdf_file_name)
for mol in suppl:
	# to check 3D conformation
	conformer = mol.GetConformer()
	coordinates = conformer.GetPositions()
	if sum(coordinates[:,2]) != 0 : 
		sio = StringIO()
		with Chem.SDWriter(sio) as w:
			w.write(mol)
			#print(mol.GetProp("_Name"))
			#print(sio.getvalue())
			# to write a sdf file with a single molecule
			output_sdf_file_name = str(mol.GetProp("_Name"))+'.sdf'
			with open(output_sdf_directory+output_sdf_file_name, "w") as file:
				file.write(sio.getvalue())
