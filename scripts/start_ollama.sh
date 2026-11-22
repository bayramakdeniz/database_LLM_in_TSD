#!/usr/bin/env bash
# Start a local Ollama server from an Apptainer image (no root, no internet needed at run time).
# Edit the three paths below for your project area.
set -euo pipefail

MODELS_DIR=/path/to/scratch/ollama/models   # where the model weights live
SIF=/path/to/ollama.sif                      # Ollama Apptainer image

export OLLAMA_MODELS="$MODELS_DIR"
export OLLAMA_HOST=127.0.0.1:11434

apptainer exec \
  --bind "$MODELS_DIR":/root/.ollama/models \
  --env OLLAMA_MODELS=/root/.ollama/models \
  "$SIF" ollama serve &

sleep 3
apptainer exec "$SIF" ollama list

# quick test
# apptainer exec "$SIF" ollama run qwen2.5:3b "Hello, are you working?"

# to stop the server:
# apptainer exec "$SIF" pkill ollama
