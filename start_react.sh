#!/bin/sh

file=./node_modules
if [ -d "$file" ]
then
    npm start
else
    echo "$file not found."
    echo "Installing node modules..."
    npm install
    npm start
fi