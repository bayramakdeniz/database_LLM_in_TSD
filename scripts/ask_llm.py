"""Recommended pattern: let SQL do the maths, let the LLM do the wording."""
import duckdb
import ollama

con = duckdb.connect("ls_registry2.duckdb", read_only=True)
client = ollama.Client(host="http://127.0.0.1:11434")

# 1. exact numbers come from the database
summary = con.execute("""
    SELECT p.MMR_gene,
           COUNT(*)                                  AS n_cancers,
           ROUND(AVG(ce.age_at_cancer_diagnosis), 1) AS mean_age
    FROM persons p
    JOIN cancer_events ce ON p.person_id = ce.person_id
    GROUP BY p.MMR_gene
    ORDER BY n_cancers DESC
""").fetchdf()

# 2. the model only describes the small, exact table, and is told what the columns mean
prompt = (
    "You are helping a clinical researcher. 'LS' means Lynch syndrome and MMR means "
    "mismatch repair. Describe the table below in 3 sentences. Do not compute new numbers.\n\n"
    + summary.to_string(index=False)
)

reply = client.chat(model="qwen2.5:3b", messages=[{"role": "user", "content": prompt}])
print(summary)
print(reply["message"]["content"])
