#!/bin/env bash
#SBATCH --partition=public-gpu
#SBATCH --time=2-00:00:00
#SBATCH --gpus=1
#SBATCH --output=kraken-%j.out
#SBATCH --mem=0

module load fosscuda/2020b Python/3.8.6
source ~/Sandozenv/bin/activate
pip install albumentations

work_directory="/home/users/j/jacsont/Varios-OCR-files/Models/Models-segmentation/Model_BGR_3"
mkdir -p ${work_directory}
cd ${work_directory}

OUTPUT_NAME="output_name"

XML_FOLDER="/home/users/j/jacsont/Varios-OCR-files/Grountruth/Data/"
echo "KETOS training"
srun ketos segtrain -f alto -t /home/users/j/jacsont/Varios-OCR-files/Grountruth/Split/train.txt -e /home/users/j/jacsont/Varios-OCR-files/Grountruth/Split/eval.txt -d cuda "${XML_FOLDER}/*.xml"
