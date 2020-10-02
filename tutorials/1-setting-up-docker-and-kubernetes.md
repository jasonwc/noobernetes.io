# Setting up Docker and Kubernetes
## Introduction
Before we get started, we're going to set up a local Kubernetes cluster and Docker daemon so that we can build docker images and deploy them to a cluster. We're going to use Docker's desktop application as its the simplest way to get up and running.

## Mac
### Installing Docker for Mac
1) Visit the [Docker store](https://store.docker.com/editions/community/docker-ce-desktop-mac)

2) Click `Get Stable` and install it.

### Enabling Kubernetes
1) Click on Docker for Desktop in the menu bar, go to _Preferences_ -> _Kubernetes_ and click _Enable Kubernetes_ and _Apply & Restart_

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
_Coming soon_

## Linux
_Coming soon_

## Conclusion
You now have everything you need to start playing around with Docker and Kubernetes!

## Resources
- [Get started with Docker for Mac](https://docs.docker.com/docker-for-mac/)

---

Continue to [Writing a simple app](./2-writing-a-simple-app.md)
