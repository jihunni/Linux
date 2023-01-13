import os
from collections import OrderedDict
# Uses OrderedDict for maintaining insertion order pre-Python3.7

class PDB():
    """
    Class for parsing PDB files that follow the accepted format
    https://www.wwpdb.org/documentation/file-format-content/format33/sect9.html#ATOM
    Extracts ATOM and HETATM records. 
    HETATM with HOH resname are removed.
    Dictionary format:
    Structure (list)>
        Model (odict)>
            Chain (odict)>
                Residue (list)>
                    Atom (dict)
    """

    def __init__(self, filename=None):
        if not os.path.splitext(filename)[1] in ['.pdb', '.pdbqt']:
            raise ValueError('Incorrect file extension, must be .pdb or .pdbqt')
        else:
            self.filename = filename

        self.AA_3to1    = {'ALA':'A','ARG':'R','ASN':'N','ASP':'D','CYS':'C','GLU':'E',
                           'GLN':'Q','GLY':'G','HIS':'H','ILE':'I','LEU':'L','LYS':'K',
                           'MET':'M','PHE':'F','PRO':'P','SER':'S','THR':'T','TRP':'W',
                           'TYR':'Y','VAL':'V'}

        self.ATOM_STRING = "{}{:5d} {:4}{:.1}{:.3} {:.1}{:>4d}{:.1}   {:8.3f}{:8.3f}{:8.3f}{:6.2f}{:6.2f}          {:.2}  \n"

        self.structure = [None]
        self.num_models = 0
        self.num_chains = 0
        self.chains = {}
        self._parse()

    def _parse(self):
        """Parse the PDB file as a series of record entries into a dictionary"""

        with open(self.filename, 'r') as entries:
            model = 0
            open_model = False
            chain = None
            resnum = None
            for entry in entries:
                record_type = entry[0:6]

                if record_type == 'ATOM  ' or record_type == 'HETATM' and not entry[17:20] == 'HOH':
                    if not open_model:
                        model += 1
                        open_model = True
                        self.structure.append(OrderedDict())
                    if not entry[21] == chain:
                        chain = entry[21]
                        if chain == ' ':
                            chain = 'A'
                        if not chain in self.structure[model]:
                            self.structure[model][chain] = OrderedDict()
                    if not int(entry[22:26]) == resnum:
                        resnum = int(entry[22:26])
                        self.structure[model][chain][resnum] = []
                    self.structure[model][chain][resnum].append({'type': record_type,
                                                                 'serial': int(entry[6:11]),
                                                                 'name': entry[12:16],
                                                                 'altLoc': entry[16],
                                                                 'resname': entry[17:20],
                                                                 'icode': entry[26],
                                                                 'x': float(entry[30:38]),
                                                                 'y': float(entry[38:46]),
                                                                 'z': float(entry[46:54]),
                                                                 'occupancy': float(entry[54:60]),
                                                                 'bfactor': -1.00,
                                                                 'element': entry[76:78]
                                                                 })
                elif record_type == 'MODEL ':
                    open_model = True
                    _model = int(entry.split()[1])
                    if not _model == model+1:
                        print('MODEL records should be sequentially numbered beginning with 1.')
                        print('MODEL {} renumbered to {}'.format(_model, model+1))
                    model += 1
                    self.structure.append(OrderedDict())
    
                elif record_type == 'ENDMDL':
                    open_model = False
                    chain = None
                    resnum = None

            self.num_models = model
            # self.chains = {chain:self._get_sequence(self.structure[1][chain]) for chain in self.structure[1]}
            self.num_chains = len(self.chains)

    # def _get_sequence(self, chain):
    #     """Parse single character amino acid code from chain"""
    #     _sequence = ''

    #     for residue in chain:
    #         resname = chain[residue][0]['resname']
    #         if chain[residue][0]['type'] == 'ATOM  ':
    #             try:
    #                 _sequence += self.AA_3to1[resname]
    #             except KeyError:
    #                 print('The residue name {} is not standard. Cannot generate FASTA sequence.'.format(resname))
    #
    #    return _sequence
