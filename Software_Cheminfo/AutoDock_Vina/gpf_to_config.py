"""
This program converts a gpf file to a config file in order to preprare the input files for autodock vina
Jihun Jeung, jihun@gm.gist.ac.kr

Arguments:
	input_gpf_file : an gpf file from prepare_gpf.py 
	output_file_name : an configureation file for autodock vina 
Examples : python gpf_to_config.py  data/nars2_alphafold2.gpf data/config.txt
"""
import argparse

def get_arguments():
	parser = argparse.ArgumentParser(description="Get a gfp file")
	parser.add_argument('input_gpf_file', type=str, help='input_gpf_file')
	parser.add_argument('output_file_name', type=str, help="output_config_file")
	
	input_gpf_file = parser.parse_args().input_gpf_file
	output_file_name = parser.parse_args().output_file_name

	return input_gpf_file, output_file_name

input_gpf_file, output_file_name = get_arguments()

with open(input_gpf_file, "r") as file:
	strings = file.readlines() # to read files
	strings = strings[6].strip() # to grap the grid box
	strings = strings.split(' ')

with open(output_file_name, "w") as file:
	file.write(f"center_x = {strings[1]}\n")
	file.write(f"center_y = {strings[2]}\n")
	file.write(f"center_z = {strings[3]}\n")
	file.write("size_x = 20.0\n")
	file.write("size_y = 20.0\n")
	file.write("size_z = 20.0")
	file.close()
