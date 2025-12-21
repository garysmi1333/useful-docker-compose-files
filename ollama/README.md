## Overview 
This `docker-compose.yml` file is designed to set up a containerized environment for running Ollama.

You can use it to replace github copilot in vscode by installing the```Continue``` by ```continue.dev``` extension and/or use it on your desktop using the Open-WebUI application.

A configuration for the ```Continue``` extension in visual studio code is included.

Required ollama models for the example configuration
  - qwen2.5-coder:7b-instruct-q5_K_M
  - nomic-embed-text

Modify as needed ```docker-compose.yml``` as needed to fit your use case.

## Services

### ollama
- **Image:** `ollama/ollama:latest`
- **Container Name:** `ollama`
- **Restart Policy:** `unless-stopped`
- **Ports:**
  - `11434:11434` (Map the host port 11434 to the container port 11434)
- **Volumes:**
  - `./ollama:/root/.ollama` (Mounts a volume for persisting Ollama data using a bind mount)
- **Resources:**
  - **GPUs:** Uses all available NVIDIA GPUs


## Usage 
To run the services defined in this `docker-compose.yml` file, execute the following command in the directory containing the file:

```docker-compose up -d ```

This will start both the Ollama service in detached mode.


**Note:** Remember to download the `qwen2.5-coder:7b-instruct-q5_K_M` and `nomic-embed-text` models from the Ollama repository or any other source.