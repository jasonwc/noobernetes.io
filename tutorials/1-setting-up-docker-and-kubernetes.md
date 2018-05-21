# Setting up Docker and Kubernetes
## Introduction
Before we get started, we're going to set up a local Kubernetes cluster and Docker daemon so that we can build docker images and deploy them to a cluster. We're going to use Docker's desktop application as its the simplest way to get up and running.

### Installing Docker for Mac
1) Visit the [Docker store](https://store.docker.com/editions/community/docker-ce-desktop-mac)

2) Click `Get Docker CE for Mac (Edge)`. This version ships with experimental Kubernetes support.

3) Install it!

4) Once it has finished installing, go to preferences and click on `Kubernetes`. Then select the `Enable Kubernetes` checkbox.

5) Once Docker has completed installing Kubernetes you can test that it is working by running the following in a terminal of your choice:

``` 
# Check that Kubernetes is running
> kubectl get nodes
NAME                 STATUS    ROLES     AGE       VERSION
docker-for-desktop   Ready     master    3d        v1.9.6

# Check that Docker is running
> docker -v
Docker version 18.05.0-ce, build f150324
```

## Conclusion
You now have everything you need to start playing around with Docker and Kubernetes!

## Resources
- [Get started with Docker for Mac](https://docs.docker.com/docker-for-mac/)

---

Continue to [Writing a simple app](./2-writing-a-simple-app)
