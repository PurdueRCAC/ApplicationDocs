Many-Task Computing using hyper-shell
=====================================

HyperShell is an elegant, cross-platform, high-performance computing utility for processing shell commands over a distributed, asynchronous queue. It is a highly scalable workflow automation tool for many-task scenarios.

Several tools offer similar functionality but not all together in a single tool with the user ergonomics we provide. Novel design elements include but are not limited to (1) cross-platform, (2) client-server design, (3) staggered launch for large scales, (4) persistent hosting of the server, and optionally (5) a database in-the-loop for persisting task metadata and automated retries.

HyperShell is pure Python and is tested on Linux, macOS, and Windows 10 in Python 3.9 and 3.10 environments. The server and client don’t even need to use the same platform simultaneously.

Detailed usage about hyper-shell can be found here: https://hyper-shell.readthedocs.io/en/latest/

Cluster
~~~~~~~~~~
Start the cluster either locally or with remote clients over ssh or a custom launcher. This mode should be the most common entry-point for general usage. It fully encompasses all of the different agents in the system in a concise workflow.

The input source for tasks is file-like, either a local path, or from stdin if no argument is given. The command-line tasks are pulled in and either directly published to a distributed queue (see --no-db) or committed to a database first before being scheduled later.

For large, long running workflows, it might be a good idea to configure a database and run an initial submit job to populate the database, and then run the cluster with --restart and no input FILE. If the cluster is interrupted for whatever reason it can gracefully restart where it left off.

A simple user case is that users just need to privde a taskfile containing commands/tasks. Each line is one command/task. Below is a batch jobscript that can used in ACCESS Anvil cluster::

        #!/bin/bash

        #SBATCH -A AllocationName
        #SBATCH -N 1
        #SBATCH -n 12
        #SBATCH -p shared
        #SBATCH --time=4:00:00
        #SBATCH --job-name=trim-galore
        #SBATCH --error=%x-%J-%u.err
        #SBATCH --output=%x-%J-%u.out
        #SBATCH --mail-type=ALL

        module load hyper-shell

        hyper-shell cluster Taskfile.txt \
                -o trim_Taskfile.output \
                -f trim_Taskfile.failed \
                -N 3 ## Number of tasks to run simultaneously

Below are contents of **Taskfile.txt** that I want to run a bioinformatics application called ``Trim-galore``::

        trim_galore ---fastqc -j 4 -q 25 --paired seq1_1.fastq seq1_2.fastq -o trim_out && echo task1 success
        trim_galore ---fastqc -j 4 -q 25 --paired seq2_1.fastq seq2_2.fastq -o trim_out && echo task2 success
        trim_galore ---fastqc -j 4 -q 25 --paired seq3_1.fastq seq3_1.fastq -o trim_out && echo task3 success
        trim_galore ---fastqc -j 4 -q 25 --paired seq4_1.fastq seq4_2.fastq -o trim_out && echo task4 success
        trim_galore ---fastqc -j 4 -q 25 --paired seq5_1.fastq seq5_2.fastq -o trim_out && echo task5 success
        trim-galore ---fastqc -j 4 -q 25 --paired seq6_1.fastq seq6_2.fastq -o trim_out && echo task6 success

In the slurm jobscript, we request 12 CPUs and 3 jobs (-N 3) to run simultaneously. Each ``trim_galore`` job will also use 4 CPUs (-j 4). So that we can efficiently use all 12 CPUs. The task1-3 will run when the hyper-shell job start. If any of the first 3 tasks completes, task4 will start, and so on until all tasks complete. 

You may notice that in task6, there is a typo. The command should be ``trim_galore`` instead of ``trim-galore``. So this taks will fail. Since we used ``-f trim_Taskfile.failed`` in the hyper-shell command, task6 will be saved to ``trim_Taskfile.failed``. This can help you track which tasks are succssful and which ones fail.

