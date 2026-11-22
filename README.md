# DuckDB + local LLM inside a secure research environment (TSD)

Query registry data with SQL and talk to it with a local LLM, entirely inside an
isolated environment (TSD): no managed database server, no external API calls.

- **DuckDB** replaces a managed PostgreSQL instance: a single file, queried from Python.
- **Ollama** runs from an Apptainer image on the HPC node and serves a small model (`qwen2.5:3b`).
- Everything was tested on **synthetic data** (Lynch syndrome registry: `persons`, `cancer_events`).

Project page: see `docs/index.html` (enable GitHub Pages, source: `main` branch, `/docs` folder).

## Layout

| Path | What it is |
|---|---|
| `scripts/start_ollama.sh` | start the Ollama server from the `.sif` image |
| `scripts/start_jupyter.sh` | Jupyter on the HPC node + SSH tunnel |
| `scripts/ask_llm.py` | recommended pattern: SQL computes, LLM describes |
| `notebooks/duckdb_ollama_showcase.ipynb` | the original walkthrough with outputs |
| `requirements.txt` | Python packages |

## Quick start

```bash
pip install -r requirements.txt
bash scripts/start_ollama.sh      # edit paths first
python scripts/ask_llm.py
```


## Data

No data is included. "ls_registry2.duckdb" is created using synthetic data
