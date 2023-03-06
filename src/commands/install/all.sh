#!/bin/bash

# Run install scripts.
bash awscli.sh
bash rclone.sh
bash docker.sh
bash rclone-plugin.sh
bash python.sh
bash ../package/python.sh
bash r.sh
bash rstudio.sh
bash ../package/r.sh
bash spark.sh
#bash julia.sh
#bash ../package/julia.sh
bash rust.sh
bash gh.sh
