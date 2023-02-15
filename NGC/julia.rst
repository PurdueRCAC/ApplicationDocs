.. _backbone-label:

julia
==============================

Description
~~~~~~~~
The Julia programming language is a flexible dynamic language, appropriate for scientific and numerical computing, with performance comparable to traditional statically-typed languages.

Versions
~~~~~~~~
- Scholar: v1.5.0, v2.4.2
- Gilbreth: v1.5.0, v2.4.2
- Anvil: v1.5.0, v2.4.2

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load julia

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run julia on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 8
    #SBATCH --gpus-per-node=1
    #SBATCH --job-name=julia
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc julia

