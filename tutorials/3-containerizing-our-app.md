# Containerizing our app
## Introduction
Kubernetes is a container orchestration service, which means that we need to have our app running in a Docker container. In this section, we'll write a Dockerfile and learn how to build and tag it locally. Take a look at the `Dockerfile` in this respository for the complete example.

## Writing our Dockerfile
A Dockerfile can be thought as instructions to build an environment and then run an app within that environment.

Here's an example dockerfile from the [Docker Docs](https://docs.docker.com/get-started/part2/#define-a-container-with-dockerfile) that shows the various parts of a Dockerfile.

```dockerfile
# Use an official Python runtime as a parent image
FROM python:2.7-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]
```

Our Dockerfile is going to be quite similar. Basically we need to use a ruby base image, install our dependencies, set our working directory, expose a port, and run our app!

### Choosing our base image
We're going to use 2.3.7 as there is a nice base image on [Dockerhub](https://hub.docker.com/_/ruby/) that we can use. Dockerhub is a public repository of docker images and you can generally find one that suits your needs.

```dockerfile
FROM ruby:2.3.7
```

### Setting our working directory
We now need to set a working directory and move our app into that working directory.

```dockerfile
WORKDIR /app
ADD . /app
```

### Installing dependencies
Next we want to make sure that our environment has everything installed that we need in order to run our app. In this case, the Ruby image comes with a bunch of nice stuff installed so we only need to run `bundle install` to make sure that Sinatra is installed and ready to use.

```dockerfile
RUN cd /app && \
    bundle install
```

### Exposing a port
In order for outside services to talk to our container, we're going to need to expose an internal port to outside traffic. In this case, we're going to use the default Sinatra port `4567`

```dockerfile
EXPOSE 4567
```

### Giving our run command
Finally, we need to have our container actually run our Sinatra app. This part is pretty easy. We just tell it what `CMD` to run at start!

```dockerfile
CMD ["ruby", "web.rb"]
```

## Running our Docker image
### Build and tag our image
The first step is to build our Docker image. In order for this to work, you must have Docker for Mac running. We're going to run the following command.

`docker build . -t noobernetes:hello-world`

This command does a couple things:
- `.` tells it to use the Dockerfile and code in the current working directory
- `-t` tells it to tag that image for us
- `noobernetes` will become our repository, and `hello-world` is the tag that refers to this specific image. 

As you're iterating on Dockerfiles, you'll use tags to refer to distinct builds that you've run. For example, if we decided to change `web.rb` to return a different message, we would have to build and tag a new Docker image that has that code to run.
 
 Once you've run that code you should see some output like this:
 
```shell
> docker build . -t noobernetes:hello-world
Sending build context to Docker daemon    150kB
Step 1/6 : FROM ruby:2.3.7
2.3.7: Pulling from library/ruby
f2b6b4884fc8: Pull complete
4fb899b4df21: Pull complete
74eaa8be7221: Pull complete
2d6e98fe4040: Pull complete
638a4a258268: Pull complete
dc0287a58907: Pull complete
a8f7a36f204a: Pull complete
Digest: sha256:b06292ba3869fbad0e866e1486a47f212f02082c87171987d2b566ad17973fc7
Status: Downloaded newer image for ruby:2.3.7
 ---> 9cc35bb87070
Step 2/6 : WORKDIR /app
Removing intermediate container a70559af729f
 ---> 8f484e16c81a
Step 3/6 : ADD . /app
 ---> df108c3b90ae
Step 4/6 : RUN cd /app &&     bundle install
 ---> Running in 935eadaa4174
Fetching gem metadata from https://rubygems.org/.........
Using bundler 1.16.1
Fetching mustermann 1.0.2
Installing mustermann 1.0.2
Fetching rack 2.0.4
Installing rack 2.0.4
Fetching rack-protection 2.0.1
Installing rack-protection 2.0.1
Fetching tilt 2.0.8
Installing tilt 2.0.8
Fetching sinatra 2.0.1
Installing sinatra 2.0.1
Bundle complete! 1 Gemfile dependency, 6 gems now installed.
Bundled gems are installed into `/usr/local/bundle`
Removing intermediate container 935eadaa4174
 ---> aa6d3750c62c
Step 5/6 : EXPOSE 4567
 ---> Running in 62f04c00afb4
Removing intermediate container 62f04c00afb4
 ---> daba72b0dd37
Step 6/6 : CMD ["ruby", "web.rb"]
 ---> Running in d5a9e35d9c60
Removing intermediate container d5a9e35d9c60
 ---> 1df859131e95
Successfully built 1df859131e95
Successfully tagged noobernetes:hello-world
```

Essentially, this is Docker showing you what steps its running in the Dockerfile we created! 

### Finding the Docker Image
Sometimes you want to look at all the Docker images you have on your machine. In our case we just created one with the `hello-world` tag in the `noobernetes` respository. You can think of a repository as a group of images and an image as a snapshot of your code and configuration that can be run. 

`docker image ls`
```shell
> docker image ls
REPOSITORY                                                   TAG                                        IMAGE ID            CREATED             SIZE
noobernetes                                         hello-world                                2f879cec81b5        19 seconds ago      744MB
```

### Running our Docker image
Now lets run our Docker image and see it all in action!

`docker run -p 4000:4567 noobernetes:hello-world`

This command does a couple things:
- It will run our app! Specifically it will look for a Docker repository called `noobernetes` and run the image with the `hello-world` tag.
- `-p` indicates that we want port `4000` on our host machine, to point to port `4567` in our container. This is the port that we exposed earlier in this tutorial.

```shell
> docker run -p 4000:4567 noobernetes:hello-world
[2018-04-06 22:07:38] INFO  WEBrick 1.3.1
[2018-04-06 22:07:38] INFO  ruby 2.3.7 (2018-03-28) [x86_64-linux]
== Sinatra (v2.0.1) has taken the stage on 4567 for development with backup from WEBrick
[2018-04-06 22:07:38] INFO  WEBrick::HTTPServer#start: pid=1 port=4567
```

You should now be able to access the app at `localhost:4000`.

## Conclusion
We now know how to use Docker and Docker for Mac to build and run containers! In the next section, we're going to get those containers running on Kubernetes!

## Resources
- [Docker for Mac Documentation](https://docs.docker.com/docker-for-mac)
- [Docker Tutorial](https://docs.docker.com/get-started/)
- [Docker Hub](https://hub.docker.com)

---

Continue to [Deploying to Kubernetes](./4-deploying-to-kubernetes.md)
