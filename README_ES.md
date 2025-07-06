# 🧠 ai-log-analyzer-devops

> Un analizador de logs potenciado con IA que procesa registros de entornos DevOps (como Jenkins o Kubernetes) y proporciona diagnósticos inteligentes y recomendaciones utilizando LLMs como GPT-4o (OpenAI) o modelos locales mediante Ollama (LLaMA3, Phi-3, etc).

---

## 🚀 Funcionalidades

- 🔍 Analiza registros de pipelines CI/CD (Jenkins, Helm, Kubernetes)
- 🤖 Compatible con OpenAI GPT-4o o modelos locales con Ollama
- 📦 CLI sencillo y microservicio REST con Flask
- 🐳 Listo para Docker y despliegue en Kubernetes
- ✍️ Prompts modulares y editables (`.prompt`)
- 📁 Funciona completamente online u offline
- 🛠️ Makefile integrado para automatización de build y despliegue
- 🔁 Integra con Jenkins para análisis en caliente desde pipelines

---

## 📦 Estructura del Proyecto

```
ai-log-analyzer-devops/
├── app.py                 # Microservicio Flask (API /analyze)
├── cli/                   # Scripts CLI como generate.py
├── lib/                   # Clientes OpenAI/Ollama y lógica común
├── logs/                  # Logs de ejemplo
├── prompts/               # Plantillas .prompt dinámicas
├── requirements.txt       # Dependencias Python
├── Dockerfile             # Contenedor Flask
├── Makefile               # Build y despliegue automatizado
└── README.md              # Documentación del proyecto
```

---

## 🧩 Descripción Detallada de Componentes

### `app.py`

Microservicio Flask desplegable en K8s:
- Endpoint `/analyze`
- Acepta JSON: `{ "log": "...", "mode": "openai|ollama" }`
- Crea archivo temporal con el log
- Llama a `generate.py` y devuelve salida como JSON

### `cli/generate.py`

Script de entrada para analizar logs:
- Argumentos: `--mode`, `--logfile`
- Carga el log con `load_log()`
- Inyecta contenido en el prompt (`${LOG_CONTENT}`)
- Llama a `generate_documentation()` para obtener respuesta del modelo

### `lib/`

- `input_loader.py`: lee archivos de log plano
- `utils.py`: carga templates `.prompt`
- `ollama_client.py`: cliente HTTP para Ollama
- `openai_client.py`: cliente ChatCompletion GPT-4o
- `docgen.py`: conecta todo y genera la documentación

### `prompts/`

Contiene prompts dinámicos como `log_analysis.prompt`.
Puedes añadir más plantillas personalizadas para adaptar el análisis.

### `Dockerfile`

Contenedor Flask. Expone puerto 5000.

```bash
docker build -t log-analyzer:dev .
docker run -p 5000:5000 log-analyzer:dev
```

### `Makefile`

Automatiza tareas como:
```bash
make build             # Build de imagen local
make load              # Carga en KIND
make update-values     # Actualiza values.yaml (Helm)
make sync              # Sincroniza con ArgoCD
make release VERSION=v0.1.5  # Pipeline completo
```

---

## 🔁 Jenkins Integration

Puedes llamar al microservicio desde un pipeline declarativo como:

```
pipeline {
  parameters {
    choice(name: 'MODELO_IA', choices: ['openai', 'ollama'], description: 'Motor IA')
  }
  environment {
    OPENAI_API_KEY = credentials('OPENAI_API_KEY')
  }
  stages {
    stage('Analizar Logs') {
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
          echo "Respuesta: ${response}"
        }
      }
    }
  }
}
```

---

## 🛠️ Primeros pasos

```bash
git clone https://github.com/dorado-ai-devops/ai-log-analyzer-devops.git
cd ai-log-analyzer-devops
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### ⚙️ Ejecutar CLI

```bash
python3 cli/generate.py --mode ollama --logfile logs/example.log
```

### ⚙️ Ejecutar microservicio

```bash
python3 app.py
```

---

## 💡 Ejemplo de salida

```
Fallo detectado al conectar con el servicio de base de datos.
Causa: el servicio `db.example.local` no está disponible al arrancar.
Recomendación: revisar variable DB_HOST, políticas de red y estado del servicio.
```

---


## 👨‍💻 Autor

- **Dani** – [@dorado-ai-devops](https://github.com/dorado-ai-devops)

---

## 🧠 Inspirado por

- [LangChain](https://github.com/langchain-ai/langchain)
- [Ollama](https://ollama.com)
- [OpenAI API](https://platform.openai.com/docs)


---

## 🛡 Licencia

Licencia Pública General GNU v3.0