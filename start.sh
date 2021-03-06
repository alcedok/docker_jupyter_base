#!/usr/bin/env bash

# Terminate if there's an input error
set -e

# Make sure there are the current number of inputs
nargs="$#"
# If there are no arguments display options
if [ ${nargs} -ne 1 ]; then
	echo "bash start.sh [option] <command>"
	echo "error: incorrect number of commands"
	echo "use -h to see available commands"
	exit 1
fi 

# if help (-h) flag is an input
while getopts ":h" opt; do
	case ${opt} in 
		h)
		echo "commands:"
		echo "	local"
		echo "	pull"
		echo "	ssh"
		exit 1
			;;
		*) 
		echo "invalid option: -${OPTARG}"
		exit 1
		;;
	esac
done


# Case statement given command
args=("$@")
command=${args[0]}

case ${command} in 

	# Run from local build
	local)
	echo "Run from local build"
	docker run -p 8888:8888  -d -v $PWD/notebooks:/home/tyrell_wellick/notebooks/ jupyter_base:latest
	;;
	# Run from cloud build
	pull)
	echo "Pull from DockerHub and run"
	echo "Oh wait...This feature is not ready yet, sorry" 
	;;
	ssh)
	echo "ssh into machine"
	image_name=$(docker ps --filter ancestor=jupyter_base:latest --format "{{.Names}}")
	docker exec -i -t $image_name /bin/bash
	;;
	*) 
	echo "invalid command. use -h to see available commands "
	exit 1
esac


