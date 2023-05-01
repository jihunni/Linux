GROMACS='/home/jihun/molecular_dynamics/'
#INPUT_PDB_LIST_DIRECTORY='/home/jihun/minibinder/TAP1/filter_ddg50/*.pdb'
INPUT_PDB_LIST_FILE='/home/jihun/minibinder/TAP1/filter_ddg50_life3.list'
OUTPUT_DIRECTORY='/home/jihun/minibinder/TAP1/molecular_dynamics/'
NUM_CPU_THREADS=33
module load gromacs

#for file_name in $(ls $INPUT_PDB_LIST_DIRECTORY); do
for file_name in $(cat $INPUT_PDB_LIST_FILE); do
    
    # environment setting
    #PROTEIN="${file_name##*/}" # to get fileName with extension (to remove path)
    PROTEIN=$(basename -- $file_name)
    PROTEIN="${PROTEIN%.*}" # to remove file extenstion
    echo ${PROTEIN} ;

    # Move to the working directory
    OUTPUT_DIR_TO_CHANGE=${OUTPUT_DIRECTORY}/${PROTEIN}
    if test -d "${OUTPUT_DIR_TO_CHANGE}"
    then
    	    cd $OUTPUT_DIR_TO_CHANGE
    else
    	    echo "to create the working directory"
            mkdir $OUTPUT_DIR_TO_CHANGE
            cd $OUTPUT_DIR_TO_CHANGE
    fi

    # MD simulation
    if test -e "md_0_1_center.xtc"
    then
            # MD simulation is done
            echo "The MD simulation was finished. Go to the next simulation \n"
            continue
    else
            # MD simulation is not finished.
            if test -e "md_0_1.xtc"
            
            # MD simulation was started but not finished. (keep going with checkpoint)
            then
                echo "MD simulation continues from the previous check point \n"
                gmx mdrun -v -deffnm md_0_1 -cpi md_0_1.cpt -nt $NUM_CPU_THREADS
            
                # analysis (Note that the trajectory of receptor-binder should be adjusted for visualization)
                printf "Protein\nSystem\n" | gmx trjconv -f md_0_1.xtc -s md_0_1.gro -o md_0_1_nojump.xtc -center -pbc nojump
                printf "Protein\nSystem\n" | gmx trjconv -f md_0_1_nojump.xtc -s md_0_1.tpr -o md_0_1_center.xtc -center -pbc mol -ur compact
                printf "Backbone\nProtein\n" | gmx rms -s em.tpr -f md_center.xtc -o rmsd_xray.xvg -tu ns -xvg none
                echo "1" | gmx gyrate -f md_center.xtc -s md_0_1.tpr -o gyrate.xvg -xvg none

            # MD simulation was not started yet.
            else 
                echo "New MD simulation is prepared and carried out \n"
                # to prepare the input files
                gmx pdb2gmx -f ${file_name} -o model.gro -water tip3p -ff charmm27 -ignh -chainsep id_or_ter
                gmx editconf -f model.gro -o box.gro -c -d 1.0 -bt cubic
                gmx solvate -cp box.gro -cs spc216.gro -o model_solv.gro -p topol.top
                gmx grompp -f ${GROMACS}/ions.mdp -c model_solv.gro -p topol.top -o ions.tpr
                printf "SOL\n" | gmx genion -s ions.tpr -o model_solv_ions.gro -p topol.top -pname NA -nname CL -neutral 
                gmx grompp -f ${GROMACS}/minim.mdp -c model_solv_ions.gro -p topol.top -o em.tpr
                gmx mdrun -v -deffnm em -nb gpu -gpu_id 0 -nt $NUM_CPU_THREADS
                printf "Potential\n0\n" | gmx energy -f em.edr -o potential.xvg
                #--> 10 0
                #xmgrace potential.xvg
                gmx grompp -f ${GROMACS}/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
                gmx mdrun -v -deffnm nvt -nb gpu -gpu_id 0 -nt $NUM_CPU_THREADS
                printf "Temperature\n0\n" | gmx energy -f nvt.edr -o temperature.xvg
                #--> 16 0
                #xmgrace potential.xvg
                gmx grompp -f ${GROMACS}/npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
                gmx mdrun -v -deffnm npt -nb gpu -gpu_id 0 -nt $NUM_CPU_THREADS
                echo "Pressure" | gmx energy -f npt.edr -o pressure.xvg
                #xmgrace pressure.xvg
                !echo "Density" | gmx energy -f npt.edr -o density.xvg
                gmx grompp -f ${GROMACS}/md_100ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
                gmx mdrun -v -deffnm md_0_1 -nb gpu -gpu_id 0 -nt $NUM_CPU_THREADS

                # analysis (Note that the trajectory of receptor-binder should be adjusted for visualization)
                printf "Protein\n0System\n" | gmx trjconv -f md_0_1.xtc -s md_0_1.gro -o md_0_1_nojump.xtc -center -pdb nojump
                printf "Protein\nSystem\n" | gmx trjconv -f md_0_1_nojump.xtc -s md_0_1.tpr -o md_0_1_center.xtc -center -pbc mol -ur compact
                printf "Backbone\nProtein\n" | gmx rms -s em.tpr -f md_center.xtc -o rmsd_xray.xvg -tu ns -xvg none
                echo "1" | gmx gyrate -f md_center.xtc -s md_0_1.tpr -o gyrate.xvg -xvg none
            fi
    fi

    
    

done
