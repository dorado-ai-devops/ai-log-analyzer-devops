# lib/utils.py

def load_prompt(name):
    file_path = f"prompts/{name}.prompt"
    with open(file_path, 'r') as f:
        return f.read()
