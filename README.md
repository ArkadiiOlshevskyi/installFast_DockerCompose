# Install fast Docker and DockerCompose

1) create new "file.sh" or copy "install_docker_and_compose.sh" from repo to your VM

2) make file executable
```
chmod +x install_docker_and_compose.sh
```

3) run it
```
./install_docker_and_compose.sh
```


# If you want to limit your docker in producing logs do next:
In production streaming situations when you have tons of logs produsing they can consumnt your harddrive space on VM


1) Create or edit settings file
```
sudo nano /etc/docker/daemon.json

```

2) insert this in file
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  }
}

3) restart docker
```
sudo systemctl restart docker
```


# Use this docker compose file with kafka for tests

1) Also use kcat utility to test yopur kafka broker connectivity
```
sudo apt install kcat
```