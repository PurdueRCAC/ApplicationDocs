Using constraint to request specific GPUs
============================================


Gilbreth has heterogeneous hardware comprising of Nvidia V100, A100, A10, and A30 GPUs in separate subclusters. You can run ``sfeatures`` to check the specifications of different Gilbreth nodes::

	NODELIST              CPUS   MEMORY    AVAIL_FEATURES                      GRES
	gilbreth-b[000-015]   24     190000    B,b,A30,a30                         gpu:3
	gilbreth-c[000-002]   20     760000    C,c,V100,v100                       gpu:4
	gilbreth-d[000-007]   16     190000    D,d,A30,a30                         gpu:3
	gilbreth-e[000-015]   16     190000    E,e,V100,v100                       gpu:2
	gilbreth-f[000-004]   40     190000    F,f,V100,v100                       gpu:2
	gilbreth-g[000-011]   128    510000    G,g,A100,a100,A100-40GB,a100-40gb   gpu:2
	gilbreth-h[000-015]   32     512000    H,h,A10,a10                         gpu:3
	gilbreth-i[000-004]   32     512000    I,i,A100,a100,A100-80GB,a100-80gb   gpu:2
	gilbreth-j[000-001]   128    1020000   J,j,A100,a100,A100-80GB,a100-80gb   gpu:4

To run your jobs in specfic nodes, you can use ``-C, --constraint`` to specfify the **features**. Below are a few examples::

        #SBATCH --constraint 'E/F'   ## request E or F nodes
        #SBATCH --constraint A100    ## request A100 GPU
        #SBATCH -C  "v100|p100|a30"  ## request v100, p100 or a30
	
