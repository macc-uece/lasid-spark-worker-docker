#!/bin/bash
#
# Download docker image in all servers

ssh -tt stack@lasid10 "docker pull lasid/spark-worker"
ssh -tt stack@lasid30 "docker pull lasid/spark-worker"
ssh -tt stack@lasid40 "docker pull lasid/spark-worker"
ssh -tt stack@lasid50 "docker pull lasid/spark-worker"
ssh -tt stack@lasid60 "docker pull lasid/spark-worker"
ssh -tt stack@lasid70 "docker pull lasid/spark-worker"
ssh -tt stack@lasid10 "docker pull lasid/spark-worker-tensorflow"
ssh -tt stack@lasid30 "docker pull lasid/spark-worker-tensorflow"
ssh -tt stack@lasid40 "docker pull lasid/spark-worker-tensorflow"
ssh -tt stack@lasid50 "docker pull lasid/spark-worker-tensorflow"
ssh -tt stack@lasid60 "docker pull lasid/spark-worker-tensorflow"
ssh -tt stack@lasid70 "docker pull lasid/spark-worker-tensorflow"
ssh -tt stack@lasid10 "docker pull lasid/tensorflow-worker-tos"
ssh -tt stack@lasid30 "docker pull lasid/tensorflow-worker-tos"
ssh -tt stack@lasid40 "docker pull lasid/tensorflow-worker-tos"
ssh -tt stack@lasid50 "docker pull lasid/tensorflow-worker-tos"
ssh -tt stack@lasid60 "docker pull lasid/tensorflow-worker-tos"
ssh -tt stack@lasid70 "docker pull lasid/tensorflow-worker-tos"
