#!/bin/bash

#################################################################

## shell script to build and push docker images to local registry   

#################################################################


DIR=/Users/jricher/Projects/Joe-test-project
VERSION=$(sudo docker images | awk '{print $2}' | awk 'NR==2')
REGISTRY=localhost:5000

#Helper function to increment the version number passed in by user. 

function increment_ver() {
    while getopts ":Mmp" Option
    do
      case $Option in
        M ) major=true;;
        m ) minor=true;;
        p ) patch=true;;
      esac
    done     

    shift $(($OPTIND - 1))

    version=$1

    # Build array

    a=( ${version//./ } )

    if [ ${#a[@]} -ne 3 ]
    then
      echo "usage: $(basename $0) [-Mmp] major.minor.patch"
      exit 1
    fi

    # Increment version numbers

    if [ ! -z $major ]
    then
      ((a[0]++))
      a[1]=0
      a[2]=0
    fi

    if [ ! -z $minor ]
    then
      ((a[1]++))
      a[2]=0
    fi

    if [ ! -z $patch ]
    then
      ((a[2]++))
    fi

    echo "${a[0]}.${a[1]}.${a[2]}"
}

level=$1
num=$2

if [ $# -eq 0 ]; then
 echo "No arguments given, provide level of release and current version. Example: ./buildandpush.sh -p 1.1.1"
 exit 1
fi

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

VER=$(increment_ver $level $num) 

while true; do

read -p "The next version selected is $VER. Do you want to proceed? (y/n) " yn

case $yn in 
    [yY] ) echo ok, begin docker build;
        break;;
    [nN] ) echo exiting...;
        exit;;
    * ) echo invalid response;
        exit 1;;
esac

done

echo "Build the docker image in the current directory"
result=$(sudo docker build -t $REGISTRY/hello:$VER .) 

if [ $? -eq 0 ]; then
   echo "Docker build was OK, new image is: $REGISTRY/hello:$VER"
else
   echo "Docker build failed, exiting"
   exit 1 
fi

echo "Pushing new docker image to local registry: $REGISTRY"
result=$(sudo docker push $REGISTRY/hello:$VER) 
if [ $? -eq 0 ]; then
   echo "Docker push was OK"
else
   echo "Docker push failed, exiting"
   exit 1 
fi
