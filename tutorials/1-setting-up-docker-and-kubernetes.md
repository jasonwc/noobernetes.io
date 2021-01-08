# Setting up Docker and Kubernetes
## Introduction
Before we get started, we're going to set up a local Kubernetes cluster and Docker daemon so that we can build docker images and deploy them to a cluster. We're going to use Docker's desktop application as its the simplest way to get up and running.

## Mac
### Installing Docker for Mac
1) Visit the [Docker Desktop homepage](https://www.docker.com/products/docker-desktop).

2) Click `Download for Mac (Stable)` and install it.

### Enabling Kubernetes

**NOTE**: If you've ever exported a Kubernetes path, you'll have to combine that path with the path that Kubernetes expects the default config file to live at: `~/.kube/config` using a `:` between each path:

`export KUBECONFIG=<path-to-default-config.yaml>:<path-to-another-config.yaml>`

1) Click on Docker for Desktop in the menu bar, go to _Preferences_ -> _Kubernetes_ and click _Enable Kubernetes_. Click _show system containers (advanced)_, and _Apply & Restart_

2) Once Docker has completed installing Kubernetes you can test that it is working by using `kubectl`:

```
# Check that Kubernetes is running
> kubectl get nodes
NAME                 STATUS    ROLES     AGE       VERSION
docker-for-desktop   Ready     master    3d        v1.9.6

# Check that Docker is running
> docker -v
Docker version 18.05.0-ce, build f150324
```

## Windows
### Installing Docker for Windows
1) Ensure you are [ready to install](https://docs.docker.com/docker-for-windows/troubleshoot/#virtualization) Docker Desktop.

2) Visit the [Docker Desktop homepage](https://www.docker.com/products/docker-desktop).

3) Click `Download for Windows (Stable)` and install it.

  - When you first run docker it's possible that you'll have to install the [Linux Kernel for Windows](https://docs.microsoft.com/en-us/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package). You are not required to do anything beyond installing the kernel and use powershell to set `wsl` version to **2**.

4) Launch Docker Desktop.

### Enabling Kubernetes
1) Click the settings icon, then _Kubernetes_ and click _Enable Kubernetes_. Click _show system containers (advanced)_, and _Apply & Restart_

2) Once Kubernetes is active you should see that _Docker_ and _Kubernetes_ are active in the Docker Desktop application window.

## Linux
_Coming soon_

## Conclusion
You now have everything you need to start playing around with Docker and Kubernetes!

## Resources
- [Get started with Docker for Mac](https://docs.docker.com/docker-for-mac/)

---

Continue to [Writing a simple app](./2-writing-a-simple-app.md)
