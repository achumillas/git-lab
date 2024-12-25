#!/bin/bash
#
#SBATCH -p hpc-bio-pacioli                     # Maquina a la que se lanza el scrip
#SBATCH -J alumno04                            # Usuario
#SBATCH --job-name=Cut_Files                   # Nombre del trabajo
#SBATCH --chdir=/home/alumno04/lab3/git-lab    # Directorio de trabajo
#SBATCH --output=%x-%u-%j.out                  # Salida del scrip
#SBATCH --error=%x-%u-%j.out                   # Error del scrip
#SBATCH --cpus-per-task=4                      # Numero de cpus 
#
# Introducimos las variables
USER="alumno04"
FILES=(*.fastq)
#
# Configuramos el numero de hilos 
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
#
# Ejecutamos en paralelo
parallel -j 4 ./file_cut.sh "$USER" ::: "${FILES[@]}"
time wait
#
# Fin del programa
echo ''
echo 'Archivos cortados'
echo ''
echo '-----------------------------------------------------------------'
echo ''
#
