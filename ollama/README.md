# docker-compose.yml 

Configuration for running locally Ollama, Open-WebUI, qwen2.5-coder-7b, and nomic-embed-text.

Includes configuration for integrating the qwen2.5.coder:7b model into visual studio code using the ```continue``` extension by ```continue.dev```

## Overview 
This `docker-compose.yml` file is designed to set up a containerized environment for running Ollama, the Open-WebUI frontend, and additional models required by the ```continue``` by ```continue.dev``` visual studio code extension. The configuration ensures that all services are connected properly and can communicate with each other.

You can use it to replace github copilot in vscode or use it on your desktop using the open web ui frontend that runs by default on localhost:3000

Modify as needed.

## Services

### ollama
- **Image:** `ollama/ollama:latest`
- **Container Name:** `ollama`
- **Restart Policy:** `unless-stopped`
- **Ports:**
  - `11434:11434` (Map the host port 11434 to the container port 11434)
- **Volumes:**
  - `ollama:/root/.ollama` (Mounts a volume for persisting Ollama data)
- **Resources:**
  - **GPUs:** Uses all available NVIDIA GPUs

### open-webui
- **Image:** `ghcr.io/open-webui/open-webui:main`
- **Container Name:** `open-webui`
- **Restart Policy:** `unless-stopped`
- **Ports:**
  - `3000:8080` (Map the host port 3000 to the container port 8080)
- **Volumes:**
  - `open-webui:/app/backend/data` (Mounts a volume for persisting Open-WebUI data)
- **Environment Variables:**
  - `OLLAMA_BASE_URL=http://ollama:11434` (Sets the base URL for Ollama service)
- **Depends On:**
  - The `ollama` service must be up and running before this service can start

### qwen2.5-coder-7b
- **Description:** The coding ai model, utilised by the vscode extension.
- **Installation:** Can be installed manually in the container or through the Open-WebUI interface.

### nomic-embed-text
- **Description:** Emeddings model, utilised by vscode extension.
- **Installation:** Can be installed manually in the container or through the Open-WebUI interface.

## Volumes
- `ollama`: Volume to persist Ollama data
- `open-webui`: Volume to persist Open-WebUI data

## Usage 
To run the services defined in this `docker-compose.yml` file, execute the following command in the directory containing the file:
```docker-compose up -d ```
This will start both the Ollama and Open-WebUI services in detached mode. You can then access Open-WebUI by navigating to `http://localhost:3000` in your web browser.


### Installing Models For manual installation of the required models (`qwen2.5-coder-7b` and `nomic-embed-text`) in the container, follow these steps:
1. Start both services using `docker-compose up -d`.
2. Access Open-WebUI by navigating to `http://localhost:3000` (or `http://host.docker.internal:3000` on Windows).
3. Navigate to the model management section within Open-WebUI.
4. Search for and install the required models.

For automated installation through Open-WebUI, ensure that the models are specified in the configuration or can be detected automatically by Open-WebUI during startup.

### VSCode Continue extension config.yaml:

If host docker.internal doesnt work replace with the actual IP address or localhost.

```yaml
---
name: Local Config
version: 1.0.0
schema: v1
models:
  - name: qwen2.5-coder-7b
    provider: ollama
    model: qwen2.5-coder:7b
    apiBase: http://host.docker.internal:11434
    roles:
      - chat
      - autocomplete  # Enables inline Tab completion
      - edit

  - name: nomic-embed
    provider: ollama
    model: nomic-embed-text
    apiBase: http://host.docker.internal:11434
    roles:
      - embed  # Embeddings for @codebase

```

NB: Remember to download qwen2.5-coder-7b and nomic-embed-text models in Ollama