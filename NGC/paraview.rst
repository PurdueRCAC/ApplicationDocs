.. _backbone-label:

paraview
==============================

Description
~~~~~~~~
no ParaView client GUI in this container, but ParaView Web application is included.

Versions
~~~~~~~~
- Scholar: 5.9.0
- Gilbreth: 5.9.0
- Anvil: 5.9.0

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load paraview

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run paraview on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=paraview
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc paraview

