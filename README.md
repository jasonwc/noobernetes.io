## Welcome!
This site is for application developers new to the world of Kubernetes that want to explore some of its concepts. There are plenty of great guides out there for cluster operators, so this guide focuses on getting a brand new developer spun up on Kubernetes concepts and seeing it in action. Currently, this repo covers:

- Docker basics: building and interacting with docker images
- Kubernetes basics: writing Deployments and Services and interacting with a Kubernetes cluster
- Horizontal Pod Autoscaling: using Kubernetes to scale a deployment based on CPU usage

## How to use
Each tutorial contains all the code required for that section, and lists any dependencies from previous tutorials. If you want to write the code yourself, go for it! If you'd rather skip to the end, all the required application code and manifests are included in the `applications` directory. Simply clone the repository and you're off to the races!

## Tutorials
- [Setting up Docker and Kubernetes](./tutorials/1-setting-up-docker-and-kubernetes.md)
- [Writing a simple app](./tutorials/2-writing-a-simple-app.md)
- [Containerizing our app](./tutorials/3-containerizing-our-app.md)
- [Deploying to Kubernetes](./tutorials/4-deploying-to-kubernetes.md)
- [Horizontal Pod Autoscaling](./tutorials/5-horizontal-auto-scaling.md)

## About
These tutorials were made as I was trying to learn Kubernetes for use at [Mavenlink](https://www.mavenlink.com) and as an example for a talk given to the [Women Level Up](http://womenlevelup.com/) meetup. I hope to add more to it as I continue to explore Kubernetes. PRs welcome!


## Thanks
To my coworkers at Mavenlink for using this tutorial and helping improve it!

## License
MIT
