import argparse
from lib.input_loader import load_log

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Analizador de logs local")
    parser.add_argument("--logfile", required=True, help="Ruta del archivo de logs a analizar")
    args = parser.parse_args()

    log_data = load_log(args.logfile)
    print("----- CONTENIDO DEL LOG -----")
    print(log_data)
