.. _backbone-label:

Gromacs
==============================

Description
~~~~~~~~
GROMACS GROningen MAchine for Chemical Simulations is a molecular dynamics package primarily designed for simulations of proteins, lipids and nucleic acids. It was originally developed in the Biophysical Chemistry department of University of Groningen, and is now maintained by contributors in universities and research centers across the world.

Versions
~~~~~~~~
- Bell: 2018.4, 2019.2
- Brown: 2018.4, 2019.2
- Scholar: 2018.4, 2019.2
- Gilbreth: 2018.4
- Negishi: 2022.3
- Anvil: 2021.2

Module
~~~~~~~

You can check available gromacs version by::

    module spider gromacs
    
You can check how to load the gromacs module by the module's full name::

    module spider gromacs/XXXX
    
Note: RCAC also installed some containerized gromacs modules. 
      To use these containerized modules, please following the instructions in the output of "module spider gromacs/XXXX"

You can load the modules by::

    module load gromacs # for default version
    module load gromacs/XXXX # for specific version

Usage
~~~~~~
The GROMACS executable is ``gmx_mpi`` and you can use ``gmx help commands`` for help on a command.

For more details about how to run GROMACS, please check `GROMACS`_.

Example job
~~~~~~
::

    #!/bin/bash
    # FILENAME:  myjobsubmissionfile
    
    #SBATCH --nodes=2       # Total # of nodes 
    #SBATCH --ntasks=256    # Total # of MPI tasks
    #SBATCH --time=1:30:00  # Total run time limit (hh:mm:ss)
    #SBATCH -J myjobname    # Job name
    #SBATCH -o myjob.o%j    # Name of stdout output file
    #SBATCH -e myjob.e%j    # Name of stderr error file

    # Manage processing environment, load compilers and applications.
    module purge
    module load gcc/XXXX openmpi/XXXX # or module load intel/XXXX impi/XXXX | depends on the output of "module spider gromacs/XXXX"
    module load gromacs/XXXX
    module list

    # Launch MPI code
    gmx_mpi pdb2gmx -f my.pdb -o my_processed.gro -water spce
    gmx_mpi grompp -f my.mdp -c my_processed.gro -p topol.top -o topol.tpr
    srun -n $SLURM_NTASKS gmx_mpi mdrun -s topol.tpr

Note
~~~~~
Using ``mpirun -np $SLURM_NTASKS gmx_mpi`` or ``mpiexex -np $SLURM_NTASKS gmx_mpi`` may not work for non-exclusive jobs on some clusters. Use ``srun -n $SLURM_NTASKS gmx_mpi`` or ``mpirun gmx_mpi`` instead. ``mpirun gmx_mpi`` without specifying the number of ranks will automatically pick up the number of ``SLURM_NTASKS`` and works fine.


.. _GROMACS: https://manual.gromacs.org/2023/user-guide/getting-started.html#

