from lib.input_loader import load_log
from lib.openai_client import OpenAIClient
from lib.ollama_client import OllamaClient
from lib.utils import load_prompt
import os

def generate_documentation(mode, logfile):
    log_content = load_log(logfile)
    prompt_template = load_prompt("log_analysis")
    prompt = prompt_template.replace("${LOG_CONTENT}", log_content)

    if mode == "openai":
        client = OpenAIClient(api_key=os.getenv("OPENAI_API_KEY"))
    else:
        client = OllamaClient(model=os.getenv("OLLAMA_MODEL", "mistral:latest"))

    result = client.generate_completion(prompt)
    print("\n--- Análisis generado ---\n")
    print(result)
