#!/bin/env bash
#SBATCH --partition=public-gpu
#SBATCH --time=2-00:00:00
#SBATCH --gpus=1
#SBATCH --output=kraken-%j.out
#SBATCH --mem=0

module load fosscuda/2020b Python/3.8.6
source ~/test-env/bin/activate

work_directory="/home/users/j/jacsont/Varios-OCR-files/Models/Models-HTR-Varios/Alto/Model_data+varios_4"
mkdir -p ${work_directory}
cd ${work_directory}

OUTPUT_NAME="Data+varios_4"
XML_FOLDER="/home/users/j/jacsont/Varios-OCR-files/Grountruth/Data+varios/"
echo "KETOS training"

srun ketos train  -r 0.0001 --lag 20  -f alto  -s '[1,120,0,1 Cr3,13,32 Do0.1,2 Mp2,2 Cr3,13,32 Do0.1,2 Mp2,2 Cr3,9,64 Do0.1,2 Mp2,2 Cr3,9,64 Do0.1,2 S1(1x0)1,3 Lbx200 Do0.1,2 Lbx200 Do.1,2 Lbx200 Do]' --workers 20 -u NFD --augment "${XML_FOLDER}/*.xml"


