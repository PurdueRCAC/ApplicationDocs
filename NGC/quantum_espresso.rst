.. _backbone-label:

Quantum_espresso
==============================

Description
~~~~~~~~
Quantum ESPRESSO is an integrated suite of Open-Source computer codes for electronic-structure calculations and materials modeling at the nanoscale based on density-functional theory, plane waves, and pseudopotentials.

Versions
~~~~~~~~
- Scholar: v6.6a1, v6.7
- Gilbreth: v6.6a1, v6.7
- Anvil: v6.6a1, v6.7

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load quantum_espresso

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run quantum_espresso on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=quantum_espresso
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc quantum_espresso

