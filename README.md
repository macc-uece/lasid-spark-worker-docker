# LASID Spark Worker Docker Image
Create Spark Mesos Worker image on Docker for LASID/UECE Cluster

# Introduction

Git clone to start.

```
$ git clone https://github.com/macc-uece/lasid-spark-worker-docker.git
$ cd lasid-spark-worker-docker/
```

Build the Docker image and push to DockerHub

```
$ ./build-images.sh <Spark version>
```
Where <Spark version> should be "2" ou "3". The release should be changed in build-images.sh script.

Check the images created:

```
$ docker images
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
lasid/spark-worker   latest              7a90258317e2        19 hours ago        614MB
lasid/spark-base     latest              00550f6beb50        19 hours ago        614MB
ubuntu               bionic              ccc6e87d482b        8 days ago          64.2MB
```
