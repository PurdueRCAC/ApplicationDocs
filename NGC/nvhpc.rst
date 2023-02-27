.. _backbone-label:

nvhpc
==============================

Description
~~~~~~~~
The NVIDIA HPC SDK C, C++, and Fortran compilers support GPU acceleration of HPC modeling and simulation applications with standard C++ and Fortran, OpenACC® directives, and CUDA®. GPU-accelerated math libraries maximize performance on common HPC algorithms, and optimized communications libraries enable standards-based multi-GPU and scalable systems programming.

Versions
~~~~~~~~
- Scholar: 20.7, 20.9, 20.11, 21.5, 21.9
- Gilbreth: 20.7, 20.9, 20.11, 21.5, 21.9
- Anvil: 20.7, 20.9, 20.11, 21.5, 21.9

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load nvhpc

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run nvhpc on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 8
    #SBATCH --gpus-per-node=1
    #SBATCH --job-name=nvhpc
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc nvhpc

