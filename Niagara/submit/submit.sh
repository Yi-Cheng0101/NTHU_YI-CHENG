#!/bin/bash
#PBS -P 50000007
#PBS -N NTHU_NEMO_4NODE_24CPUs
#PBS -q normal
#PBS -l select=4:ncpus=24:mpiprocs=24:mem=96gb
#PBS -l walltime=12:00:00
#PBS -o NTHU_GPAW_4NODE_24CPUs_out.txt
#PBS -e NTHU_GPAW_4NODE_24CPUs_err.txt
#PBS -M n88199911652@gmail.com
#PBS -m be

echo "======================== export path ============================"
export APPROOT=$APPROOT
export OMP_NUM_THREADS=1
export USE_SIMPLE_THREADED_LEVEL3= 1
ulimit -u 127590
echo "======================== module load ============================"

cd /home/users/industry/isc2020/iscst07/scratch/yicheng-5.1.0/test_4_node

echo "========================== hostfile ============================="
hostfile="hostfile.$PBS_JOBID"
WCOLL="wcoll.$PBS_JOBID"
export WCOLL
sort $PBS_NODEFILE | uniq > $WCOLL
((np=0))
for h in `cat $WCOLL` ; do
n=`grep -cx "$h" "$PBS_NODEFILE"`
echo $h-ib0:$n
((np=np+n))
done > $APPROOT/$hostfile


echo "=========================== mpi run ============================="
mpirun -np 96 -hostfile ./$hostfile gpaw python /home/users/industry/isc2020/iscst07/yicheng/gpaw-isc-2021/input-files/copper.py
