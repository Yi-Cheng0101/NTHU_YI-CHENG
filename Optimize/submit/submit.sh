#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=80
#SBATCH --time=00:20:00
#SBATCH --job-name=mpi_job
#SBATCH --output=gpaw_four_node_1.txt
#SBATCH --mail-user=n88199911652@gmail.com
#SBATCH --mail-type=BEGIN,END,FAIL

module load intel/2019u4
module load intelmpi/2019u4
module load openblas/0.3.7
module load python/3.8.5
module load fftw-yi

source /scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/path.sh
cd  /scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/scalapack_4
export PATH=$PATH:$HOME/.local/bin

export PATH=/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/hdf5-1.8.21/bin:$PATH
export LD_LIBRARY_PATH=/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/hdf5-1.8.21/lib:$LD_LIBRARY_PATH
export CPATH=/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/hdf5-1.8.21/include:$CPATH

echo "============================ ipm using ========================="
#export I_MPI_STATS=ipm
#export I_MPI_STATS_FILE=profile.txt
export I_MPI_DEVICE=rdssm
export OMP_NUM_THREADS=2
#export MKL_NUM_THREADS=2

HOSTS=.hosts-job$SLURM_JOB_ID
HOSTFILE=.hostlist-job$SLURM_JOB_ID
srun hostname -f > $HOSTS
sort $HOSTS | uniq -c | awk '{print $2 ":" $1}' >> $HOSTFILE



echo "=============================mpi run============================"
#mpirun -np 80 gpaw python /home/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/gpaw-isc-2021/input-files/copper.py
mpiexec -np 160 --bind-to numa -hostfile ./$HOSTFILE  gpaw python /home/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/gpaw-isc-2021/input-files/copper.py
