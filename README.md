# LASID Spark Worker Docker Image
Create Spark Mesos Worker image on Docker for LASID/UECE Cluster

# Intruction

Git clone to start.

```
git clone https://github.com/macc-uece/lasid-spark-worker-docker.git
```

Build the Docker image

```
$ docker images
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
lasid/spark-worker   latest              7a90258317e2        19 hours ago        614MB
lasid/spark-base     latest              00550f6beb50        19 hours ago        614MB
ubuntu               bionic              ccc6e87d482b        8 days ago          64.2MB
```
Get the IMAGE ID of the desired image and Tag it. In this case we tag the version number *v1* and the tag *latest* to set the default image.

```
$ docker tag 7a90258317e2 lasid/spark-worker:v1
$ docker tag 7a90258317e2 lasid/spark-worker:latest
```

Then push it to Docker Hub:

```
$ docker login
$ docker push lasid/spark-worker:v1
$ docker push lasid/spark-worker:latest
```
