#!/bin/env bash
#SBATCH --partition=public-gpu
#SBATCH --time=20:00:00
#SBATCH --gpus=1
#SBATCH --output=kraken-%j.out
#SBATCH --mem=0

module load fosscuda/2020b Python/3.8.6
source ~/Sandozenv/bin/activate

work_directory="/home/users/j/jacsont/Varios-OCR-files/Models/Models-htr-Varios/Alto/Model-htr-test-gamma2+Otsu/"
mkdir -p ${work_directory}
cd ${work_directory}

OUTPUT_NAME="output_name"
XML_FOLDER="/home/users/j/jacsont/Varios-OCR-files/Grountruths/Varios-GroundTruth-Test-Alto/GroundTruth-Gamma2+Otsu/"

echo "KETOS training"
srun ketos train -t /home/users/j/jacsont/Varios-OCR-files/Grountruths/Split/train.txt -e /home/users/j/jacsont/Varios-OCR-files/Grountruths/Split/eval.txt -f alto -d cuda "${XML_FOLDER}/*.xml"
