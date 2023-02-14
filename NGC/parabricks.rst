.. _backbone-label:

Parabricks
==============================

Description
~~~~~~~~
NVIDIAs Clara Parabricks brings next generation sequencing to GPUs, accelerating an array of gold-standard tooling such as BWA-MEM, GATK4, Googles DeepVariant, and many more. Users can achieve a 30-60x acceleration and 99.99% accuracy for variant calling when comparing against CPU-only BWA-GATK4 pipelines, meaning a single server can process up to 60 whole genomes per day. These tools can be easily integrated into current pipelines with drop-in replacement commands to quickly bring speed and data-center scale to a range of applications including germline, somatic and RNA workflows.

Versions
~~~~~~~~
- Scholar: 4.0.0-1
- Gilbreth: 4.0.0-1
- Anvil: 4.0.0-1

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load parabricks

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run parabricks on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=parabricks
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc parabricks

