#!/bin/bash
#SBATCH --job-name=<JOBNAME> # Job name
#SBATCH --nodes=1 # Number of nodes
#SBATCH --ntasks=1 # Number of tasks
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G # Memory allocation
#SBATCH --time=00:15:00 # Time limit (HH:MM:SS)
#SBATCH --mail-type=begin # Email when job starts
#SBATCH --mail-type=end # Email when job ends
#SBATCH --mail-user=<NETID>@princeton.edu
#SBATCH --gres=gpu:1 # Request 1 GPU
##SBATCH --array=0-<ARRAY_MAX> # Uncomment if using job arrays
##SBATCH --account=<ACT>
##SBATCH --partition=<PART>
##SBATCH --constraint=<CONST>

module purge
module load anaconda3/2024.10
conda activate <CONDA_ENV>

mkdir -p <OUTPUT_DIR>logs/wandb
tune run lora_finetune_single_device \
    --config finetune_filled.yaml
[ $? == 0 ] && mv slurm-${SLURM_JOB_ID}.out <OUTPUT_DIR>/