#!/bin/bash


	sudo docker rm -f hadoop-slave1 &> /dev/null
	echo "start hadoop-slave1 container..."
	sudo docker run -itd \
	                --net=adoop-net \
	                --name hadoop-slave1 \
	                --hostname hadoop-slave1 \
	                vahid/hadoop:1.0 &> /dev/null

					
