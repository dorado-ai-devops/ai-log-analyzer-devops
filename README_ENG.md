# 🧠 ai-log-analyzer-devops

> An AI-powered log analyzer that processes logs from DevOps environments (like Jenkins or Kubernetes) and provides intelligent diagnostics and recommendations using LLMs such as GPT-4o (OpenAI) or local models via Ollama (LLaMA3, Phi-3, etc).

---

## 🚀 Features

- 🔍 Analyze CI/CD pipeline logs (Jenkins, Helm, Kubernetes)
- 🤖 Powered by OpenAI GPT-4o or local models via Ollama
- 📦 Simple CLI tool, Docker-ready
- ✍️ Modular and editable prompt templates
- 📁 Works fully online or offline

---

## 📦 Project Structure

```
ai-log-analyzer-devops/
├── cli/                    # Command-line interface scripts
├── lib/                    # Core logic and AI clients
├── logs/                   # Example logs for testing
├── prompts/                # Prompt templates for LLMs
├── requirements.txt        # Python dependencies
├── Dockerfile              # Containerization setup
└── README.md               # Project documentation
```

---

## 🧩 Detailed Description of Components

### `cli/`

Contains terminal-executable scripts. Currently, `generate.py` is the main script that:

- Reads a log file
- Calls an LLM based on the selected mode (`openai` or `ollama`)
- Uses the appropriate prompt template from `prompts/`
- Displays the result in the terminal

### `lib/`

Houses reusable core logic:

- OpenAI and Ollama clients
- Functions to load logs, build prompts, and process model responses
- This layer separates the CLI interface from internal logic, enhancing testability and modularity

### `logs/`

Includes `.log` files for testing and development, such as `example_jenkins.log`.

### `prompts/`

Defines the instruction templates sent to the LLM. Modularizing prompts allows:

- Adjusting the output style
- Tweaking model behavior
- Decoupling business logic from AI content

### `requirements.txt`

List of necessary dependencies. Includes libraries like `openai`, `requests`, etc. Install with:

```bash
pip install -r requirements.txt
```

### `Dockerfile`

Allows full containerization of the application. Ideal for CI/CD deployment or running in offline environments with Ollama.

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

### ⚙️ Run (OpenAI mode)

```bash
OPENAI_API_KEY=sk-xxx \
python3 cli/generate.py --mode openai --logfile logs/example_jenkins.log
```

### ⚙️ Run (Local mode with Ollama)

```bash
ollama run llama3
python3 cli/generate.py --mode ollama --logfile logs/example_jenkins.log
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

-

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

