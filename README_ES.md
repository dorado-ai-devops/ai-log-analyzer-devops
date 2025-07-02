# 🧠 ai-log-analyzer-devops

> Analizador de logs con inteligencia artificial para entornos DevOps (como Jenkins o Kubernetes), que proporciona diagnósticos automáticos y recomendaciones utilizando LLMs como GPT-4o (OpenAI) o modelos locales mediante Ollama (LLaMA3, Phi-3, etc).

---

## 🚀 Características

- 🔍 Analiza logs de pipelines CI/CD (Jenkins, Helm, Kubernetes)
- 🤖 Compatible con OpenAI GPT-4o o modelos locales vía Ollama
- 🛠 CLI simple y microservicio REST (Flask)
- 🐳 Preparado para Docker y desplegable en Kubernetes
- ✍️ Prompts modulares y personalizables
- 📁 Funciona completamente online u offline

---

## 📦 Estructura del proyecto

```
ai-log-analyzer-devops/
├── app.py                 # Servidor Flask para integración REST (K8s)
├── cli/                   # Scripts de línea de comandos
├── lib/                   # Lógica central y clientes de IA
├── logs/                  # Logs de ejemplo para pruebas
├── prompts/               # Plantillas de prompts para LLMs
├── requirements.txt       # Dependencias Python
├── Dockerfile             # Configuración de contenedor
└── README.md              # Documentación principal
```

---

## 🧩 Descripción detallada de los componentes

### `app.py`

Microservicio Flask con endpoint `/analyze`:
- Recibe un log vía JSON (`{ "log": "..." }`)
- Llama internamente al CLI `cli/generate.py`
- Devuelve una respuesta estructurada generada por IA
- Listo para ser desplegado en Kubernetes

### `cli/`

Script principal: `generate.py`:
- Lee un archivo `.log`
- Selecciona el modo (`openai` u `ollama`)
- Carga el prompt correspondiente
- Muestra el resultado en consola o como JSON

### `lib/`

Lógica de negocio:
- Clientes para OpenAI y Ollama
- Procesamiento de logs y prompts
- Separación clara entre lógica y presentación

### `logs/`

Logs de prueba (`example_jenkins.log`, etc.)

### `prompts/`

Plantillas de instrucciones que controlan el comportamiento de los modelos

### `requirements.txt`

Instalación de dependencias:

```bash
pip install -r requirements.txt
```

Incluye: `openai`, `flask`, `requests`, etc.

### `Dockerfile`

Empaqueta la aplicación (servidor Flask). Útil para entornos CI/CD, desarrollo local y Kubernetes.

---

## 🛠️ Primeros pasos

### 🔁 Clonar y preparar entorno

```bash
git clone https://github.com/dorado-ai-devops/ai-log-analyzer-devops.git
cd ai-log-analyzer-devops
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### ⚙️ Ejecutar como CLI (modo OpenAI)

```bash
OPENAI_API_KEY=sk-xxx python3 cli/generate.py --mode openai --logfile logs/example_jenkins.log
```

### ⚙️ Ejecutar como microservicio REST

```bash
python3 app.py
```

### 🔁 Ejecutar en Docker (modo Flask API)

```bash
docker build -t log-analyzer:dev .
docker run -p 5000:5000 log-analyzer:dev
```

---

## 💡 Ejemplo de salida

```text
Fallo detectado al conectar con el servicio de base de datos.
Causa: el servicio `db.example.local` no estaba disponible al arrancar.
Recomendación: verifica la variable DB_HOST, las políticas de red y el estado del servicio. Considera implementar reintentos con backoff.
```

---

## 🔮 Próximos pasos

- Añadir integración con Jenkins
- Crear manifiestos de despliegue en Kubernetes
- Soporte para respuestas streaming desde LLMs

---

## 📸 Capturas *(próximamente)*

Incluirá ejemplos visuales de logs, salidas en consola y diagramas.

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

GNU General Public License v3.0
