# Devenv

This project acts as simple boilerplate for container development.

## Quickstart
You need to supply `/home/dev/.ssh/authorized_keys` as a secret. You can do this via `docker-compose`.

### Docker Compose
```
services:
  devenv:
    build: github.com/jackkoavar/devenv
    secrets:
      - source: devenv_key
        target: /home/dev/.ssh/authorized_keys
secrets:
  devenv_key:
    file: /path/to/devenv_key
```

## Usage

Generate a ssh key to attach to your container
```
ssh-keygen -t rsa -b 4096 -f /path/to/devenv_key
```

Include this project in your `docker-compose.yml` file

```
services:
  devenv:
    build: github.com/jackkoavar/devenv
    secrets:
      - source: devenv_key
        target: /home/dev/.ssh/authorized_keys
secrets:
  devenv_key:
    file: /path/to/devenv_key
```

## Futher modifications
Use secrets to add to the container's capabilities.
- authorized_keys to /home/dev/.ssh for login
- additional startup scripts to /etc/profile.d