#!/bin/bash

# Define ruta absoluta del proyecto
PROJECT_ROOT="/root/devops-ai/ai-log-analyzer-devops"

# Nos aseguramos de estar en el directorio del proyecto
cd "$PROJECT_ROOT" || {
  echo "❌ No se puede acceder a $PROJECT_ROOT"
  exit 1
}

# Exporta el PYTHONPATH correctamente (a ruta absoluta)
export PYTHONPATH="$PROJECT_ROOT"

# Modo de ejecución: openai u ollama
MODE=${1:-openai}
LOG_FILE="logs/example_jenkins.log"

# Activa el entorno virtual si existe
if [ -f "../venv/bin/activate" ]; then
  source ../venv/bin/activate
fi

# Ejecuta el script
python3 cli/generate.py --mode "$MODE" --logfile "$LOG_FILE"
