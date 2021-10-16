# GDC Data Transfer Tool
```
$ ls
gdc_download_script.sh  gdc_manifest_20211016.txt  gdc-user-token.txt
```

gdc_manifest.txt (example)
```
53c2ddb5-c794-419f-8e0e-2896bd18115d    5f2dd372-8663-4a99-a22d-23bdceb4ba62_atacseq_gdc_realn.bam      95284fd27ec22f9af847416970691941        19416762618     validated
57b83074-0bfa-4d35-9e01-ac4765e42f9b    380ec737-1741-4e80-8f98-75e176e9c34a_atacseq_gdc_realn.bam      cdf45cd33b08a95eaf82f9f4239c3aa0        51740062690     validated
5df0f0b2-daf5-4217-84b9-208dfa73bb23    acf7578c-55e0-4100-8a91-1b46f6e97417_atacseq_gdc_realn.bam      8496516d90b1711e11270026ef4e2993        14627552867     validated
6ccce23a-cc68-4a8b-87d7-ef6f19a35eb7    e1ec684e-1e8e-4d51-a8aa-74133f804e2e_atacseq_gdc_realn.bam      960f46e939bb5403872eace7373b291a        24201593331     validated
71aab60e-7a8d-4c81-9041-92b6851717d4    63fec5bd-3184-4974-a1b7-a43b82e1ae9c_atacseq_gdc_realn.bam      d3765b4ea71df941822307a3c33631dd        19925366549     validated
7e36519d-a8ce-4434-8543-bc3cdf339163    fa1500d1-8290-4f30-8ab8-5d712fdde1f1_atacseq_gdc_realn.bam      16e8dcceb8908961981ffe704a383aca        18155553882     validated
```

gdc_download_script.sh (slurm script)
```
#!/bin/bash
#
#SBATCH --job-name=gdc-download
#
#SBATCH --account=jihun
#
#SBATCH --mail-user=jihun@gm.gist.ac.kr
#SBATCH --mail-type=ALL
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem 4G
#SBATCH --time=48:00:00
#SBATCH --output=slurm_output_%j.txt
#SBATCH -o %x_%A.o%j
#SBATCH -e %x_%A.e%j

# stdout : basic info
echo "SLURM running info"
echo "Start Time        = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"

# load module
module purge
module load GDC_data_transfer_tool/1.6.1

# run a program
gdc-client download -m gdc_manifest_20211016.txt -t gdc-user-token.txt

# finish
GDC_data_transfer_tool/1.6.1

```
