# Modelfiles

This repository contains a personal collection of model files that have been used during my LLM experimentation. 

## Ollama
For my use case, I create and use the models using [Ollama](https://ollama.com/).
To have access via different tools in the `Ollama` server, open `Ollama` configuration:
```bash
sudo vim /etc/systemd/system/ollama.service
```
Then, add the following line:
```
Environment="OLLAMA_HOST=0.0.0.0:11434"
```

Then restart `Ollama`
```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```
Make sure that your firewall accepts requests there
```bash
# E.g. for Ubuntu/Debian based Distributions
sudo ufw allow 11434
```

## Open WebUI
[Open WebUI](https://openwebui.com/) is also used to provide a graphical interface for interacting with the models. 

### Installation using Docker - CPU utilization
```bash
docker run -d \
	-p 3000:8080 \
	--add-host=host.docker.internal:host-gateway \
	-v open-webui:/app/backend/data \
	--restart always \
	ghcr.io/open-webui/open-webui:main
```

### Installation using Docker - (NVIDIA) GPU utilization
> [!WARNING]
> In order to work:
> 1. Configure the repository:
> ```
> curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey |sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
> && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
> && sudo apt-get update
> ```
> 
> 2. Install the NVIDIA Container Toolkit packages:
> ```
> sudo apt-get install -y nvidia-container-toolkit
> ```
> 3. Configure the container runtime by using the nvidia-ctk command:
> ```
> sudo nvidia-ctk runtime configure --runtime=docker
> ```
> 4. Restart the Docker daemon:
> ```
> sudo systemctl restart docker
> ```

Now we are ready to start the container
```
docker run -d \
	-p 3001:8080 \
	--gpus all \
	--add-host=host.docker.internal:host-gateway \
	-v open-webui:/app/backend/data \
 	--restart always \
	ghcr.io/open-webui/open-webui:cuda
```

## `Continue` a VS-Code extension
Finally, since VS-Code is one of my go-to editors for development, I also use [Continue](https://docs.continue.dev/getting-started/overview/) VS-Code extension to interact with the models from there.

## Goal
This setup can ensure the deployment of LLMs locally on proprietary servers, which may be a mandatory security constraint for some applications or development of tools.
