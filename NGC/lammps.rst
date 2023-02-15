.. _backbone-label:

lammps
==============================

Description
~~~~~~~~
Large-scale Atomic/Molecular Massively Parallel Simulator LAMMPS is a software application designed for molecular dynamics simulations. It has potentials for solid-state materials metals, semiconductor, soft matter biomolecules, polymers and coarse-grained or mesoscopic systems. It can be used to model atoms or, more generically, as a parallel particle simulator at the atomic, meso, or continuum scale.

Versions
~~~~~~~~
- Scholar: 10Feb2021, 15Jun2020, 24Oct2018, 29Oct2020
- Gilbreth: 10Feb2021, 15Jun2020, 24Oct2018, 29Oct2020
- Anvil: 10Feb2021, 15Jun2020, 24Oct2018, 29Oct2020

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load lammps

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run lammps on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=lammps
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc lammps

