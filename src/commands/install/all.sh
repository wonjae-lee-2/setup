#!/bin/bash

# Run install scripts.
bash docker.sh
bash python.sh
bash ../package/python.sh
bash r.sh
bash ../package/r.sh
bash julia.sh
bash ../package/julia.sh
bash rust.sh
bash kubectl.sh
bash spark.sh
bash helm.sh
