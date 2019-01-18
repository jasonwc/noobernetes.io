# Deploying to Kubernetes

## Introduction
Now that we have our Dockerfile, we can use it to deploy our application with Kubernetes. In this tutorial, we'll learn about Deployments, Kubernetes manifests, and how to apply these manifests to our local Kubernetes cluster. Once we've done that, we'll expose a service for our deployment so that we can view it in the browser.

## Prerequisites
- You should have completed `1-setting-up-docker-and-kubernetes`

### Writing a Kubernetes Deployment
Kubernetes uses yaml files to define the configuration of the app that you are running. In this case, we need to write a manifest that deploys our application and runs our container.

### What's in a manifest?
A manifest contains a description of the resource you wish to deploy. In this case we are creating a Deployment that will run a pod with the container we made previously. To start, create a folder called `manifests` in your current application folder. Within `manifests`, create a file called `deployment.yaml`.

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: noobernetes-deployment
spec:
  replicas: 1
  template:
    metadata:
      name: noobernetes
      labels:
        service: noobernetes
    spec:
      containers:
      - name: noobernetes-container
        image: noobernetes:hello-world
      restartPolicy: Always

```

There are a few things to call out here:
- We've made a deployment and under `metadata` we've added a name for our deployment.
- We're using the `extensions/v1beta1` as our `apiVersion`
- Under `spec` we've defined what our deployment should look like
  - We want it to have 1 `replica`, or one copy of the deployment. We could add more if we so chose.
  - We're providing some `metadata` about the deployment and we're telling it where to find the image that we pushed earlier.

### Deploying to Kubernetes in Docker for Mac
Deploying to Kubernetes is pretty easy. You simply apply the manifest to your cluster and have kubernetes do the rest.

```shell
> kubectl apply -f manifests/deployment.yaml
Using docker VM
deployment "noobernetes" created
```

Your app is now deployed!

### Interacting with our application
Now that its deployed, here are a few things we can do to interact with it: 

```
# returns back a list of pods
kubectl get pods

# returns back a list of pods in all namespaces. You'll notice some other pods here that are part of the Kubernetes cluster itself or part of our networking with Nginx
kubectl get pods --all-namespaces

# gets the logs for the pod specified
kubectl logs -f <pod_name>

# returns back information about the pods lifecycle and configuration
kubectl describe pod <pod_name> 

# Get a bash shell in a pod
kubectl exec -it <your_pod> bash

# Delete your deployment
kubectl delete deployment <your_app_name>
```
### Exposing your app locally
So we can now see that our pod is running. Like before with Docker, we need to make set it up so that we can access it on our host machine.

`kubectl expose deployment noobernetes-deployment --port=4000 --target-port=4567 --type=LoadBalancer --name=noobernetes-service`

You should see some output like this:

```shell
> kubectl expose deployment noobernetes --port=4000 --target-port=4567 --type=LoadBalancer --name=noobernetes-service
Using docker VM
service "noobernetes-service" exposed
```

We've defined a Service, which can be thought of as a way to control access to a deployment or pod. As the actual running container changes (if it dies, or is restarted) the service is responsible for always allowing us to route traffic within our cluster to the correct pods.

Our service says that we want to expose our app on localhost:4000, pointing to the 4567 port of the running container.

`kubectl get services noobernetes-service`

```shell
> kubectl get services my-service
Using docker VM
NAME                           TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
noobernetes-service   LoadBalancer   10.106.51.138   localhost     4000:31347/TCP   47m
```

This tells us that its mapped localhost to the cluster-ip of our running container. Visit localhost:4000 and view your app!

### Writing a Service manifest
Of course it would be a pain to have to remember to `expose` our deployment each time, so we're going to write a manifest `service.yaml` so that we can setup our service with the `kubectl` interface.

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    service: noobernetes
  name: noobernetes
spec:
  type: NodePort
  ports:
  - name: noobernetes
    port: 4000
    protocol: TCP
    targetPort: 4567
    nodePort: 30000
  selector:
    service: noobernetes
```

This will allow us to access our application at `localhost:30000` after running the command `kubectl apply -f service.yaml` from within the `manifests` folder.

## Conclusion
We now have our application running locally in Kubernetes! In the next section, we're going to configure our application to scale with CPU usage.

## Resources
- [Kubernetes Concepts](https://kubernetes.io/docs/concepts/)
- [Kubernetes Tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
- [The Childrens Illustrated Guide to Kubernetes](https://deis.com/blog/2016/kubernetes-illustrated-guide/)

---

Continue to [Horizontal Auto Scaling](./5-horizontal-auto-scaling.md)
