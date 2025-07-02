# 🧠 ai-log-analyzer-devops

> An AI-powered log analyzer that processes logs from DevOps environments (like Jenkins or Kubernetes) and provides intelligent diagnostics and recommendations using LLMs such as GPT-4o (OpenAI) or local models via Ollama (LLaMA3, Phi-3, etc).

---

## 🚀 Features

- 🔍 Analyze CI/CD pipeline logs (Jenkins, Helm, Kubernetes)
- 🤖 Powered by OpenAI GPT-4o or local models via Ollama
- 📦 Simple CLI tool and REST microservice (Flask)
- 🐳 Docker-ready and Kubernetes-deployable
- ✍️ Modular and editable prompt templates
- 📁 Works fully online or offline

---

## 📦 Project Structure

```
ai-log-analyzer-devops/
├── app.py                 # Flask server for K8s integration (REST endpoint)
├── cli/                   # Command-line interface scripts
├── lib/                   # Core logic and AI clients
├── logs/                  # Example logs for testing
├── prompts/               # Prompt templates for LLMs
├── requirements.txt       # Python dependencies
├── Dockerfile             # Containerization setup
└── README.md              # Project documentation
```

---

## 🧩 Detailed Description of Components

### `app.py`

Flask microservice exposing `/analyze` endpoint:
- Accepts a log in JSON (`{ "log": "..." }`)
- Internally calls `cli/generate.py` to analyze
- Returns structured AI-based response
- Deployable as a microservice on Kubernetes

### `cli/`

Terminal script: `generate.py`:
- Reads a log file
- Selects mode: `openai` or `ollama`
- Loads relevant prompt
- Returns model response in terminal or JSON

### `lib/`

Internal logic:
- OpenAI/Ollama clients
- Prompt and log processing
- Clean separation of logic and interface

### `logs/`

Sample `.log` files for dev/testing (`example_jenkins.log`)

### `prompts/`

Instruction templates to control model behavior/output

### `requirements.txt`

Install dependencies:

```bash
pip install -r requirements.txt
```

Includes: `openai`, `flask`, `requests`, etc.

### `Dockerfile`

Containerizes the app (Flask-based). Ideal for CI/CD deployment, local development, and Kubernetes environments.

---

## 🛠️ Getting Started

### 🔁 Clone and Setup

```bash
git clone https://github.com/dorado-ai-devops/ai-log-analyzer-devops.git
cd ai-log-analyzer-devops
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### ⚙️ Run as CLI (OpenAI mode)

```bash
OPENAI_API_KEY=sk-xxx python3 cli/generate.py --mode openai --logfile logs/example_jenkins.log
```

### ⚙️ Run as REST microservice (Flask)

```bash
python3 app.py
```

### 🔁 Run in Docker (Flask server)

```bash
docker build -t log-analyzer:dev .
docker run -p 5000:5000 log-analyzer:dev
```

---

## 💡 Example Output

```text
Detected failure to connect to database service.
Cause: service `db.example.local` unreachable during startup.
Recommendation: Check DB_HOST environment variable, network policies, and service status. Consider retrying with backoff.
```

---

## 🔮 Next Steps

- Add Jenkins integration example
- Add Kubernetes deployment manifests
- Enable streaming/tokenized responses from LLMs

---

## 📸 Screenshots *(coming soon)*

Will include visual examples of logs, terminal output, and diagrams.

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

GNU General Public License v3.0
