.. _backbone-label:

blast-plus
==============================

Description
~~~~~~~~
Basic Local Alignment Search Tool. BLAST finds regions of similarity between biological sequences. The program compares nucleotide or protein sequences to sequence databases and calculates the statistical significance.

Versions
~~~~~~~~
- Anvil: 2.12.0

Module
~~~~~~~~
You can load the modules by::

    module load blast-plus

BLAST Databases
~~~~~~~~~~~~~~~~~
Local copies of the blast dabase can be found in the directory **/anvil/datasets/ncbi/blast/latest**. The environment varialbe ``BLASTDB`` was also set as ``/anvil/datasets/ncbi/blast/latest``. If users want to use ``cdd_delta``, ``env_nr``, ``env_nt``, ``nr``, ``nt``, ``pataa``, ``patnt``, ``pdbnt``,  ``refseq_protein``, ``refseq_rna``, ``swissprot``, or ``tsa_nt`` databases, do not need to provide the database path. Instead, just use the format like this ``-db nr``.


Example job
~~~~~~~~~~~~
To run bamtools our our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name 
    #SBATCH -t 20:00:00
    #SBATCH -N 1
    #SBATCH -n 24
    #SBATCH -p PartitionName 
    #SBATCH --job-name=blast
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module load blast-plus
   
    blastp -query protein.fasta -db nr -out test_out -num_threads 4
