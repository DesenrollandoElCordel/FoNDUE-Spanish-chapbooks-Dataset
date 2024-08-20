#!/bin/env bash
#SBATCH --partition=public-gpu
#SBATCH --time=2-00:00:00
#SBATCH --gpus=1
#SBATCH --output=kraken_HTRAll-%j.out
#SBATCH --mem=12GB
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1,VramPerGpu:12GB

module load fosscuda/2020b Python/3.8.6
source ~/kraken-env/bin/activate


work_directory="/home/users/j/jacsont/Varios-OCR-files/Models/Models-HTR-Varios/HTR_All"
mkdir -p ${work_directory}
cd ${work_directory}

OUTPUT_NAME="HTRAll"

XML_FOLDER="/home/users/j/jacsont/Varios-OCR-files/Data/**/"
echo "KETOS training"
srun ketos train -f alto --load "${work_directory}/model_5.mlmodel"   "${XML_FOLDER}/*.xml"
