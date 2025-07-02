# 🧠 ai-log-analyzer-devops

> Un analizador de logs potenciado por IA que procesa registros de entornos DevOps (como Jenkins o Kubernetes) y ofrece diagnósticos inteligentes y recomendaciones usando LLMs como GPT-4o (OpenAI) o modelos locales mediante Ollama (LLaMA3, Phi-3, etc).

&#x20;&#x20;

---

## 🚀 Características

- 🔍 Analiza logs de pipelines CI/CD (Jenkins, Helm, Kubernetes)
- 🤖 Potenciado por OpenAI GPT-4o o modelos locales mediante Ollama
- 📦 Herramienta CLI sencilla, lista para Docker
- ✍️ Prompts modulares y editables
- 📁 Funciona completamente online o en modo offline

---

## 📦 Estructura del Proyecto

```
ai-log-analyzer-devops/
├── cli/                    # Interfaz de línea de comandos
├── lib/                    # Lógica principal y clientes de IA
├── logs/                   # Logs de ejemplo para pruebas
├── prompts/                # Plantillas de prompt para LLMs
├── requirements.txt        # Dependencias de Python
├── Dockerfile              # Docker para despliegue containerizado
└── README.md               # Documentación del proyecto
```

---

## 🧩 Descripción detallada de los componentes

### `cli/`

Contiene los scripts ejecutables desde terminal. Por ahora, `generate.py` es el script principal que:

- Lee un archivo de log
- Llama a un LLM según el modo (`openai` u `ollama`)
- Usa la plantilla de prompt adecuada desde `prompts/`
- Muestra el resultado por pantalla

### `lib/`

Contiene el código central reutilizable:

- Clientes de OpenAI y Ollama
- Funciones para cargar logs, estructurar prompts y procesar la respuesta del modelo
- Esta capa separa la interfaz CLI de la lógica interna, facilitando testeo y reusabilidad

### `logs/`

Contiene archivos `.log` de ejemplo, como `example_jenkins.log`, utilizados para pruebas y desarrollo.

### `prompts/`

Define las instrucciones o "templates" que se le pasarán al LLM. Modularizar los prompts permite:

- Cambiar el estilo de salida
- Ajustar el comportamiento del modelo
- Separar la logica de negocio del contenido IA

### `requirements.txt`

Lista de dependencias necesarias. Incluye bibliotecas como `openai`, `requests`, etc. Se instala con:

```bash
pip install -r requirements.txt
```

### `Dockerfile`

Permite contenerizar toda la aplicación. Ideal para despliegue en entornos CI/CD o en servidores offline con Ollama.

---

## 🛠️ Primeros pasos

### 🔁 Clonación y configuración

```bash
git clone https://github.com/dorado-ai-devops/ai-log-analyzer-devops.git
cd ai-log-analyzer-devops
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### ⚙️ Ejecución (modo OpenAI)

```bash
OPENAI_API_KEY=sk-xxx \
python3 cli/generate.py --mode openai --logfile logs/example_jenkins.log
```

### ⚙️ Ejecución (modo local con Ollama)

```bash
ollama run llama3
python3 cli/generate.py --mode ollama --logfile logs/example_jenkins.log
```

---

## 💡 Ejemplo de salida

```text
Fallo detectado al conectar con el servicio de base de datos.
Causa: servicio `db.example.local` inalcanzable durante el arranque.
Recomendación: revisa la variable de entorno DB_HOST, las network policies y el estado del servicio. Considera aplicar reintentos con backoff.
```

---

## 🔮 Siguientes pasos

-

---

## 📸 Capturas *(próximamente)*

Se incluirán ejemplos visuales de logs, salida de terminal y esquemas.

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

