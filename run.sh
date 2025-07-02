#!/bin/bash
#RUN AI Log Analyzer

export PYTHONPATH=$(pwd)

source ../venv/bin/activate

python3 /root/devops-ai/ai-log-analyzer-devops/cli/generate.py --mode openai --logfile logs/example_jenkins.log
