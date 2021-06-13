#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=80
#SBATCH --time=00300:00
#SBATCH --job-name=mpi_job
#SBATCH --output=gpaw_one_node_4.txt
#SBATCH --mail-user=n88199911652@gmail.com
#SBATCH --mail-type=BEGIN,END,FAIL


export APPROOT=$APPROOT
export MODULEPATH=$APPROOT/modules:$MODULEPATH
module load intel/2019u4
module load intelmpi/2019u4
module load openblas/0.3.7
module load python/3.8.5

cd  $APPROOT

export PATH=$PATH:$HOME/.local/bin
export GPAW_CONFIG=$APPROOT/gpaw-20.10.0/siteconfig.py
export GPAW_SETUP_PATH=$APPROOT/gpaw-setups-0.9.20000


HOSTS=.hosts-job$SLURM_JOB_ID
HOSTFILE=.hostlist-job$SLURM_JOB_ID
srun hostname -f > $HOSTS
sort $HOSTS | uniq -c | awk '{print $2 ":" $1}' >> $HOSTFILE



echo "=============================mpi run============================"
mpirun -np 320 -hostfile ./$HOSTFILE gpaw-python $APPROOT/gpaw-isc-2021/input-files/copper.py
