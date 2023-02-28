.. _backbone-label:

gatk
==============================

Description
~~~~~~~~
Genome Analysis Toolkit Variant Discovery in High-Throughput Sequencing Data

Versions
~~~~~~~~
- Anvil: 4.1.8.1

Module
~~~~~~~~
You can load the modules by::

    module load gatk

Example job
~~~~~
To run gatk our our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name 
    #SBATCH -t 20:00:00
    #SBATCH -N 1
    #SBATCH -n 24
    #SBATCH -p PartitionName 
    #SBATCH --job-name=gatk
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module load gatk
    
    gatk  --java-options "-Xmx12G -XX:ParallelGCThreads=24" HaplotypeCaller -R hg38.fa -I 19P0126636WES.sorted.bam  -O 19P0126636WES.HC.vcf --sample-name 19P0126636
