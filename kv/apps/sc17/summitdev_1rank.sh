#!/bin/bash

#BSUB -P ######
#BSUB -J 1rank
#BSUB -o output.o%J
#BSUB -W 4:00
#BSUB -n 1
#BSUB -env "all,JOB_FEATURE=NVME"

KEYLEN=16
VALLEN=(64 128 256 512 1024 2048 4096 8192 16384 32768 65536 131072 262144 524288 1048576)
COUNT=10000

export PAPYRUSKV_REPOSITORY=/xfs/scratch/kimj1/pkv_1rank
export PAPYRUSKV_DESTROY_REPOSITORY=1

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=1
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${VALLEN[@]}"; do
    mpirun -np 1 ./basic $KEYLEN $i $COUNT
done

export PAPYRUSKV_REPOSITORY=/lustre/atlas/scratch/kimj1/csc103/pkv_1rank
export PAPYRUSKV_DESTROY_REPOSITORY=1

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=1
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${VALLEN[@]}"; do
    mpirun -np 1 ./basic $KEYLEN $i $COUNT
done
