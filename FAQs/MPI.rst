MPI
==============================

SLURM can run an MPI program with the ``srun`` command. The number of processes is requested with the ``-n`` option. If you do not specify the ``-n`` option, it will default to the total number of processor cores you request from SLURM.

If the code is built with OpenMPI, it can be run with a simple srun ``-n`` command. If it is built with Intel **IMPI**, then you also need to add the ``--mpi=pmi2`` option: ``srun --mpi=pmi2 -n 32 ./mpi_hello``.
