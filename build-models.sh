#!/bin/bash

for file in $(find . -name "*Modelfile"); do
    # Extract just the filename and print it on a new line
    filename="${file##*/}"
    modelname="${filename/.Modelfile/}"
   
    echo "> Build ${modelname}" 
    ollama create "${modelname}" -f "${filename}"   
    echo
done

