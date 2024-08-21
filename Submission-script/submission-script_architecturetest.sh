#!/bin/env bash
#SBATCH --partition=public-gpu
#SBATCH --time=2-00:00:00
#SBATCH --gpus=1
#SBATCH --output=kraken-%j.out
#SBATCH --mem=0

module load fosscuda/2020b Python/3.8.6
source ~/Sandozenv/bin/activate
pip install albumentations

work_directory="Alto/Model-htr-test-architectures_2"
mkdir -p ${work_directory}
cd ${work_directory}

OUTPUT_NAME="output_name"

XML_FOLDER="Varios-OCR-files/Grountruths/Varios-GrounTruth-Alto/"

echo "KETOS training"
srun ketos train  -r 0.0001 -p 0.7 -f alto  -s '[1,120,0,1 Cr3,13,32 Do0.1,2 Mp2,2 Cr3,13,32 Do0.1,2 Mp2,2 Cr3,9,64 Do0.1,2 Mp2,2 Cr3,9,64 Do0.1,2 S1(1x0)1,3 Lbx200 Do0.1,2 Lbx200 Do.1,2 Lbx200 Do]' --threads 64 -u NFD --augment -t Varios-OCR-files/Grountruths/Split/train.txt -e Varios-OCR-files/Grountruths/Split/eval.txt -d cuda "${XML_FOLDER}/*.xml"
