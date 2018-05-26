# Horizontal Pod Autoscaling
## Introduction
One exciting feature of Kubernetes is the ability to horizontally scale a workload. For example, if you have one pod serving traffic and it's CPU usage begins to blow up, Kubernetes can automatically create more pods to handle work for you! In this section we're going to look at a horizontal pod autoscaler and watch as it scales our application.

## Prerequisites
- You should have the `noobernetes` deployment and service applied to your Kubernetes cluster

## Installing the `metrics-server`
The `metrics-server` provides information about the CPU and Memory Usage of containers running in your cluster. It is generally installed by default in most Kubernetes clusters, however with Docker for Mac we're going to have to install it ourselves.

First we'll need to clone the `metrics-server` repository.

```
git clone https://github.com/kubernetes-incubator/metrics-server
```

Next we'll need to apply the manifests for the `metrics-server` to our cluster.

```
> kubectl apply -f deploy/1.8+/
clusterrolebinding "metrics-server:system:auth-delegator" created
rolebinding "metrics-server-auth-reader" created
apiservice "v1beta1.metrics.k8s.io" created
serviceaccount "metrics-server" created
deployment "metrics-server" created
service "metrics-server" created
clusterrole "system:metrics-server" created
clusterrolebinding "system:metrics-server" created
```

The `metrics-server` will begin scraping our running containers for metrics.

## Writing our Horizontal Pod Autoscaler (HPA)
We will add a file called `horizontal-pod-autoscaler.yaml` for our HPA manifest.

```yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: noobernetes-hpa
spec:
  maxReplicas: 10
  minReplicas: 1
  scaleTargetRef:
    apiVersion: extensions/v1beta1
    kind: Deployment
    name: noobernetes-deployment
  targetCPUUtilizationPercentage: 50
```

We can now apply this to our cluster just like any other Kubernetes resource.

> kubectl apply -f applications/sinatra/manifests/horizontal-pod-autoscaler.yaml
horizontalpodautoscaler "noobernetes-hpa" created

Before we begin trying to scale our pods, we first must update our Deployment to specify its resource requests, which in our case will be based on CPU utilization. The CPU utilization for a resource request is added under `spec` for a deployment. Your deployment should now look as follows.

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
        resources:
          requests:
            cpu: 200m
      restartPolicy: Always
```

Now lets check out our HPA.

```
> kubectl get hpa
NAME                      REFERENCE                        TARGETS     MINPODS   MAXPODS   REPLICAS   AGE
noobernetes-hpa   Deployment/noobernetes-deployment        0% / 50%    1         10        1          1m
```
We can see that its targeting our deployment, and that CPU usage is currently at 0% of our 50% target that we specified earlier. It'll also let us know its current replica count and its minimum and maximum boundaries.

## Watch it scale!
We're now ready to see our HPA in action. We're going to use the `watch` command so that we can see it live!

Run each of these commands in a tab/pane of your terminal:

`watch kubectl get pods`

`watch kubectl get hpa`

This will refresh our view every 2 seconds so that we can follow along as Kubernetes scales our application.

## Generating load
Now that we've got our pods and hpa monitored we're ready to start generating some load on our server. 

For now, we're going to use the `kubectl run` command to spin up a box that we can interact with. We'll just do a loop in bash to hit our application over and over again. Run the following command in another pane or tab of your terminal:

```
> kubectl run -i --tty load-generator --image=busybox /bin/sh
If you don't see a command prompt, try pressing enter.
/ # while true; do wget -q -O- http://noobernetes-sinatra-service.default.svc.cluster.local:4000; done
```

It may take some time, but eventually you should see CPU usage climb and more pods get automatically spun up by the HPA.

## Conclusion
HPAs are powerful tools that let us automate scaling in our cluster. While scaling on CPU is helpful Kubernetes 1.10 supports the ability to scale on custom and external metrics. Check out some of the resources for more information on how to implement different scaling metrics.

## Resources
- [Horizontal Pod Autoscaler Walkthrough](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
- [Support For Custom Metrics](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-custom-metrics)
