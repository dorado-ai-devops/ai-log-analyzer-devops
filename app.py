from flask import Flask, request, jsonify
import subprocess
import tempfile
import os
import sys

app = Flask(__name__)

@app.route("/analyze", methods=["POST"])
def analyze():
    data = request.get_json()
    log_content = data.get("log", "")

    if not log_content:
        return jsonify({"error": "Missing 'log' in request"}), 400

    # Crear un archivo temporal para simular el logfile
    with tempfile.NamedTemporaryFile(delete=False, mode="w", suffix=".log") as temp_log:
        temp_log.write(log_content)
        temp_log_path = temp_log.name

    try:
        # Ejecutar el CLI con el archivo temporal como argumento
        result = subprocess.run(
            ["python3", "cli/generate.py", "--mode", "openai", "--logfile", temp_log_path],
            capture_output=True,
            text=True,
            env={**os.environ, "PYTHONPATH": "."}
        )
        os.unlink(temp_log_path)  # Eliminar archivo temporal

        if result.returncode != 0:
            return jsonify({"error": result.stderr.strip()}), 500

        return jsonify({"result": result.stdout.strip()})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
