#!/bin/bash -l

#SBATCH -J 1node
#SBATCH -o output.o%j
#SBATCH -e output.e%j
#SBATCH -p normal
#SBATCH -N 1
#SBATCH -n 68
#SBATCH -t 01:00:00
#SBATCH -A ##-#########

KEYLEN=16
VALLEN=(64 128 256 512 1024 2048 4096 8192 16384 32768 65536 131072 262144 524288 1048576)
COUNT=1000

export PAPYRUSKV_REPOSITORY=/tmp/pkv_1node
export PAPYRUSKV_DESTROY_REPOSITORY=1

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${VALLEN[@]}"; do
    ibrun -np 68 ./basic $KEYLEN $i $COUNT
done

export PAPYRUSKV_REPOSITORY=$SCRATCH/pkv_1node
export PAPYRUSKV_DESTROY_REPOSITORY=1

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=2
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1
for i in "${VALLEN[@]}"; do
    ibrun -np 68 ./basic $KEYLEN $i $COUNT
done

# eof

