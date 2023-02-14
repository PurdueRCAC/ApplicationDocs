.. _backbone-label:

Gamess
==============================

Description
~~~~~~~~
The General Atomic and Molecular Electronic Structure Systems GAMESS program simulates molecular quantum chemistry, allowing users to calculate various molecular properties and dynamics.

Versions
~~~~~~~~
- Scholar: 17.09-r2-libcchem
- Gilbreth: 17.09-r2-libcchem
- Anvil: 17.09-r2-libcchem

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load gamess

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run gamess on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=gamess
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc gamess

