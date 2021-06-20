#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=80
#SBATCH --time=00:20:00
#SBATCH --job-name=mpi_job
#SBATCH --output=gpaw_four_node_1.txt
#SBATCH --mail-user=n88199911652@gmail.com
#SBATCH --mail-type=BEGIN,END,FAIL
export APPROOT=/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/gpaw
export MODULEPATH=$APPROOT/modules:$MODULEPATH
export GPAW_CONFIG=$APPROOT/gpaw-20.10.0/siteconfig.py
export GPAW_SETUP_PATH=$APPROOT/gpaw-setups-0.9.20000

module load intel/2019u4
module load intelmpi/2019u4
module load python/3.8.5
module load fftw-mkl
module load libxc-4.3.4
module load hdf5-1.8.21
module load libvdxvc-0.4.0
module load elpa-2021.05.001

cd  $APPROOT
export PATH=$PATH:$HOME/.local/bin
export OMP_NUM_THREADS=2


HOSTS=.hosts-job$SLURM_JOB_ID
HOSTFILE=.hostlist-job$SLURM_JOB_ID
srun hostname -f > $HOSTS
sort $HOSTS | uniq -c | awk '{print $2 ":" $1}' >> $HOSTFILE



echo "=============================mpi run============================"
mpiexec -np 160 -bind-to none -hostfile ./$HOSTFILE  gpaw python $APPROOT/gpaw-isc-2021/input-files/copper.py
