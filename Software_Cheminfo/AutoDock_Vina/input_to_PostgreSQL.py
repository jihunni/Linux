"""
This program converts a gpf file to a config file in order to preprare the input files for autodock vina
Jihun Jeung, jihun@gm.gist.ac.kr

Arguments:
	input_VinaOut_file : an vina output file from autodock vina
	receptor_id : str, receptor ensembl ID
	ligand_id : str, ligand PubChem compound ID
	output_file_name : an configureation file for autodock vina 
Examples : python gpf_to_config.py  data/nars2_alphafold2.gpf data/config.txt
"""
#PostgreSQL DB
import psycopg2 
db_connect = psycopg2.connect(host='localhost',database='pubchem_vina',user='pubchem_vina',password='pubchem_vina_password')
cursor=db_connect.cursor()
def insertDB(schema,table,colum,data):
    sql = "INSERT INTO {schema}.{table} ({colum}) VALUES ({data}) ;".format(schema=schema,table=table,colum=colum,data=data)
    print(sql)
    try:
        cursor.execute(sql)
        db_connect.commit()
    except Exception as e :
        print(" insert DB  ",e) 

# argument parser        
import argparse
def get_arguments():
 	parser = argparse.ArgumentParser(description="Get a gfp file")
 	parser.add_argument('-input_VinaOut_file', '-i', type=str, help='input_Vina out_file')
 	parser.add_argument('-receptor_id', '-r', type=str, help="receptor ensembl ID")
 	parser.add_argument('-ligand_id', '-l', type=str, help="ligand PubChem compound ID")
	
 	input_VinaOut_file = parser.parse_args().input_VinaOut_file
 	receptor_id = parser.parse_args().receptor_id
 	ligand_id = parser.parse_args().ligand_id

 	return input_VinaOut_file, receptor_id, ligand_id 

input_VinaOut_file, receptor_id, ligand_id = get_arguments()

# example
# input_VinaOut_file = 'data/vina_out.pdbqt'
# receptor_id = 0
# ligand_id = 'ENSG00000137513'

with open(input_VinaOut_file, "r") as file:
	strings = file.readline() # to read the 1st line in a file
	strings = file.readline() # to read the 2nd line in a file
	strings = strings.split(' ')
	strings = float(list(filter(None, strings))[3]) # to get binding affinity
	binding_energy = strings
	del strings

insertDB(schema='pubchem_vina',table='docking', colum='receptor_ensembl_id, pubchem_compud_cid, binding_energy', data=f"'{receptor_id}', '{ligand_id}', {binding_energy}")

db_connect.close ()
