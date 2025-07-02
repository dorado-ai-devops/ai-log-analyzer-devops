# cli/generate.py

import argparse
from lib.docgen import generate_documentation
from lib.input_loader import load_log

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Analizador de logs con IA (OpenAI u Ollama)")
    parser.add_argument("--mode", choices=["openai", "ollama"], default="openai", help="Modo de ejecución: openai u ollama")
    parser.add_argument("--logfile", required=True, help="Ruta del archivo de logs a analizar")
    args = parser.parse_args()

    log_data = load_log(args.logfile)
    print("----- CONTENIDO DEL LOG -----")
    print(log_data)

    generate_documentation(args.mode, args.logfile)
