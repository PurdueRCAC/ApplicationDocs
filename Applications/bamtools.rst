.. _backbone-label:

bamtools
==============================

Description
~~~~~~~~
C++ API & command-line toolkit for working with BAM data.

Versions
~~~~~~~~
- Anvil: 2.5.2

Module
~~~~~~~~
You can load the modules by::

    module load bamtools

Example job
~~~~
To run bamtools our our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name 
    #SBATCH -t 20:00:00
    #SBATCH -N 1
    #SBATCH -n 24
    #SBATCH -p PartitionName 
    #SBATCH --job-name=bamtools
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module load bamtools

    bamtools convert -format fastq -in in.bam -out out.fastq

