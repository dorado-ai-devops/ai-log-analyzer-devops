# 🧠 ai-log-analyzer-devops

> An AI-powered log analyzer that processes DevOps logs and provides intelligent diagnostics and recommendations using LLMs like OpenAI (GPT-4o) or local models via Ollama (LLaMA3, Phi-3, etc.).

![DevOps + AI](https://user-images.githubusercontent.com/6871519/267622150-2a6a4b4f-e003-4e59-93a2-e3b0414e1bda.png)

---

## 🚀 Features

- 🔍 Analyze logs from CI/CD pipelines (e.g. Jenkins, Helm, K8s)
- 🤖 Powered by OpenAI GPT-4o or Ollama (local LLMs)
- 📦 Simple CLI tool and Docker-ready
- ✍️ Modular prompt templates
- 📁 Works fully offline or online

---

## 📦 Project Structure

```
ai-log-analyzer-devops/
├── cli/                    # Command-line interface
├── lib/                    # Core logic and clients (OpenAI, Ollama)
├── logs/                   # Example logs
├── prompts/                # Prompt templates
├── requirements.txt        # Python dependencies
├── Dockerfile              # Containerization
└── README.md
```

---

## 🛠️ Getting Started

### 🔁 Clone & Setup

```bash
git clone git@github.com:dorado-ai-devops/ai-log-analyzer-devops.git
cd ai-log-analyzer-devops
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### ⚙️ Run (OpenAI mode)

```bash
OPENAI_API_KEY=sk-xxx \
python3 cli/generate.py --mode openai --logfile logs/example_jenkins.log
```

### ⚙️ Run (Ollama local mode)

```bash
ollama run llama3
python3 cli/generate.py --mode ollama --logfile logs/example_jenkins.log
```

---

## 💡 Example Output

```
--- Análisis generado ---

Detected failure to connect to database service.
Cause: service `db.example.local` unreachable during startup.
Recommendation: Check DB_HOST env variable, network policies and service status. Consider retry with backoff strategy.
```

---

## 🔮 Next steps

- [ ] 🧩 Add observability/logging via Prometheus or Loki
- [ ] 🧠 Add planning agents via LangChain / CrewAI
- [ ] 🗂️ Export reports as Markdown or JSON
- [ ] ⚙️ Docker + Helm deployable

---

## 📸 Screenshots *(soon)*

> We'll add terminal examples, logs, diagrams and flowcharts.

---

## 👨‍💻 Author

- **Dani** – [@dorado-ai-devops](https://github.com/dorado-ai-devops)

---

## 🧠 Inspired by

- [LangChain](https://github.com/langchain-ai/langchain)
- [Ollama](https://ollama.com)
- [OpenAI API](https://platform.openai.com/docs)

---

## 🛡 License

MIT — use freely, modify consciously.
