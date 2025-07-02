# 🧠 ai-log-analyzer-devops

> An AI-powered log analyzer that processes logs from DevOps environments (such as Jenkins or Kubernetes) and provides intelligent diagnostics and recommendations using LLMs like GPT-4o (OpenAI) or local models via Ollama (LLaMA3, Phi-3, etc).

---

## 🚀 Features

- 🔍 Analyzes logs from CI/CD pipelines (Jenkins, Helm, Kubernetes)
- 🤖 Compatible with OpenAI GPT-4o or local models via Ollama
- 📦 Simple CLI and REST microservice with Flask
- 🐳 Ready for Docker and Kubernetes deployment
- ✍️ Modular and editable prompts (`.prompt`)
- 📁 Fully functional in both online and offline modes
- 🛠️ Integrated Makefile for build and deployment automation
- 🔁 Jenkins integration for on-demand log analysis from pipelines

---

## 📦 Project Structure

```
ai-log-analyzer-devops/
├── app.py                 # Flask microservice (API /analyze)
├── cli/                   # CLI scripts like generate.py
├── lib/                   # OpenAI/Ollama clients and core logic
├── logs/                  # Sample logs
├── prompts/               # Dynamic .prompt templates
├── requirements.txt       # Python dependencies
├── Dockerfile             # Flask container setup
├── Makefile               # Build and deployment automation
└── README.md              # Project documentation
```

---

## 🧩 Component Overview

### `app.py`

Flask microservice deployable on K8s:
- Endpoint `/analyze`
- Accepts JSON: `{ "log": "...", "mode": "openai|ollama" }`
- Creates a temporary file with the log
- Calls `generate.py` and returns AI output as JSON

### `cli/generate.py`

CLI entry point for log analysis:
- Arguments: `--mode`, `--logfile`
- Loads log using `load_log()`
- Injects content into prompt (`${LOG_CONTENT}`)
- Calls `generate_documentation()` to get model output

### `lib/`

- `input_loader.py`: reads plain text log files
- `utils.py`: loads `.prompt` templates
- `ollama_client.py`: HTTP client for Ollama
- `openai_client.py`: GPT-4o client using ChatCompletion API
- `docgen.py`: connects all pieces and returns formatted result

### `prompts/`

Holds dynamic templates like `log_analysis.prompt`.  
You can add new ones to customize analysis behavior.

### `Dockerfile`

Flask-based container exposing port 5000:

```bash
docker build -t log-analyzer:dev .
docker run -p 5000:5000 log-analyzer:dev
```

### `Makefile`

Automates common tasks:
```bash
make build             # Build Docker image
make load              # Load into KIND
make update-values     # Update Helm values.yaml
make sync              # Sync with ArgoCD
make release VERSION=v0.1.5  # Full release workflow
```

---

## 🔁 Jenkins Integration

Example of invoking the microservice from a Jenkins pipeline:

```
pipeline {
  parameters {
    choice(name: 'MODELO_IA', choices: ['openai', 'ollama'], description: 'AI engine')
  }
  environment {
    OPENAI_API_KEY = credentials('OPENAI_API_KEY')
  }
  stages {
    stage('Analyze Logs') {
      steps {
        script {
          def logText = "Build failed: unable to connect to database"
          def jsonPayload = "{ \"log\": \"" + logText + "\", \"mode\": \"" + params.MODELO_IA + "\" }"
          def curlCommand = '''
            curl -X POST http://log-analyzer-service.devops-ai.svc.cluster.local:80/analyze \\
              -H "Content-Type: application/json" \\
              -d '${jsonPayload}'
          '''
          if (params.MODELO_IA == 'openai') {
            curlCommand = curlCommand.replace("-d", "-H \"Authorization: Bearer $OPENAI_API_KEY\" -d")
          }
          def response = sh(script: curlCommand, returnStdout: true).trim()
          echo "Response: ${response}"
        }
      }
    }
  }
}
```

---

## 🛠️ Getting Started

```bash
git clone https://github.com/dorado-ai-devops/ai-log-analyzer-devops.git
cd ai-log-analyzer-devops
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### ⚙️ Run CLI

```bash
python3 cli/generate.py --mode ollama --logfile logs/example.log
```

### ⚙️ Run Microservice

```bash
python3 app.py
```

---

## 💡 Example Output

```
Detected failure to connect to the database service.
Cause: the `db.example.local` service is unavailable at startup.
Recommendation: check DB_HOST variable, network policies, and service state.
```

---

## 🔮 Roadmap

- Enable streaming output (`stream=True` in Ollama)
- Structured JSON logging
- API key authentication (for public exposure)
- Full Helm + ArgoCD deployment examples

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