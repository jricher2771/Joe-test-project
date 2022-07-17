#!/bin/bash

#################################################################

## shell script to build and push docker images to local registry   

#################################################################


DIR=/Users/jricher/Projects/Joe-test-project
FILE=/Users/jricher/Projects/Joe-test-project
VERSION=$(sudo docker images | awk '{print $2}' | awk 'NR==2')
NEXTVERSION=$(echo ${VERSION} | awk -F. -v OFS=. '{$NF=$NF+1;print}')
REGISTRY=localhost:5000

echo "Start"
echo "Check build directory exists"
if [ -d "$DIR" ];
then
printf '%s\n' "It exists! Hello directory: ($DIR)"
else
printf "something else"
fi

result=$( sudo docker images -q localhost:5000/hello)
echo "Check for images in registry"

if [[ -n "$result" ]]; then
echo "images exist"
else 
echo "No images on local registry, check it's running"
exit 1 
fi 

echo "Get the current image tag"
result=$(docker images | awk '{print $2}' | awk 'NR==2')
if [[ -n "$result" ]]; then
echo "The current image tag: $result"
else
echo "Something went wrong with the current tag, exiting"
exit 1
fi

echo "The next version will be $NEXTVERSION"

TAG=$(echo "$NEXTVERSION")

echo "Build the docker image in the current directory"
result=$(sudo docker build -t $REGISTRY/hello:$(echo $TAG) .) 

if [ $? -eq 0 ]; then
   echo "Docker build was OK, new image is: $REGISTRY/hello:$(echo $TAG)"
else
   echo "Docker build failed, exiting"
   exit 1 
fi

echo "Pushing new docker image to local registry: $REGISTRY"
result=$(sudo docker push $REGISTRY/hello:$NEXTVERSION) 
if [ $? -eq 0 ]; then
   echo "Docker push was OK"
else
   echo "Docker push failed, exiting"
   exit 1 
fi
