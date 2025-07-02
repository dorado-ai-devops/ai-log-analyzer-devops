# 🧠 ai-log-analyzer-devops

> Un analizador de logs potenciado con IA que procesa registros de entornos DevOps (como Jenkins o Kubernetes) y proporciona diagnósticos inteligentes y recomendaciones utilizando LLMs como GPT-4o (OpenAI) o modelos locales mediante Ollama (LLaMA3, Phi-3, etc).

---

## 🚀 Funcionalidades

- 🔍 Analiza registros de pipelines CI/CD (Jenkins, Helm, Kubernetes)
- 🤖 Compatible con OpenAI GPT-4o o modelos locales con Ollama
- 📦 CLI sencillo y microservicio REST con Flask
- 🐳 Listo para Docker y despliegue en Kubernetes
- ✍️ Prompts modulares y editables
- 📁 Funciona completamente online u offline
- 🛠️ Makefile integrado para automatización de build y despliegue

---

## 📦 Estructura del Proyecto

```
ai-log-analyzer-devops/
├── app.py                 # Servidor Flask para integración en K8s (endpoint REST)
├── cli/                   # Scripts para la línea de comandos
├── lib/                   # Lógica interna y clientes IA
├── logs/                  # Logs de ejemplo para pruebas
├── prompts/               # Plantillas de prompts para los LLMs
├── requirements.txt       # Dependencias Python
├── Dockerfile             # Configuración de contenedor
├── Makefile               # Automatización de build y despliegue
└── README.md              # Documentación del proyecto
```

---

## 🧩 Descripción Detallada de Componentes

### `app.py`

Microservicio Flask con endpoint `/analyze`:
- Acepta un log en JSON (`{ "log": "..." }`)
- Llama internamente a `cli/generate.py` para analizar
- Devuelve una respuesta estructurada generada por IA
- Desplegable como microservicio en Kubernetes

### `cli/`

Script de terminal: `generate.py`:
- Lee un archivo `.log`
- Selecciona el modo: `openai` u `ollama`
- Carga el prompt correspondiente
- Devuelve la respuesta del modelo en terminal o JSON

### `lib/`

Lógica interna:
- Clientes OpenAI y Ollama
- Procesamiento de logs y prompts
- Separación clara entre lógica y la interfaz

### `logs/`

Ejemplos de logs (`example_jenkins.log`) para pruebas y desarrollo

### `prompts/`

Plantillas que controlan el comportamiento y formato de la IA

### `requirements.txt`

Instala las dependencias necesarias:

```bash
pip install -r requirements.txt
```

Incluye: `openai`, `flask`, `requests`, etc.

### `Dockerfile`

Conteneriza la app (basada en Flask). Ideal para despliegue CI/CD, desarrollo local y entornos Kubernetes.

### `Makefile`

Automatiza construcción de imagen, etiquetado, carga a KIND, inyección de valores en Helm y sincronización con ArgoCD:

```bash
make release VERSION=v0.1.5
```

Esto ejecuta:
1. Construcción de la imagen Docker
2. Carga al clúster KIND
3. Actualización del `values.yaml` con la nueva etiqueta
4. Sincronización de la app ArgoCD
5. Confirmación de despliegue exitoso

También puedes ejecutar comandos por separado:

```bash
make build
make load
make update-values
make sync
```

---

## 🛠️ Primeros pasos

### 🔁 Clonar y configurar

```bash
git clone https://github.com/dorado-ai-devops/ai-log-analyzer-devops.git
cd ai-log-analyzer-devops
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### ⚙️ Ejecutar en CLI (modo OpenAI)

```bash
OPENAI_API_KEY=sk-xxx python3 cli/generate.py --mode openai --logfile logs/example_jenkins.log
```

### ⚙️ Ejecutar como microservicio REST (Flask)

```bash
python3 app.py
```

### 🔁 Ejecutar en Docker (servidor Flask)

```bash
docker build -t log-analyzer:dev .
docker run -p 5000:5000 log-analyzer:dev
```

---

## 💡 Ejemplo de salida

```text
Fallo detectado al conectar con el servicio de base de datos.
Causa: el servicio `db.example.local` no está disponible al arrancar.
Recomendación: revisar variable DB_HOST, políticas de red y estado del servicio. Considera usar reintentos con backoff.
```

---

## 🔮 Próximos pasos

- Añadir ejemplo de integración con Jenkins
- Añadir manifiestos de despliegue en Kubernetes
- Activar respuestas tokenizadas/streaming de LLMs

---

## 📸 Capturas *(próximamente)*

Incluirá ejemplos visuales de logs, salida por terminal y esquemas.

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
