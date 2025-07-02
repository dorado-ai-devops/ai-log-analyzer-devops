# lib/ollama_client.py
import requests
import os
class OllamaClient:
    def __init__(self, model="llama3"):
        self.model = model
        self.base_url = os.getenv("OLLAMA_BASE_URL", "http://localhost:11434")

    def generate_completion(self, prompt):
        response = requests.post(f"{self.base_url}/api/generate", json={
            "model": self.model,
            "prompt": prompt,
            "stream": False
        })
        response.raise_for_status()
        return response.json()["response"]
