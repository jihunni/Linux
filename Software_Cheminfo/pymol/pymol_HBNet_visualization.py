# visaulization on Pymol of Hydrogen bonds labeled as 'HBNet', which discovered by Rosetta HBNet
# Author : JIhun Jeung (jihun@gm.gist.ac.kr, jeung@uw.edu, 13 Jun 2023)
from pymol import cmd
#from pyrosetta import *

def HBNet_label_collector(file_name: str) -> list:
    """
    To collect HB label from PDB file
    """
    hydrogen_bond_residue = []
    for line in open(file_name):
        if len(line.split()) > 2 : 
            list = line.split()
            id = list[0]
            if id == 'REMARK' :
                type = list[1]
                if type == 'PDBinfo-LABEL:':
                    residue = list[2]
                    hydrogen_bond_residue.append(residue)
    
    return hydrogen_bond_residue

def HBNet_label_collector_old(file_name: str) -> list :
    '''
    To collect HBNet label from PDB file (PyRosetta dependent)
    '''
    if not isinstance(file_name, str):
        raise TypeError
    
    # load a pose from a PDB file
    pose = pose_from_pdb(file_name)
    #print(pose)

    # to collect HBNet labels from pose
    nres = pose.pdb_info().nres()
    hydrogen_bond_residue = [0] * nres
    num_hydrogen_bond = 0
    for res in range(1,nres+1):
        label = pose.pdb_info().get_reslabels(res)
        if len(label) != 0 :
            if label[1] == 'HBNet' : 
                hydrogen_bond_residue[num_hydrogen_bond] = res
                num_hydrogen_bond += 1
    hydrogen_bond_residue = hydrogen_bond_residue[0:num_hydrogen_bond]

    # print(hydrogen_bond_residue)
    return hydrogen_bond_residue

def visualize_Hbond_pymol(cmpx) -> int:
    """
    PARAMS
		cmpx
			The complex containing cA and cB

    AUTHOR
        Jihun Jeung (jihun@gm.gist.ac.kr ; jeung@uw.edu)
    """
    # to select HBNet residue
    pdb_file_name = str(cmpx) + '.pdb'
    Hbond_res_list = HBNet_label_collector(pdb_file_name)
    
    res_select_str = ''
    for res in Hbond_res_list : 
        res_select_str += str(res) + '+'
    res_select_str = res_select_str[:-1] # to remove last '+'
    cmd.select('HBNet_res', f'(object {cmpx}) and (resi {res_select_str})')
    cmd.show("sticks", f"(object {cmpx}) and (HBNet_res)")
    return 0
