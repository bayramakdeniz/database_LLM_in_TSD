#!/usr/bin/env bash
# Run Jupyter on the HPC node and reach it from your laptop through an SSH tunnel.

# --- on your local machine ---
# ssh -N -f -L localhost:8885:localhost:8885 <hpc-host>
# ssh <hpc-host>

# --- on the HPC node ---
module load Python/3.11.3-GCCcore-12.3.0
source /path/to/venv/bin/activate

cd /path/to/project
jupyter notebook --no-browser --port=8885
# then open http://localhost:8885 in your local browser
